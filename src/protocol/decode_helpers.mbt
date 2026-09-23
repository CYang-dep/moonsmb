///|
/// Decode a bounded 16-bit little-endian field at a caller-specified offset.
pub fn decode_u16(bytes : Bytes, offset : Int) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, offset) {
    Some(value) => Ok(value)
    None => Err(Truncated(offset, 2, bytes.length()))
  }
}

///|
pub fn decode_u32(bytes : Bytes, offset : Int) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, offset) {
    Some(value) => Ok(value)
    None => Err(Truncated(offset, 4, bytes.length()))
  }
}

///|
pub fn decode_u64(bytes : Bytes, offset : Int) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, offset) {
    Some(value) => Ok(value)
    None => Err(Truncated(offset, 8, bytes.length()))
  }
}

///|
test "bounded field decoding" {
  let bytes : Bytes = b"\x01\x00\x02\x00"
  assert_true(decode_u16(bytes, 0) is Ok(1U))
  assert_true(decode_u16(bytes, 2) is Ok(2U))
  assert_true(decode_u32(bytes, 1) is Err(_))
  assert_true(decode_u64(bytes, 0) is Err(_))
  assert_true(decode_u16(bytes, -1) is Err(_))
}
