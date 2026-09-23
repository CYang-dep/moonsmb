///|
pub struct Tree {
  tree_id : UInt
  share_name : String
  share_type : UInt
}

///|
pub struct FileHandle {
  persistent : UInt64
  volatile_id : UInt64
}

///|
pub fn tree(tree_id : UInt, share_name : String, share_type : UInt) -> Tree {
  { tree_id, share_name, share_type, }
}

///|
pub fn file_handle(persistent : UInt64, volatile_id : UInt64) -> FileHandle {
  { persistent, volatile_id, }
}

///|
pub fn is_zero_handle(value : FileHandle) -> Bool {
  value.persistent == 0UL && value.volatile_id == 0UL
}

///|
pub fn same_handle(left : FileHandle, right : FileHandle) -> Bool {
  left.persistent == right.persistent && left.volatile_id == right.volatile_id
}
