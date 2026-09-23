///|
/// Little-endian integer reader and safe byte slicing helpers.
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
pub fn read_u64(bytes : Bytes, offset : Int) -> UInt64? {
  match (read_u32(bytes, offset), read_u32(bytes, offset + 4)) {
    (Some(low), Some(high)) => Some(low.to_uint64() | (high.to_uint64() << 32))
    _ => None
  }
}

///|
pub fn slice(bytes : Bytes, offset : Int, length : Int) -> Bytes? {
  if offset < 0 || length < 0 || offset + length > bytes.length() {
    None
  } else {
    Some(bytes[offset:offset + length].to_owned())
  }
}
