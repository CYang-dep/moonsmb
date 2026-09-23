///|
/// Common SMB2 wire constants and field predicates.
pub const COMMAND_NEGOTIATE : UInt = 0U

///|
pub const COMMAND_SESSION_SETUP : UInt = 1U

///|
pub const COMMAND_LOGOFF : UInt = 2U

///|
pub const COMMAND_TREE_CONNECT : UInt = 3U

///|
pub const COMMAND_TREE_DISCONNECT : UInt = 4U

///|
pub const COMMAND_CREATE : UInt = 5U

///|
pub const COMMAND_CLOSE : UInt = 6U

///|
pub const COMMAND_FLUSH : UInt = 7U

///|
pub const COMMAND_READ : UInt = 8U

///|
pub const COMMAND_WRITE : UInt = 9U

///|
pub const COMMAND_LOCK : UInt = 10U

///|
pub const COMMAND_IOCTL : UInt = 11U

///|
pub const COMMAND_CANCEL : UInt = 12U

///|
pub const COMMAND_ECHO : UInt = 13U

///|
pub const COMMAND_QUERY_DIRECTORY : UInt = 14U

///|
pub const COMMAND_QUERY_INFO : UInt = 16U

///|
pub const COMMAND_SET_INFO : UInt = 17U

///|
pub const COMMAND_OPLOCK_BREAK : UInt = 18U

///|
pub const CAPABILITY_DFS : UInt = 1U

///|
pub const CAPABILITY_LEASING : UInt = 2U

///|
pub const CAPABILITY_LARGE_MTU : UInt = 4U

///|
pub const CAPABILITY_MULTI_CHANNEL : UInt = 8U

///|
pub const CAPABILITY_PERSISTENT_HANDLES : UInt = 16U

///|
pub const CAPABILITY_DIRECTORY_LEASING : UInt = 32U

///|
pub const CAPABILITY_ENCRYPTION : UInt = 64U

///|
pub const CAPABILITY_NOTIFICATIONS : UInt = 128U

///|
pub fn has_flag(value : UInt, flag : UInt) -> Bool {
  (value & flag) != 0U
}

///|
pub fn add_flag(value : UInt, flag : UInt) -> UInt {
  value | flag
}

///|
pub fn remove_flag(value : UInt, flag : UInt) -> UInt {
  value ^ (value & flag)
}

///|
test "wire helper predicates" {
  assert_true(has_flag(CAPABILITY_DFS | CAPABILITY_ENCRYPTION, CAPABILITY_DFS))
  assert_eq(remove_flag(7U, 2U), 5U)
  assert_eq(remove_flag(1U, 2U), 1U)
}
