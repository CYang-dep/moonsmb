///|
/// Packet-level encoders.
///
/// A command body can be encoded independently for fixtures, while these
/// helpers add the SMB2 header and compound alignment required on the wire.
pub fn encode_frame(value : Frame) -> Bytes {
  header_bytes(value.header) + value.body
}

///|
pub fn compound_padding(length : Int) -> Int {
  let remainder = length % COMPOUND_ALIGNMENT.reinterpret_as_int()
  if remainder == 0 {
    0
  } else {
    COMPOUND_ALIGNMENT.reinterpret_as_int() - remainder
  }
}

///|
pub fn pad_bytes(bytes : Bytes, alignment : UInt) -> Bytes {
  if alignment == 0U {
    return bytes
  }
  let remainder = bytes.length() % alignment.reinterpret_as_int()
  let padding = if remainder == 0 {
    0
  } else {
    alignment.reinterpret_as_int() - remainder
  }
  if padding == 0 {
    bytes
  } else {
    bytes + Bytes::from_array(Array::make(padding, 0U.to_byte()))
  }
}

///|
pub fn encode_compound(frames : Array[Frame]) -> Result[Bytes, ProtocolError] {
  if frames.length() == 0 {
    return Ok(b"")
  }
  let encoded : Array[Bytes] = []
  for frame in frames {
    match validate_frame_for_command(frame) {
      Err(error) => return Err(error)
      Ok(_) => encoded.push(encode_frame(frame))
    }
  }
  let mut result : Bytes = b""
  for index = 0; index < encoded.length(); index = index + 1 {
    let current = encoded[index]
    if index + 1 < encoded.length() {
      let padded = pad_bytes(current, COMPOUND_ALIGNMENT)
      let next = padded.length().reinterpret_as_uint()
      let rewritten = patch_next_command(padded, next)
      result += rewritten
    } else {
      result += current
    }
  }
  Ok(result)
}

///|
pub fn patch_next_command(packet : Bytes, next : UInt) -> Bytes {
  if packet.length() < HEADER_SIZE {
    packet
  } else {
    let encoded = write_u32(next)
    packet[0:20].to_owned() + encoded + packet[24:packet.length()].to_owned()
  }
}

///|
pub fn packet_header(bytes : Bytes) -> Result[Header, ProtocolError] {
  parse_header(bytes)
}

///|
pub fn packet_body(bytes : Bytes) -> Result[Bytes, ProtocolError] {
  match parse_frame(bytes) {
    Ok(frame) => Ok(frame.body)
    Err(error) => Err(error)
  }
}

///|
pub fn packet_length(frame : Frame) -> UInt {
  (HEADER_SIZE + frame.body.length()).reinterpret_as_uint()
}

///|
pub fn packet_has_signature(bytes : Bytes) -> Bool {
  bytes.length() >= 4 && bytes[0:4] == SMB2_SIGNATURE
}

///|
test "frame encoding round trip" {
  let value = frame(header(8U, 1U, 0U, 4U, 0U, 10UL, 2U, 3UL, 0U, 3U), b"abc")
  let encoded = encode_frame(value)
  assert_eq(encoded.length(), 67)
  assert_true(packet_has_signature(encoded))
  match parse_frame(encoded) {
    Ok(decoded) => assert_eq(decoded.body, b"abc")
    Err(_) => assert_true(false)
  }
}

///|
test "padding and next command patching" {
  assert_eq(compound_padding(64), 0)
  assert_eq(compound_padding(65), 7)
  let packet = header_bytes(header(8U, 1U, 0U, 4U, 0U, 10UL, 2U, 3UL, 0U, 0U))
  let patched = patch_next_command(packet, 72U)
  assert_eq(read_u32(patched, 20), Some(72U))
  assert_eq(pad_bytes(b"abc", 8U).length(), 8)
}
