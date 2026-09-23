///|
/// Decoders for the fixed portions of common SMB2 response bodies.
///
/// These functions intentionally return ProtocolError instead of exposing
/// unchecked offsets. Variable payloads are returned as owned Bytes so a
/// caller can keep a decoded response after releasing its receive buffer.
pub fn decode_negotiate_response(
  body : Bytes,
) -> Result[NegotiateResponse, ProtocolError] {
  if body.length() < 64 {
    return Err(Truncated(0, 64, body.length()))
  }
  let structure_size = decode_u16(body, 0)
  let security_mode = decode_u16(body, 2)
  let dialect = decode_u16(body, 4)
  let capabilities = decode_u32(body, 20)
  let max_transact = decode_u32(body, 24)
  let max_read = decode_u32(body, 28)
  let max_write = decode_u32(body, 32)
  match
    (
      structure_size, security_mode, dialect, capabilities, max_transact, max_read,
      max_write,
    ) {
    (
      Ok(65U),
      Ok(security_mode),
      Ok(dialect),
      Ok(capabilities),
      Ok(max_transact),
      Ok(max_read),
      Ok(max_write),
    ) =>
      Ok(
        negotiate_response(
          dialect, security_mode, capabilities, max_transact, max_read, max_write,
        ),
      )
    (Err(error), _, _, _, _, _, _)
    | (_, Err(error), _, _, _, _, _)
    | (_, _, Err(error), _, _, _, _)
    | (_, _, _, Err(error), _, _, _)
    | (_, _, _, _, Err(error), _, _)
    | (_, _, _, _, _, Err(error), _)
    | (_, _, _, _, _, _, Err(error)) => Err(error)
    _ => Err(InvalidStructureSize(0U))
  }
}

///|
pub fn decode_read_response(
  body : Bytes,
) -> Result[ReadResponse, ProtocolError] {
  if body.length() < 16 {
    return Err(Truncated(0, 16, body.length()))
  }
  let structure_size = decode_u16(body, 0)
  let data_offset = decode_u8(body, 2)
  let data_length = decode_u32(body, 4)
  let data_remaining = decode_u32(body, 8)
  match (structure_size, data_offset, data_length, data_remaining) {
    (Ok(17U), Ok(data_offset), Ok(data_length), Ok(data_remaining)) => {
      let start = data_offset.reinterpret_as_int()
      let length = data_length.reinterpret_as_int()
      match slice(body, start, length) {
        Some(data) => Ok(read_response(data, data_remaining))
        None =>
          Err(
            InvalidOffset(
              data_offset,
              data_length,
              body.length().reinterpret_as_uint(),
            ),
          )
      }
    }
    (Err(error), _, _, _)
    | (_, Err(error), _, _)
    | (_, _, Err(error), _)
    | (_, _, _, Err(error)) => Err(error)
    _ => Err(InvalidStructureSize(0U))
  }
}

///|
pub fn decode_close_response(body : Bytes) -> Result[UInt, ProtocolError] {
  match decode_u16(body, 0) {
    Ok(24U) => decode_u16(body, 2)
    Ok(value) => Err(InvalidStructureSize(value))
    Err(error) => Err(error)
  }
}

///|
pub fn decode_tree_connect_response(
  body : Bytes,
) -> Result[UInt, ProtocolError] {
  match decode_u16(body, 0) {
    Ok(16U) => decode_u8(body, 2)
    Ok(value) => Err(InvalidStructureSize(value))
    Err(error) => Err(error)
  }
}

///|
pub fn decode_u8(bytes : Bytes, offset : Int) -> Result[UInt, ProtocolError] {
  if offset < 0 || offset >= bytes.length() {
    Err(Truncated(offset, 1, bytes.length()))
  } else {
    Ok(bytes.unsafe_get(offset).to_uint())
  }
}

///|
test "decode negotiate response fields" {
  let body = Array::make(64, 0U.to_byte())
  body[0] = 65U.to_byte()
  body[2] = 1U.to_byte()
  body[4] = 0x11U.to_byte()
  body[5] = 0x03U.to_byte()
  body[20] = 0x40U.to_byte()
  body[24] = 0x00U.to_byte()
  body[25] = 0x10U.to_byte()
  let decoded = decode_negotiate_response(Bytes::from_array(body))
  match decoded {
    Ok(value) => {
      assert_eq(value.dialect, 0x0311U)
      assert_eq(value.max_transact, 0x1000U)
    }
    Err(_) => assert_true(false)
  }
}

///|
test "decode read response payload" {
  let body = Array::make(19, 0U.to_byte())
  body[0] = 17U.to_byte()
  body[2] = 16U.to_byte()
  body[4] = 3U.to_byte()
  body[16] = 65U.to_byte()
  body[17] = 66U.to_byte()
  body[18] = 67U.to_byte()
  match decode_read_response(Bytes::from_array(body)) {
    Ok(value) => assert_eq(value.data, b"ABC")
    Err(_) => assert_true(false)
  }
}
