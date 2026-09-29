///|
fn main {
  let payload = b"MoonSMB"
  let response = @smb.read_response(payload, 0U)
  println("status: " + @smb.status_summary(0U))
  println("bytes returned: " + @smb.read_data(response).length().to_string())
  println("complete: " + @smb.read_is_complete(response).to_string())
}
