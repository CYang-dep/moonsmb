///|
/// SMB2 command identifiers.
pub enum Command {
  Negotiate
  SessionSetup
  Logoff
  TreeConnect
  TreeDisconnect
  Create
  Close
  Flush
  Read
  Write
  Lock
  Ioctl
  Cancel
  Echo
  QueryDirectory
  QueryInfo
  SetInfo
  OplockBreak
} derive(Eq, Debug)

///|
pub fn Command::from_raw(value : UInt) -> Command? {
  match value {
    0U => Some(Negotiate)
    1U => Some(SessionSetup)
    2U => Some(Logoff)
    3U => Some(TreeConnect)
    4U => Some(TreeDisconnect)
    5U => Some(Create)
    6U => Some(Close)
    7U => Some(Flush)
    8U => Some(Read)
    9U => Some(Write)
    10U => Some(Lock)
    11U => Some(Ioctl)
    12U => Some(Cancel)
    13U => Some(Echo)
    14U => Some(QueryDirectory)
    16U => Some(QueryInfo)
    17U => Some(SetInfo)
    18U => Some(OplockBreak)
    _ => None
  }
}

///|
pub fn Command::raw(self : Command) -> UInt {
  match self {
    Negotiate => 0U
    SessionSetup => 1U
    Logoff => 2U
    TreeConnect => 3U
    TreeDisconnect => 4U
    Create => 5U
    Close => 6U
    Flush => 7U
    Read => 8U
    Write => 9U
    Lock => 10U
    Ioctl => 11U
    Cancel => 12U
    Echo => 13U
    QueryDirectory => 14U
    QueryInfo => 16U
    SetInfo => 17U
    OplockBreak => 18U
  }
}

///|
/// SMB2 protocol header, decoded independently from a command body.
pub struct Header {
  command : Command?
  command_raw : UInt
  credit_charge : UInt
  status : UInt
  credits : UInt
  flags : UInt
  message_id : UInt64
  tree_id : UInt
  session_id : UInt64
  next_command : UInt
  body_length : UInt
}

///|
pub struct Frame {
  header : Header
  body : Bytes
}

///|
pub fn header(
  command_raw : UInt,
  credit_charge : UInt,
  status : UInt,
  credits : UInt,
  flags : UInt,
  message_id : UInt64,
  tree_id : UInt,
  session_id : UInt64,
  next_command : UInt,
  body_length : UInt,
) -> Header {
  {
    command: Command::from_raw(command_raw),
    command_raw,
    credit_charge,
    status,
    credits,
    flags,
    message_id,
    tree_id,
    session_id,
    next_command,
    body_length,
  }
}

///|
pub fn frame(header : Header, body : Bytes) -> Frame {
  { header, body, }
}

///|
pub extend Command with Eq::{not_equal, equal}

///|
pub extend Command with @debug.Debug::{to_repr}
