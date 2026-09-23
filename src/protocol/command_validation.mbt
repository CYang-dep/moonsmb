///|
/// Command-specific structural checks.
///
/// These checks do not authenticate a peer and do not decide whether an
/// operation is authorized. They only verify the invariants that are visible
/// in a decoded SMB2 message before a higher-level client uses its fields.
pub struct BodyRule {
  command : Command
  minimum : Int
  exact : Int?
  variable : Bool
}

///|
pub fn body_rule(command : Command) -> BodyRule {
  match command {
    Negotiate => { command, minimum: 36, exact: None, variable: true, }
    SessionSetup => { command, minimum: 25, exact: None, variable: true, }
    TreeConnect => { command, minimum: 9, exact: None, variable: true, }
    TreeDisconnect => { command, minimum: 4, exact: Some(4), variable: false, }
    Create => { command, minimum: 56, exact: None, variable: true, }
    Close => { command, minimum: 24, exact: Some(24), variable: false, }
    Flush => { command, minimum: 24, exact: Some(24), variable: false, }
    Read => { command, minimum: 49, exact: None, variable: true, }
    Write => { command, minimum: 49, exact: None, variable: true, }
    Lock => { command, minimum: 48, exact: None, variable: true, }
    Ioctl => { command, minimum: 56, exact: None, variable: true, }
    Cancel => { command, minimum: 4, exact: Some(4), variable: false, }
    Echo => { command, minimum: 4, exact: Some(4), variable: false, }
    QueryDirectory => { command, minimum: 33, exact: None, variable: true, }
    QueryInfo => { command, minimum: 41, exact: None, variable: true, }
    SetInfo => { command, minimum: 33, exact: None, variable: true, }
    OplockBreak => { command, minimum: 24, exact: None, variable: true, }
    Logoff => { command, minimum: 4, exact: Some(4), variable: false, }
  }
}

///|
pub fn validate_body_size(
  command : Command,
  length : Int,
) -> Result[Unit, ProtocolError] {
  let rule = body_rule(command)
  if length < rule.minimum {
    Err(Truncated(0, rule.minimum, length))
  } else {
    match rule.exact {
      Some(expected) =>
        if length != expected {
          Err(InvalidStructureSize(length.reinterpret_as_uint()))
        } else {
          Ok(())
        }
      None => Ok(())
    }
  }
}

///|
pub fn validate_command_body(
  command : Command,
  body : Bytes,
) -> Result[Unit, ProtocolError] {
  validate_body_size(command, body.length())
}

///|
pub fn validate_frame_for_command(frame : Frame) -> Result[Unit, ProtocolError] {
  match frame.header.command {
    Some(command) => validate_command_body(command, frame.body)
    None => Err(UnknownCommand(frame.header.command_raw))
  }
}

///|
pub fn is_variable_body(command : Command) -> Bool {
  body_rule(command).variable
}

///|
pub fn minimum_body_size(command : Command) -> UInt {
  body_rule(command).minimum.reinterpret_as_uint()
}

///|
pub fn body_has_payload(command : Command, body : Bytes) -> Bool {
  match validate_command_body(command, body) {
    Ok(_) => body.length() > body_rule(command).minimum
    Err(_) => false
  }
}

///|
pub fn validate_negotiate_body(
  body : NegotiateBody,
) -> Result[Unit, ProtocolError] {
  if body.dialects.length() == 0 {
    Err(InvalidStructureSize(0U))
  } else if body.dialects.length() > 64 {
    Err(InvalidStructureSize(body.dialects.length().reinterpret_as_uint()))
  } else {
    Ok(())
  }
}

///|
pub fn validate_session_setup_body(
  body : SessionSetupBody,
) -> Result[Unit, ProtocolError] {
  if body.token.length() > 65535 {
    Err(InvalidOffset(0U, body.token.length().reinterpret_as_uint(), 65535U))
  } else {
    Ok(())
  }
}

///|
pub fn validate_tree_connect_body(
  body : TreeConnectBody,
) -> Result[Unit, ProtocolError] {
  if body.path.length() == 0 {
    Err(InvalidStructureSize(0U))
  } else if body.path.length() > 32767 {
    Err(InvalidStructureSize(body.path.length().reinterpret_as_uint()))
  } else {
    Ok(())
  }
}

///|
pub fn validate_read_body(body : ReadBody) -> Result[Unit, ProtocolError] {
  if body.length > 8388608U {
    Err(InvalidStructureSize(body.length))
  } else {
    Ok(())
  }
}

///|
pub fn validate_write_body(body : WriteBody) -> Result[Unit, ProtocolError] {
  if body.data.length() > 8388608 {
    Err(InvalidStructureSize(body.data.length().reinterpret_as_uint()))
  } else {
    Ok(())
  }
}

///|
pub fn validate_close_body(body : CloseBody) -> Result[Unit, ProtocolError] {
  if body.file_id.persistent == 0UL && body.file_id.volatile_id == 0UL {
    Err(InvalidStructureSize(body.flags))
  } else {
    Ok(())
  }
}

///|
test "command body rules" {
  assert_eq(minimum_body_size(Command::Read), 49U)
  assert_true(is_variable_body(Command::Read))
  assert_true(!is_variable_body(Command::Close))
  assert_true(validate_body_size(Command::Close, 24) is Ok(_))
  assert_true(validate_body_size(Command::Close, 25) is Err(_))
  assert_true(validate_body_size(Command::Read, 48) is Err(_))
}

///|
test "typed body validation" {
  assert_true(validate_negotiate_body(negotiate_body([], 0U, 0U)) is Err(_))
  assert_true(
    validate_negotiate_body(negotiate_body([0x0311U], 0U, 0U)) is Ok(_),
  )
  assert_true(validate_tree_connect_body(tree_connect_body("")) is Err(_))
  assert_true(
    validate_read_body(read_body(1024U, 0UL, file_handle(1UL, 2UL))) is Ok(_),
  )
  assert_true(
    validate_close_body(close_body(0U, file_handle(0UL, 0UL))) is Err(_),
  )
}
