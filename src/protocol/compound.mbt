///|
/// Split a frame into compound command spans.
pub struct CompoundPart {
  offset : UInt
  length : UInt
}

///|
pub fn compound_parts(
  frame : Frame,
) -> Result[Array[CompoundPart], ProtocolError] {
  let result : Array[CompoundPart] = []
  let mut offset = 0U
  let total = frame.body.length().reinterpret_as_uint()
  while true {
    if offset >= total {
      break
    }
    let remaining = total - offset
    if remaining < HEADER_SIZE.reinterpret_as_uint() {
      return Err(
        Truncated(
          offset.reinterpret_as_int(),
          HEADER_SIZE,
          remaining.reinterpret_as_int(),
        ),
      )
    }
    let next = if offset == 0U { frame.header.next_command } else { 0U }
    let length = if next == 0U { remaining } else { next }
    result.push({ offset, length, })
    if next == 0U {
      break
    }
    offset = offset + next
  }
  Ok(result)
}
