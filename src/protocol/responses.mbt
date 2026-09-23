///|
pub struct NegotiateResponse {
  pub dialect : UInt
  pub security_mode : UInt
  pub capabilities : UInt
  pub max_transact : UInt
  pub max_read : UInt
  pub max_write : UInt
}

///|
pub struct ReadResponse {
  pub data : Bytes
  pub data_remaining : UInt
}

///|
pub struct DirectoryEntry {
  pub name : String
  pub file_id : UInt64
  pub attributes : UInt
  pub end_of_file : UInt64
}

///|
pub struct QueryDirectoryResponse {
  pub entries : Array[DirectoryEntry]
}

///|
pub fn negotiate_response(dialect : UInt, security_mode : UInt, capabilities : UInt, max_transact : UInt, max_read : UInt, max_write : UInt) -> NegotiateResponse {
  { dialect, security_mode, capabilities, max_transact, max_read, max_write }
}

///|
pub fn read_response(data : Bytes, data_remaining : UInt) -> ReadResponse {
  { data, data_remaining }
}

///|
pub fn directory_entry(name : String, file_id : UInt64, attributes : UInt, end_of_file : UInt64) -> DirectoryEntry {
  { name, file_id, attributes, end_of_file }
}

///|
pub fn query_directory_response(entries : Array[DirectoryEntry]) -> QueryDirectoryResponse {
  { entries }
}
