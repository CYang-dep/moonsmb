///|
/// Split a frame into compound command spans.
pub struct CompoundPart {
  pub offset : UInt
  pub length : UInt
}

///|
pub fn compound_parts(frame : Frame) -> Result[Array[CompoundPart], ProtocolError] {
  let mut result : Array[CompoundPart] = []
  let mut offset = 0U
  let total = frame.body.length().to_uint()
  loop {
    if offset >= total { break }
    let remaining = total - offset
    if remaining < HEADER_SIZE.to_uint() { return Err(Truncated { offset: offset.to_int(), needed: HEADER_SIZE, available: remaining.to_int() }) }
    let next = if offset == 0U { frame.header.next_command } else { 0U }
    let length = if next == 0U { remaining } else { next }
    result.push({ offset, length })
    if next == 0U { break }
    offset = offset + next
  }
  Ok(result)
}
