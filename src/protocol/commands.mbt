///|
/// SMB2 negotiate request body.
pub struct NegotiateRequest {
  pub dialects : Array[UInt]
  pub security_mode : UInt
  pub capabilities : UInt
  pub client_guid : Bytes
}

///|
pub struct TreeConnectRequest {
  pub path : String
}

///|
pub struct ReadRequest {
  pub file_id : UInt64
  pub length : UInt
  pub offset : UInt64
}

///|
pub struct WriteRequest {
  pub file_id : UInt64
  pub offset : UInt64
  pub data : Bytes
}

///|
pub struct CloseRequest {
  pub file_id : UInt64
  pub flags : UInt
}

///|
pub fn negotiate_request(dialects : Array[UInt], security_mode : UInt, capabilities : UInt, client_guid : Bytes) -> NegotiateRequest {
  { dialects, security_mode, capabilities, client_guid }
}

///|
pub fn tree_connect_request(path : String) -> TreeConnectRequest {
  { path }
}

///|
pub fn read_request(file_id : UInt64, length : UInt, offset : UInt64) -> ReadRequest {
  { file_id, length, offset }
}

///|
pub fn write_request(file_id : UInt64, offset : UInt64, data : Bytes) -> WriteRequest {
  { file_id, offset, data }
}

///|
pub fn close_request(file_id : UInt64, flags : UInt) -> CloseRequest {
  { file_id, flags }
}
///|
pub fn dialect_name(value : UInt) -> String {
  match value {
    0x0202U => "SMB 2.0.2"
    0x0210U => "SMB 2.1"
    0x0300U => "SMB 3.0"
    0x0302U => "SMB 3.0.2"
    0x0311U => "SMB 3.1.1"
    _ => "UNKNOWN"
  }
}

///|
pub fn supported_dialects() -> Array[UInt] {
  [0x0202U, 0x0210U, 0x0300U, 0x0302U, 0x0311U]
}

///|
pub fn supports_dialect(value : UInt) -> Bool {
  match value {
    0x0202U | 0x0210U | 0x0300U | 0x0302U | 0x0311U => true
    _ => false
  }
}

///|
pub fn negotiate_choice(offered : Array[UInt]) -> UInt? {
  let supported = supported_dialects()
  let mut result : UInt? = None
  for dialect in supported {
    for candidate in offered {
      if dialect == candidate { result = Some(dialect) }
    }
  }
  result
}
