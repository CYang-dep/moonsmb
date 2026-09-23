///|
pub struct Diagnostic {
  pub code : String
  pub offset : Int
  pub message : String
}

///|
pub fn diagnostic(code : String, offset : Int, message : String) -> Diagnostic {
  { code, offset, message }
}

///|
pub fn diagnostic_for(error : ProtocolError) -> Diagnostic {
  match error {
    Truncated { offset, .. } => diagnostic("E_TRUNCATED", offset, error_message(error))
    InvalidSignature => diagnostic("E_SIGNATURE", 0, error_message(error))
    InvalidStructureSize(_) => diagnostic("E_STRUCTURE_SIZE", 4, error_message(error))
    InvalidOffset { offset, .. } => diagnostic("E_OFFSET", offset.to_int(), error_message(error))
    InvalidAlignment(_) => diagnostic("E_ALIGNMENT", 20, error_message(error))
    InvalidNextCommand(_) => diagnostic("E_NEXT_COMMAND", 20, error_message(error))
    UnknownCommand(_) => diagnostic("E_COMMAND", 12, error_message(error))
  }
}
