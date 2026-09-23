///|
pub fn write_u16(value : UInt) -> Bytes {
  Bytes::from_array([value.to_byte(), (value >> 8).to_byte()])
}

///|
pub fn write_u32(value : UInt) -> Bytes {
  Bytes::from_array([
    value.to_byte(),
    (value >> 8).to_byte(),
    (value >> 16).to_byte(),
    (value >> 24).to_byte(),
  ])
}

///|
pub fn write_u64(value : UInt64) -> Bytes {
  Bytes::from_array([
    value.to_byte(),
    (value >> 8).to_byte(),
    (value >> 16).to_byte(),
    (value >> 24).to_byte(),
    (value >> 32).to_byte(),
    (value >> 40).to_byte(),
    (value >> 48).to_byte(),
    (value >> 56).to_byte(),
  ])
}

///|
pub fn header_bytes(value : Header) -> Bytes {
  let result = Array::make(64, 0U.to_byte())
  result[0] = 0xFEU.to_byte()
  result[1] = 0x53U.to_byte()
  result[2] = 0x4DU.to_byte()
  result[3] = 0x42U.to_byte()
  result[4] = 64U.to_byte()
  result[5] = 0U.to_byte()
  result[6] = value.credit_charge.to_byte()
  result[7] = (value.credit_charge >> 8).to_byte()
  result[8] = value.status.to_byte()
  result[9] = (value.status >> 8).to_byte()
  result[10] = (value.status >> 16).to_byte()
  result[11] = (value.status >> 24).to_byte()
  result[12] = value.command_raw.to_byte()
  result[13] = (value.command_raw >> 8).to_byte()
  result[14] = value.credits.to_byte()
  result[15] = (value.credits >> 8).to_byte()
  result[16] = value.flags.to_byte()
  result[17] = (value.flags >> 8).to_byte()
  result[18] = (value.flags >> 16).to_byte()
  result[19] = (value.flags >> 24).to_byte()
  result[20] = value.next_command.to_byte()
  result[21] = (value.next_command >> 8).to_byte()
  result[22] = (value.next_command >> 16).to_byte()
  result[23] = (value.next_command >> 24).to_byte()
  let mid = write_u64(value.message_id)
  let sid = write_u64(value.session_id)
  let tree = write_u32(value.tree_id)
  for i = 0; i < 8; i = i + 1 {
    result[24 + i] = mid[i]
  }
  for i = 0; i < 4; i = i + 1 {
    result[36 + i] = tree[i]
  }
  for i = 0; i < 8; i = i + 1 {
    result[40 + i] = sid[i]
  }
  Bytes::from_array(result)
}
