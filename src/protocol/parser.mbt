///|
/// Parse an SMB2 frame header from a complete byte buffer.
pub fn parse_header(bytes : Bytes) -> Result[Header, ProtocolError] {
  if bytes.length() < HEADER_SIZE {
    Err(Truncated(0, HEADER_SIZE, bytes.length()))
  } else if bytes[0:4] != SMB2_SIGNATURE {
    Err(InvalidSignature)
  } else {
    let structure_size = read_u16(bytes, 4)
    let credit_charge = read_u16(bytes, 6)
    let status = read_u32(bytes, 8)
    let command_raw = read_u16(bytes, 12)
    let credits = read_u16(bytes, 14)
    let flags = read_u32(bytes, 16)
    let next_command = read_u32(bytes, 20)
    let message_id = read_u64(bytes, 24)
    let tree_id = read_u32(bytes, 36)
    let session_id = read_u64(bytes, 40)
    match
      (
        structure_size, credit_charge, status, command_raw, credits, flags, next_command,
        message_id, tree_id, session_id,
      ) {
      (
        Some(64U),
        Some(charge),
        Some(status),
        Some(command_raw),
        Some(credits),
        Some(flags),
        Some(next),
        Some(message_id),
        Some(tree_id),
        Some(session_id),
      ) =>
        if next != 0U && next < HEADER_SIZE.reinterpret_as_uint() {
          Err(InvalidNextCommand(next))
        } else {
          Ok(
            header(
              command_raw,
              charge,
              status,
              credits,
              flags,
              message_id,
              tree_id,
              session_id,
              next,
              (bytes.length() - HEADER_SIZE).reinterpret_as_uint(),
            ),
          )
        }
      (Some(value), _, _, _, _, _, _, _, _, _) =>
        Err(InvalidStructureSize(value))
      _ => Err(Truncated(4, 60, bytes.length() - 4))
    }
  }
}

///|
/// Parse the header and return the body bytes.
pub fn parse_frame(bytes : Bytes) -> Result[Frame, ProtocolError] {
  let parsed = parse_header(bytes)
  match parsed {
    Ok(value) =>
      match slice(bytes, HEADER_SIZE, bytes.length() - HEADER_SIZE) {
        Some(body) => Ok(frame(value, body))
        None => Err(Truncated(HEADER_SIZE, bytes.length() - HEADER_SIZE, 0))
      }
    Err(error) => Err(error)
  }
}
