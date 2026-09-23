///|
/// Stable status predicates used by clients and diagnostic tools.
pub fn status_is_success(code : UInt) -> Bool {
  status_class(code) == Success
}

///|
pub fn status_is_information(code : UInt) -> Bool {
  status_class(code) == Information
}

///|
pub fn status_is_redirection(code : UInt) -> Bool {
  status_class(code) == Redirection
}

///|
pub fn status_is_error(code : UInt) -> Bool {
  status_class(code) == Error
}

///|
pub fn status_is_retryable(code : UInt) -> Bool {
  match code {
    0x00000103U | 0xC00000B5U | 0xC0000120U => true
    _ => false
  }
}

///|
pub fn status_is_missing(code : UInt) -> Bool {
  match code {
    0xC0000034U | 0xC000003AU => true
    _ => false
  }
}

///|
pub fn status_is_permission_failure(code : UInt) -> Bool {
  match code {
    0xC0000022U | 0xC0000043U => true
    _ => false
  }
}

///|
pub fn status_is_terminal(code : UInt) -> Bool {
  status_is_error(code) && !status_is_retryable(code)
}

///|
pub fn status_summary(code : UInt) -> String {
  status_name(code) + " (" + code.to_string() + ")"
}

///|
pub fn classify_status(code : UInt) -> String {
  match status_class(code) {
    Success => "success"
    Information => "information"
    Redirection => "redirection"
    Error => "error"
  }
}

///|
pub fn should_retry(code : UInt, attempts : UInt, maximum : UInt) -> Bool {
  status_is_retryable(code) && attempts < maximum
}

///|
pub fn status_allows_payload(code : UInt) -> Bool {
  !status_is_error(code) || code == 0x80000006U
}

///|
test "status predicates" {
  assert_true(status_is_success(0U))
  assert_true(status_is_error(0xC0000022U))
  assert_true(status_is_permission_failure(0xC0000022U))
  assert_true(status_is_missing(0xC0000034U))
  assert_true(status_is_retryable(0x00000103U))
  assert_true(should_retry(0x00000103U, 1U, 3U))
  assert_true(!should_retry(0x00000103U, 3U, 3U))
  assert_eq(classify_status(0U), "success")
}
