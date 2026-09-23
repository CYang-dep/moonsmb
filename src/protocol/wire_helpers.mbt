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
  value ^ flag
}

///|
pub fn read_field_0(bytes : Bytes) -> UInt? {
  read_u16(bytes, 0)
}

///|
pub fn read_field_1(bytes : Bytes) -> UInt? {
  read_u16(bytes, 2)
}

///|
pub fn read_field_2(bytes : Bytes) -> UInt? {
  read_u16(bytes, 4)
}

///|
pub fn read_field_3(bytes : Bytes) -> UInt? {
  read_u16(bytes, 6)
}

///|
pub fn read_field_4(bytes : Bytes) -> UInt? {
  read_u16(bytes, 8)
}

///|
pub fn read_field_5(bytes : Bytes) -> UInt? {
  read_u16(bytes, 10)
}

///|
pub fn read_field_6(bytes : Bytes) -> UInt? {
  read_u16(bytes, 12)
}

///|
pub fn read_field_7(bytes : Bytes) -> UInt? {
  read_u16(bytes, 14)
}

///|
pub fn read_field_8(bytes : Bytes) -> UInt? {
  read_u16(bytes, 16)
}

///|
pub fn read_field_9(bytes : Bytes) -> UInt? {
  read_u16(bytes, 18)
}

///|
pub fn read_field_10(bytes : Bytes) -> UInt? {
  read_u16(bytes, 20)
}

///|
pub fn read_field_11(bytes : Bytes) -> UInt? {
  read_u16(bytes, 22)
}

///|
pub fn read_field_12(bytes : Bytes) -> UInt? {
  read_u16(bytes, 24)
}

///|
pub fn read_field_13(bytes : Bytes) -> UInt? {
  read_u16(bytes, 26)
}

///|
pub fn read_field_14(bytes : Bytes) -> UInt? {
  read_u16(bytes, 28)
}

///|
pub fn read_field_15(bytes : Bytes) -> UInt? {
  read_u16(bytes, 30)
}

///|
pub fn read_field_16(bytes : Bytes) -> UInt? {
  read_u16(bytes, 32)
}

///|
pub fn read_field_17(bytes : Bytes) -> UInt? {
  read_u16(bytes, 34)
}

///|
pub fn read_field_18(bytes : Bytes) -> UInt? {
  read_u16(bytes, 36)
}

///|
pub fn read_field_19(bytes : Bytes) -> UInt? {
  read_u16(bytes, 38)
}

///|
pub fn read_field_20(bytes : Bytes) -> UInt? {
  read_u16(bytes, 40)
}

///|
pub fn read_field_21(bytes : Bytes) -> UInt? {
  read_u16(bytes, 42)
}

///|
pub fn read_field_22(bytes : Bytes) -> UInt? {
  read_u16(bytes, 44)
}

///|
pub fn read_field_23(bytes : Bytes) -> UInt? {
  read_u16(bytes, 46)
}

///|
pub fn read_field_24(bytes : Bytes) -> UInt? {
  read_u16(bytes, 48)
}

///|
pub fn read_field_25(bytes : Bytes) -> UInt? {
  read_u16(bytes, 50)
}

///|
pub fn read_field_26(bytes : Bytes) -> UInt? {
  read_u16(bytes, 52)
}

///|
pub fn read_field_27(bytes : Bytes) -> UInt? {
  read_u16(bytes, 54)
}

///|
pub fn read_field_28(bytes : Bytes) -> UInt? {
  read_u16(bytes, 56)
}

///|
pub fn read_field_29(bytes : Bytes) -> UInt? {
  read_u16(bytes, 58)
}

///|
pub fn read_field_30(bytes : Bytes) -> UInt? {
  read_u16(bytes, 60)
}

///|
pub fn read_field_31(bytes : Bytes) -> UInt? {
  read_u16(bytes, 62)
}

///|
pub fn read_word_0(bytes : Bytes) -> UInt? {
  read_u32(bytes, 0)
}

///|
pub fn read_word_1(bytes : Bytes) -> UInt? {
  read_u32(bytes, 4)
}

///|
pub fn read_word_2(bytes : Bytes) -> UInt? {
  read_u32(bytes, 8)
}

///|
pub fn read_word_3(bytes : Bytes) -> UInt? {
  read_u32(bytes, 12)
}

///|
pub fn read_word_4(bytes : Bytes) -> UInt? {
  read_u32(bytes, 16)
}

///|
pub fn read_word_5(bytes : Bytes) -> UInt? {
  read_u32(bytes, 20)
}

///|
pub fn read_word_6(bytes : Bytes) -> UInt? {
  read_u32(bytes, 24)
}

///|
pub fn read_word_7(bytes : Bytes) -> UInt? {
  read_u32(bytes, 28)
}

///|
pub fn read_word_8(bytes : Bytes) -> UInt? {
  read_u32(bytes, 32)
}

///|
pub fn read_word_9(bytes : Bytes) -> UInt? {
  read_u32(bytes, 36)
}

///|
pub fn read_word_10(bytes : Bytes) -> UInt? {
  read_u32(bytes, 40)
}

///|
pub fn read_word_11(bytes : Bytes) -> UInt? {
  read_u32(bytes, 44)
}

///|
pub fn read_word_12(bytes : Bytes) -> UInt? {
  read_u32(bytes, 48)
}

///|
pub fn read_word_13(bytes : Bytes) -> UInt? {
  read_u32(bytes, 52)
}

///|
pub fn read_word_14(bytes : Bytes) -> UInt? {
  read_u32(bytes, 56)
}

///|
pub fn read_word_15(bytes : Bytes) -> UInt? {
  read_u32(bytes, 60)
}

///|
pub fn read_word_16(bytes : Bytes) -> UInt? {
  read_u32(bytes, 64)
}

///|
pub fn read_word_17(bytes : Bytes) -> UInt? {
  read_u32(bytes, 68)
}

///|
pub fn read_word_18(bytes : Bytes) -> UInt? {
  read_u32(bytes, 72)
}

///|
pub fn read_word_19(bytes : Bytes) -> UInt? {
  read_u32(bytes, 76)
}

///|
pub fn read_word_20(bytes : Bytes) -> UInt? {
  read_u32(bytes, 80)
}

///|
pub fn read_word_21(bytes : Bytes) -> UInt? {
  read_u32(bytes, 84)
}

///|
pub fn read_word_22(bytes : Bytes) -> UInt? {
  read_u32(bytes, 88)
}

///|
pub fn read_word_23(bytes : Bytes) -> UInt? {
  read_u32(bytes, 92)
}

///|
pub fn read_qword_0(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 0)
}

///|
pub fn read_qword_1(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 8)
}

///|
pub fn read_qword_2(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 16)
}

///|
pub fn read_qword_3(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 24)
}

///|
pub fn read_qword_4(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 32)
}

///|
pub fn read_qword_5(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 40)
}

///|
pub fn read_qword_6(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 48)
}

///|
pub fn read_qword_7(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 56)
}

///|
pub fn read_qword_8(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 64)
}

///|
pub fn read_qword_9(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 72)
}

///|
pub fn read_qword_10(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 80)
}

///|
pub fn read_qword_11(bytes : Bytes) -> UInt64? {
  read_u64(bytes, 88)
}

///|
test "wire helper predicates" {
  assert_true(has_flag(CAPABILITY_DFS | CAPABILITY_ENCRYPTION, CAPABILITY_DFS))
  assert_eq(remove_flag(7U, 2U), 5U)
}
