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
