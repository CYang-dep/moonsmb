///|
pub const CAP_DFS : UInt = 0x00000001U
pub const CAP_LEASING : UInt = 0x00000002U
pub const CAP_LARGE_MTU : UInt = 0x00000004U
pub const CAP_MULTI_CHANNEL : UInt = 0x00000008U
pub const CAP_PERSISTENT_HANDLES : UInt = 0x00000010U
pub const CAP_DIRECTORY_LEASING : UInt = 0x00000020U
pub const CAP_ENCRYPTION : UInt = 0x00000040U
pub const CAP_NOTIFICATIONS : UInt = 0x00000080U

///|
pub struct Capabilities {
  pub raw : UInt
}

///|
pub fn capabilities(raw : UInt) -> Capabilities { { raw } }

///|
pub fn has_capability(value : Capabilities, capability : UInt) -> Bool {
  (value.raw & capability) != 0U
}

///|
pub fn capability_names(value : Capabilities) -> Array[String] {
  let mut result = []
  if has_capability(value, CAP_DFS) { result.push("DFS") }
  if has_capability(value, CAP_LEASING) { result.push("LEASING") }
  if has_capability(value, CAP_LARGE_MTU) { result.push("LARGE_MTU") }
  if has_capability(value, CAP_MULTI_CHANNEL) { result.push("MULTI_CHANNEL") }
  if has_capability(value, CAP_PERSISTENT_HANDLES) { result.push("PERSISTENT_HANDLES") }
  if has_capability(value, CAP_DIRECTORY_LEASING) { result.push("DIRECTORY_LEASING") }
  if has_capability(value, CAP_ENCRYPTION) { result.push("ENCRYPTION") }
  if has_capability(value, CAP_NOTIFICATIONS) { result.push("NOTIFICATIONS") }
  result
}
