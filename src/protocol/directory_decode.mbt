///|
/// Decode the fixed fields of FILE_ID_BOTH_DIR_INFORMATION records.
///
/// Directory names are UTF-16LE on the wire. The protocol package keeps the
/// byte span available to callers and uses a stable placeholder for names
/// until a Unicode adapter is selected by the application.
pub struct DirectoryRecordSpan {
  next : UInt
  name_offset : UInt
  name_length : UInt
  file_id : UInt64
  attributes : UInt
  end_of_file : UInt64
}

///|
pub fn directory_record_span(
  body : Bytes,
  offset : Int,
) -> Result[DirectoryRecordSpan, ProtocolError] {
  if offset < 0 || offset >= body.length() {
    return Err(Truncated(offset, 1, body.length()))
  }
  let minimum = 104
  if body.length() - offset < minimum {
    return Err(Truncated(offset, minimum, body.length() - offset))
  }
  let next = decode_u32(body, offset)
  let file_id = decode_u64(body, offset + 16)
  let end_of_file = decode_u64(body, offset + 40)
  let attributes = decode_u32(body, offset + 56)
  let name_length = decode_u32(body, offset + 60)
  match (next, file_id, end_of_file, attributes, name_length) {
    (Ok(next), Ok(file_id), Ok(end_of_file), Ok(attributes), Ok(name_length)) => {
      let name_offset = offset + 104
      let name_end = name_offset + name_length.reinterpret_as_int()
      if name_length % 2U != 0U || name_end > body.length() {
        Err(
          InvalidOffset(
            name_offset.reinterpret_as_uint(),
            name_length,
            body.length().reinterpret_as_uint(),
          ),
        )
      } else {
        Ok({
          next,
          name_offset: name_offset.reinterpret_as_uint(),
          name_length,
          file_id,
          attributes,
          end_of_file,
        })
      }
    }
    (Err(error), _, _, _, _)
    | (_, Err(error), _, _, _)
    | (_, _, Err(error), _, _)
    | (_, _, _, Err(error), _)
    | (_, _, _, _, Err(error)) => Err(error)
  }
}

///|
pub fn directory_record_name_bytes(
  body : Bytes,
  record : DirectoryRecordSpan,
) -> Result[Bytes, ProtocolError] {
  match
    slice(
      body,
      record.name_offset.reinterpret_as_int(),
      record.name_length.reinterpret_as_int(),
    ) {
    Some(value) => Ok(value)
    None =>
      Err(
        InvalidOffset(
          record.name_offset,
          record.name_length,
          body.length().reinterpret_as_uint(),
        ),
      )
  }
}

///|
pub fn directory_entry_from_record(
  body : Bytes,
  record : DirectoryRecordSpan,
) -> Result[DirectoryEntry, ProtocolError] {
  match directory_record_name_bytes(body, record) {
    Ok(_) =>
      Ok(
        directory_entry(
          "utf16le@" + record.name_offset.to_string(),
          record.file_id,
          record.attributes,
          record.end_of_file,
        ),
      )
    Err(error) => Err(error)
  }
}

///|
pub fn decode_directory_records(
  body : Bytes,
) -> Result[QueryDirectoryResponse, ProtocolError] {
  let result : Array[DirectoryEntry] = []
  let mut offset = 0
  while offset < body.length() {
    match directory_record_span(body, offset) {
      Err(error) => return Err(error)
      Ok(record) => {
        match directory_entry_from_record(body, record) {
          Err(error) => return Err(error)
          Ok(entry) => result.push(entry)
        }
        if record.next == 0U {
          offset = body.length()
        } else if record.next.reinterpret_as_int() < 104 {
          return Err(InvalidNextCommand(record.next))
        } else {
          offset = offset + record.next.reinterpret_as_int()
        }
      }
    }
  }
  Ok(query_directory_response(result))
}

///|
test "directory record bounds" {
  let body = Array::make(104, 0U.to_byte())
  body[60] = 0U.to_byte()
  body[61] = 0U.to_byte()
  body[62] = 0U.to_byte()
  body[63] = 0U.to_byte()
  match directory_record_span(Bytes::from_array(body), 0) {
    Ok(value) => assert_eq(value.name_length, 0U)
    Err(_) => assert_true(false)
  }
}

///|
test "directory record rejects odd UTF16 length" {
  let body = Array::make(105, 0U.to_byte())
  body[60] = 1U.to_byte()
  assert_true(directory_record_span(Bytes::from_array(body), 0) is Err(_))
}
