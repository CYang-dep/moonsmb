///|
/// Small response accessors keep callers independent from record layout.
pub fn negotiate_dialect(value : NegotiateResponse) -> UInt {
  value.dialect
}

///|
pub fn negotiate_security_mode(value : NegotiateResponse) -> UInt {
  value.security_mode
}

///|
pub fn negotiate_capabilities(value : NegotiateResponse) -> Capabilities {
  capabilities(value.capabilities)
}

///|
pub fn negotiate_max_transact(value : NegotiateResponse) -> UInt {
  value.max_transact
}

///|
pub fn negotiate_max_read(value : NegotiateResponse) -> UInt {
  value.max_read
}

///|
pub fn negotiate_max_write(value : NegotiateResponse) -> UInt {
  value.max_write
}

///|
pub fn read_data(value : ReadResponse) -> Bytes {
  value.data
}

///|
pub fn read_data_remaining(value : ReadResponse) -> UInt {
  value.data_remaining
}

///|
pub fn read_is_complete(value : ReadResponse) -> Bool {
  value.data_remaining == 0U
}

///|
pub fn directory_name(value : DirectoryEntry) -> String {
  value.name
}

///|
pub fn directory_file_id(value : DirectoryEntry) -> UInt64 {
  value.file_id
}

///|
pub fn directory_attributes(value : DirectoryEntry) -> UInt {
  value.attributes
}

///|
pub fn directory_size(value : DirectoryEntry) -> UInt64 {
  value.end_of_file
}

///|
pub fn directory_is_directory(value : DirectoryEntry) -> Bool {
  (value.attributes & 0x10U) != 0U
}

///|
pub fn query_directory_entries(
  value : QueryDirectoryResponse,
) -> Array[DirectoryEntry] {
  value.entries
}

///|
pub fn query_directory_is_empty(value : QueryDirectoryResponse) -> Bool {
  value.entries.length() == 0
}

///|
pub fn query_directory_count(value : QueryDirectoryResponse) -> UInt {
  value.entries.length().reinterpret_as_uint()
}

///|
test "response accessors" {
  let response = read_response(b"data", 0U)
  assert_eq(read_data(response), b"data")
  assert_true(read_is_complete(response))
  let entry = directory_entry("x", 3UL, 0x10U, 12UL)
  assert_true(directory_is_directory(entry))
  assert_eq(directory_size(entry), 12UL)
  assert_true(query_directory_is_empty(query_directory_response([])))
  assert_eq(query_directory_count(query_directory_response([])), 0U)
}
