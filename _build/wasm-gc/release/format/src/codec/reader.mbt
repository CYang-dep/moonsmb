///|
/// Read a little-endian unsigned 16-bit value.
pub fn read_u16(bytes : Bytes, offset : Int) -> UInt? {
  if offset < 0 || offset + 2 > bytes.length() {
    None
  } else {
    Some(
      bytes.unsafe_get(offset).to_uint() |
      (bytes.unsafe_get(offset + 1).to_uint() << 8),
    )
  }
}

///|
/// Read a little-endian unsigned 32-bit value.
pub fn read_u32(bytes : Bytes, offset : Int) -> UInt? {
  if offset < 0 || offset + 4 > bytes.length() {
    None
  } else {
    let b0 = bytes.unsafe_get(offset).to_uint()
    let b1 = bytes.unsafe_get(offset + 1).to_uint()
    let b2 = bytes.unsafe_get(offset + 2).to_uint()
    let b3 = bytes.unsafe_get(offset + 3).to_uint()
    Some(b0 | (b1 << 8) | (b2 << 16) | (b3 << 24))
  }
}

///|
/// Read a little-endian unsigned 64-bit value.
pub fn read_u64(bytes : Bytes, offset : Int) -> UInt64? {
  if offset < 0 || offset + 8 > bytes.length() {
    None
  } else {
    let low = read_u32(bytes, offset)
    let high = read_u32(bytes, offset + 4)
    match (low, high) {
      (Some(low), Some(high)) =>
        Some(low.to_uint64() | (high.to_uint64() << 32))
      _ => None
    }
  }
}

///|
/// Read a bounded byte region without copying.
pub fn slice(bytes : Bytes, offset : Int, length : Int) -> Bytes? {
  if offset < 0 || length < 0 || offset + length > bytes.length() {
    None
  } else {
    Some(bytes[offset:offset + length])
  }
}
