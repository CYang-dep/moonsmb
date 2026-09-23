///|
pub struct Tree {
  pub tree_id : UInt
  pub share_name : String
  pub share_type : UInt
}

///|
pub struct FileHandle {
  pub persistent : UInt64
  pub volatile : UInt64
}

///|
pub fn tree(tree_id : UInt, share_name : String, share_type : UInt) -> Tree { { tree_id, share_name, share_type } }

///|
pub fn file_handle(persistent : UInt64, volatile : UInt64) -> FileHandle { { persistent, volatile } }

///|
pub fn is_zero_handle(value : FileHandle) -> Bool { value.persistent == 0UL && value.volatile == 0UL }

///|
pub fn same_handle(left : FileHandle, right : FileHandle) -> Bool {
  left.persistent == right.persistent && left.volatile == right.volatile
}
