///|
pub fn command_name(command : Command?) -> String {
  match command {
    Some(Negotiate) => "NEGOTIATE"
    Some(SessionSetup) => "SESSION_SETUP"
    Some(Logoff) => "LOGOFF"
    Some(TreeConnect) => "TREE_CONNECT"
    Some(TreeDisconnect) => "TREE_DISCONNECT"
    Some(Create) => "CREATE"
    Some(Close) => "CLOSE"
    Some(Flush) => "FLUSH"
    Some(Read) => "READ"
    Some(Write) => "WRITE"
    Some(Lock) => "LOCK"
    Some(Ioctl) => "IOCTL"
    Some(Cancel) => "CANCEL"
    Some(Echo) => "ECHO"
    Some(QueryDirectory) => "QUERY_DIRECTORY"
    Some(QueryInfo) => "QUERY_INFO"
    Some(SetInfo) => "SET_INFO"
    Some(OplockBreak) => "OPLOCK_BREAK"
    None => "UNKNOWN"
  }
}

///|
pub fn frame_summary(value : Frame) -> String {
  let status_value = status(value.header.status)
  "SMB2 " + command_name(value.header.command) + " mid=" + value.header.message_id.to_string() + " status=" + status_value.name + " body=" + value.body.length().to_string()
}
