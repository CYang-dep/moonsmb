///|
/// Validate a relative payload span in an SMB2 command body.
pub fn validate_span(
  offset : UInt,
  length : UInt,
  frame_length : UInt,
) -> Result[Unit, ProtocolError] {
  if offset > frame_length || length > frame_length - offset {
    Err(InvalidOffset(offset, length, frame_length))
  } else {
    Ok(())
  }
}

///|
pub fn validate_alignment(value : UInt) -> Result[Unit, ProtocolError] {
  if value % COMPOUND_ALIGNMENT == 0U {
    Ok(())
  } else {
    Err(InvalidAlignment(value))
  }
}

///|
pub fn validate_next_command(
  next : UInt,
  frame_length : UInt,
) -> Result[Unit, ProtocolError] {
  if next == 0U {
    Ok(())
  } else if next >= HEADER_SIZE.reinterpret_as_uint() && next < frame_length {
    validate_alignment(next)
  } else {
    Err(InvalidNextCommand(next))
  }
}

///|
pub fn validate_header(
  value : Header,
  frame_length : UInt,
) -> Result[Unit, ProtocolError] {
  match value.command {
    Some(_) => validate_next_command(value.next_command, frame_length)
    None => Err(UnknownCommand(value.command_raw))
  }
}
