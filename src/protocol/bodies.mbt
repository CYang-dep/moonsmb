///|
/// SMB2 command body helpers for the fixed-layout requests used by clients.
/// The functions deliberately expose offsets and lengths so callers can compose
/// them with a transport-specific packet builder.
pub struct NegotiateBody {
  pub dialects : Array[UInt]
  pub security_mode : UInt
  pub capabilities : UInt
}

///|
pub struct SessionSetupBody {
  pub flags : UInt
  pub security_mode : UInt
  pub capabilities : UInt
  pub channel : UInt
  pub token : Bytes
}

///|
pub struct TreeConnectBody {
  pub path : String
}

///|
pub struct ReadBody {
  pub length : UInt
  pub offset : UInt64
  pub file_id : FileHandle
}

///|
pub struct WriteBody {
  pub offset : UInt64
  pub file_id : FileHandle
  pub data : Bytes
}

///|
pub struct CloseBody {
  pub flags : UInt
  pub file_id : FileHandle
}

///|
pub fn negotiate_body(
  dialects : Array[UInt],
  security_mode : UInt,
  capabilities : UInt,
) -> NegotiateBody {
  { dialects, security_mode, capabilities, }
}

///|
pub fn session_setup_body(
  flags : UInt,
  security_mode : UInt,
  capabilities : UInt,
  channel : UInt,
  token : Bytes,
) -> SessionSetupBody {
  { flags, security_mode, capabilities, channel, token, }
}

///|
pub fn tree_connect_body(path : String) -> TreeConnectBody {
  { path, }
}

///|
pub fn read_body(
  length : UInt,
  offset : UInt64,
  file_id : FileHandle,
) -> ReadBody {
  { length, offset, file_id, }
}

///|
pub fn write_body(
  offset : UInt64,
  file_id : FileHandle,
  data : Bytes,
) -> WriteBody {
  { offset, file_id, data, }
}

///|
pub fn close_body(flags : UInt, file_id : FileHandle) -> CloseBody {
  { flags, file_id, }
}

///|
fn append_u16(out : Array[Byte], value : UInt) -> Unit {
  out.push(value.to_byte())
  out.push((value >> 8).to_byte())
}

///|
fn append_u32(out : Array[Byte], value : UInt) -> Unit {
  out.push(value.to_byte())
  out.push((value >> 8).to_byte())
  out.push((value >> 16).to_byte())
  out.push((value >> 24).to_byte())
}

///|
fn append_u64(out : Array[Byte], value : UInt64) -> Unit {
  append_u32(out, value.to_uint())
  append_u32(out, (value >> 32).to_uint())
}

///|
fn append_bytes(out : Array[Byte], value : Bytes) -> Unit {
  for byte in value {
    out.push(byte)
  }
}

///|
pub fn encode_negotiate(value : NegotiateBody) -> Bytes {
  let out = []
  append_u16(out, 36U)
  append_u16(out, value.dialects.length().to_uint())
  append_u16(out, value.security_mode)
  append_u16(out, 0U)
  append_u32(out, value.capabilities)
  append_u32(out, 0U)
  append_u32(out, 0U)
  append_u64(out, 0UL)
  for dialect in value.dialects {
    append_u16(out, dialect)
  }
  Bytes::from_array(out)
}

///|
pub fn encode_session_setup(value : SessionSetupBody) -> Bytes {
  let out = []
  append_u16(out, 25U)
  append_u8(out, value.flags)
  append_u8(out, value.security_mode)
  append_u32(out, value.capabilities)
  append_u32(out, value.channel)
  append_u16(out, 88U)
  append_u16(out, value.token.length().to_uint())
  append_bytes(out, value.token)
  Bytes::from_array(out)
}

///|
pub fn encode_tree_connect(value : TreeConnectBody) -> Bytes {
  let out = []
  let path = utf16le(value.path)
  append_u16(out, 9U)
  append_u16(out, 0U)
  append_u16(out, 72U)
  append_u16(out, path.length().to_uint())
  append_bytes(out, path)
  Bytes::from_array(out)
}

///|
pub fn encode_read(value : ReadBody) -> Bytes {
  let out = []
  append_u16(out, 49U)
  append_u8(out, 0U)
  append_u8(out, 0U)
  append_u32(out, value.length)
  append_u64(out, value.offset)
  append_u64(out, value.file_id.persistent)
  append_u64(out, value.file_id.volatile_id)
  append_u32(out, 0U)
  append_u32(out, 0U)
  append_u32(out, 0U)
  Bytes::from_array(out)
}

///|
pub fn encode_write(value : WriteBody) -> Bytes {
  let out = []
  append_u16(out, 49U)
  append_u16(out, 112U)
  append_u32(out, value.data.length().to_uint())
  append_u64(out, value.offset)
  append_u64(out, value.file_id.persistent)
  append_u64(out, value.file_id.volatile_id)
  append_u32(out, 0U)
  append_u32(out, 0U)
  append_bytes(out, value.data)
  Bytes::from_array(out)
}

///|
pub fn encode_close(value : CloseBody) -> Bytes {
  let out = []
  append_u16(out, 24U)
  append_u16(out, value.flags)
  append_u32(out, 0U)
  append_u64(out, value.file_id.persistent)
  append_u64(out, value.file_id.volatile_id)
  Bytes::from_array(out)
}

///|
fn append_u8(out : Array[Byte], value : UInt) -> Unit {
  out.push(value.to_byte())
}

///|
fn utf16le(value : String) -> Bytes {
  let out = []
  for ch in value {
    let code = ch.to_int().reinterpret_as_uint()
    append_u16(out, code)
  }
  Bytes::from_array(out)
}

///|
test "body encoders preserve fixed headers" {
  let n = encode_negotiate(negotiate_body([0x0202U, 0x0311U], 1U, 2U))
  assert_eq(read_u16(n, 0), Some(36U))
  assert_eq(read_u16(n, 2), Some(2U))
  let w = encode_write(write_body(4UL, file_handle(1UL, 2UL), b"abc"))
  assert_eq(read_u16(w, 0), Some(49U))
  assert_eq(read_u32(w, 4), Some(3U))
}
