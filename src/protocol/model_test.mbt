///|
test "command round trip" {
  assert_eq(Command::from_raw(Command::Read.raw()), Some(Read))
  assert_eq(Command::from_raw(255U), None)
}

///|
test "safe reader boundaries" {
  let data : Bytes = b"\x01\x02\x03\x04"
  assert_eq(read_u16(data, 0), Some(0x0201U))
  assert_eq(read_u32(data, 0), Some(0x04030201U))
  assert_eq(read_u32(data, 1), None)
  assert_eq(slice(data, 1, 2), Some(b"\x02\x03"))
  assert_eq(slice(data, 3, 2), None)
}

///|
test "status classification" {
  assert_eq(status_class(0U), Success)
  assert_eq(status_name(0xC0000022U), "STATUS_ACCESS_DENIED")
  assert_eq(status_name(0x12345678U), "STATUS_UNKNOWN")
}

///|
test "span validation" {
  assert_true(validate_span(0U, 4U, 8U) is Ok(_))
  assert_true(validate_span(7U, 4U, 8U) is Err(_))
  assert_true(validate_alignment(16U) is Ok(_))
  assert_true(validate_alignment(10U) is Err(_))
}
