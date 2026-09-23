///|
/// Decode complete SMB2 compound packets.
///
/// The SMB2 NextCommand field is an offset from the beginning of the
/// compound packet, not from the beginning of the current body. Keeping that
/// distinction here prevents callers from accidentally accepting a packet
/// whose second command points into the middle of a header.
pub struct DecodedCommand {
  header : Header
  body : Bytes
  packet_offset : UInt
  packet_length : UInt
}

///|
pub fn decoded_command(
  header : Header,
  body : Bytes,
  packet_offset : UInt,
  packet_length : UInt,
) -> DecodedCommand {
  { header, body, packet_offset, packet_length, }
}

///|
pub fn decode_compound(
  bytes : Bytes,
) -> Result[Array[DecodedCommand], ProtocolError] {
  let result : Array[DecodedCommand] = []
  let mut offset = 0
  let total = bytes.length()
  while offset < total {
    let remaining = total - offset
    if remaining < HEADER_SIZE {
      return Err(Truncated(offset, HEADER_SIZE, remaining))
    }
    let packet = slice(bytes, offset, remaining)
    match packet {
      None => return Err(Truncated(offset, remaining, 0))
      Some(packet) =>
        match parse_header(packet) {
          Err(error) => return Err(error)
          Ok(header) => {
            let next = header.next_command.reinterpret_as_int()
            let packet_length = if next == 0 { remaining } else { next }
            if packet_length < HEADER_SIZE || packet_length > remaining {
              return Err(InvalidNextCommand(header.next_command))
            }
            if next != 0 && next % COMPOUND_ALIGNMENT.reinterpret_as_int() != 0 {
              return Err(InvalidAlignment(header.next_command))
            }
            match slice(packet, HEADER_SIZE, packet_length - HEADER_SIZE) {
              None =>
                return Err(
                  Truncated(
                    offset + HEADER_SIZE,
                    packet_length - HEADER_SIZE,
                    0,
                  ),
                )
              Some(body) => {
                result.push(
                  decoded_command(
                    header,
                    body,
                    offset.reinterpret_as_uint(),
                    packet_length.reinterpret_as_uint(),
                  ),
                )
                if next == 0 {
                  offset = total
                } else {
                  offset = offset + next
                }
              }
            }
          }
        }
    }
  }
  Ok(result)
}

///|
pub fn compound_command_count(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match decode_compound(bytes) {
    Ok(commands) => Ok(commands.length().reinterpret_as_uint())
    Err(error) => Err(error)
  }
}

///|
pub fn compound_is_well_formed(bytes : Bytes) -> Bool {
  match decode_compound(bytes) {
    Ok(_) => true
    Err(_) => false
  }
}

///|
test "decode one command packet" {
  let header = header(8U, 1U, 0U, 4U, 0U, 10UL, 2U, 3UL, 0U, 3U)
  let bytes = header_bytes(header) + b"abc"
  match decode_compound(bytes) {
    Ok(commands) => {
      assert_eq(commands.length(), 1)
      assert_eq(commands[0].body, b"abc")
    }
    Err(_) => assert_true(false)
  }
}

///|
test "reject misaligned compound offset" {
  let header = header(8U, 1U, 0U, 4U, 0U, 10UL, 2U, 3UL, 65U, 0U)
  assert_true(!compound_is_well_formed(header_bytes(header)))
}
