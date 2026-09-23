///|
/// Common NT status values used by SMB2 responses.
pub enum StatusClass {
  Success
  Information
  Redirection
  Error
} derive(Eq, Debug)

///|
pub fn status_class(status : UInt) -> StatusClass {
  if status == 0U {
    Success
  } else if (status & 0xC0000000U) == 0x40000000U {
    Information
  } else if (status & 0x80000000U) != 0U {
    Error
  } else {
    Redirection
  }
}

///|
pub fn status_name(status : UInt) -> String {
  match status {
    0x00000000U => "STATUS_SUCCESS"
    0x00000103U => "STATUS_PENDING"
    0xC000000DU => "STATUS_INVALID_PARAMETER"
    0xC000000FU => "STATUS_INVALID_HANDLE"
    0xC0000022U => "STATUS_ACCESS_DENIED"
    0xC0000034U => "STATUS_OBJECT_NAME_NOT_FOUND"
    0xC000003AU => "STATUS_OBJECT_PATH_NOT_FOUND"
    0xC0000043U => "STATUS_SHARING_VIOLATION"
    0xC00000BBU => "STATUS_NOT_SUPPORTED"
    0xC0000103U => "STATUS_DIRECTORY_NOT_EMPTY"
    0x80000006U => "STATUS_NO_MORE_FILES"
    _ => "STATUS_UNKNOWN"
  }
}

///|
pub struct Status {
  code : UInt
  class : StatusClass
  name : String
}

///|
pub fn status(code : UInt) -> Status {
  { code, class: status_class(code), name: status_name(code), }
}
