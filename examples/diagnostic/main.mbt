///|
fn main {
  let malformed = b"\xFE\x53\x4D\x42"
  match @smb.parse_frame(malformed) {
    Ok(value) => println(@smb.frame_summary(value))
    Err(error) => {
      let item = @smb.diagnostic_for(error)
      println("diagnostic: " + item.code)
      println("offset: " + item.offset.to_string())
      println(item.message)
    }
  }
}
