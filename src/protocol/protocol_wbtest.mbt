///|
fn sample_header() -> Header {
  header(0U, 1U, 0U, 32U, 0U, 42UL, 7U, 9UL, 0U, 0U)
}

///|
test "dialect selection" {
  assert_eq(negotiate_choice([0x0311U, 0x0302U]), Some(0x0311U))
  assert_eq(negotiate_choice([0x9999U]), None)
  assert_eq(dialect_name(0x0311U), "SMB 3.1.1")
}

///|
test "status and identifiers" {
  let value = status(0xC0000022U)
  assert_eq(value.name, "STATUS_ACCESS_DENIED")
  let handle = file_handle(1UL, 2UL)
  assert_true(!is_zero_handle(handle))
  assert_true(same_handle(handle, file_handle(1UL, 2UL)))
}

///|
test "frame summary" {
  let value = frame(sample_header(), b"body")
  assert_true(frame_summary(value).contains("NEGOTIATE"))
}
