///|
pub struct Session {
  pub session_id : UInt64
  pub tree_id : UInt
  pub message_id : UInt64
  pub credits : UInt
}

///|
pub fn session(session_id : UInt64, tree_id : UInt, message_id : UInt64, credits : UInt) -> Session {
  { session_id, tree_id, message_id, credits }
}

///|
pub fn next_message(value : Session, credit_charge : UInt) -> Session {
  { value with message_id: value.message_id + 1UL, credits: value.credits + credit_charge }
}

///|
pub fn consume_credits(value : Session, amount : UInt) -> Result[Session, ProtocolError] {
  if amount > value.credits {
    Err(InvalidNextCommand(amount))
  } else {
    Ok({ value with credits: value.credits - amount })
  }
}
