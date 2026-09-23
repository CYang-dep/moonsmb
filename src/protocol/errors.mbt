///|
/// SMB2 protocol signatures and fixed offsets.
pub const SMB2_SIGNATURE : Bytes = b"\xFE\x53\x4D\x42"

///|
pub const HEADER_SIZE : Int = 64

///|
pub const COMPOUND_ALIGNMENT : UInt = 8U

///| 
pub enum ProtocolError {
  Truncated { offset : Int, needed : Int, available : Int }
  InvalidSignature
  InvalidStructureSize(UInt)
  InvalidOffset { offset : UInt, length : UInt, frame_length : UInt }
  InvalidAlignment(UInt)
  InvalidNextCommand(UInt)
  UnknownCommand(UInt)
}

///| 
pub fn error_message(error : ProtocolError) -> String {
  match error {
    Truncated { offset, needed, available } => "truncated SMB2 frame" + offset.to_string() + "/" + needed.to_string() + "/" + available.to_string()
    InvalidSignature => "invalid SMB2 signature"
    InvalidStructureSize(value) => "invalid SMB2 structure size: " + value.to_string()
    InvalidOffset { offset, length, frame_length } => "invalid SMB2 offset: " + offset.to_string() + "/" + length.to_string() + "/" + frame_length.to_string()
    InvalidAlignment(value) => "invalid SMB2 alignment: " + value.to_string()
    InvalidNextCommand(value) => "invalid SMB2 next command: " + value.to_string()
    UnknownCommand(value) => "unknown SMB2 command: " + value.to_string()
  }
}
