///|
fn main {
  let body = @smb.negotiate_body(
    [0x0202U, 0x0210U, 0x0302U, 0x0311U],
    1U,
    @smb.CAP_LARGE_MTU,
  )
  let encoded_body = @smb.encode_negotiate(body)
  let value = @smb.frame(
    @smb.header(
      @smb.COMMAND_NEGOTIATE,
      1U,
      0U,
      1U,
      0U,
      1UL,
      0U,
      0UL,
      0U,
      encoded_body.length().reinterpret_as_uint(),
    ),
    encoded_body,
  )
  let packet = @smb.encode_frame(value)
  println("packet bytes: " + packet.length().to_string())
  println("signature valid: " + @smb.packet_has_signature(packet).to_string())
  println(@smb.frame_summary(@smb.parse_frame(packet).unwrap()))
}
