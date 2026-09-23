///|
pub struct NegotiateResponse {
  dialect : UInt
  security_mode : UInt
  capabilities : UInt
  max_transact : UInt
  max_read : UInt
  max_write : UInt
}

///|
pub struct ReadResponse {
  data : Bytes
  data_remaining : UInt
}

///|
pub struct DirectoryEntry {
  name : String
  file_id : UInt64
  attributes : UInt
  end_of_file : UInt64
}

///|
pub struct QueryDirectoryResponse {
  entries : Array[DirectoryEntry]
}

///|
pub fn negotiate_response(
  dialect : UInt,
  security_mode : UInt,
  capabilities : UInt,
  max_transact : UInt,
  max_read : UInt,
  max_write : UInt,
) -> NegotiateResponse {
  { dialect, security_mode, capabilities, max_transact, max_read, max_write, }
}

///|
pub fn read_response(data : Bytes, data_remaining : UInt) -> ReadResponse {
  { data, data_remaining, }
}

///|
pub fn directory_entry(
  name : String,
  file_id : UInt64,
  attributes : UInt,
  end_of_file : UInt64,
) -> DirectoryEntry {
  { name, file_id, attributes, end_of_file, }
}

///|
pub fn query_directory_response(
  entries : Array[DirectoryEntry],
) -> QueryDirectoryResponse {
  { entries, }
}
