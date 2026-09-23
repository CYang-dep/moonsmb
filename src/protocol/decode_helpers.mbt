///|
/// Bounded accessors used by command decoders. They return None rather than
/// allowing malformed network data to escape into unchecked indexing.
pub fn decode_u16_0(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 0) {
    Some(value) => Ok(value)
    None => Err(Truncated(0, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_1(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 2) {
    Some(value) => Ok(value)
    None => Err(Truncated(2, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_2(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 4) {
    Some(value) => Ok(value)
    None => Err(Truncated(4, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_3(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 6) {
    Some(value) => Ok(value)
    None => Err(Truncated(6, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_4(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 8) {
    Some(value) => Ok(value)
    None => Err(Truncated(8, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_5(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 10) {
    Some(value) => Ok(value)
    None => Err(Truncated(10, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_6(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 12) {
    Some(value) => Ok(value)
    None => Err(Truncated(12, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_7(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 14) {
    Some(value) => Ok(value)
    None => Err(Truncated(14, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_8(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 16) {
    Some(value) => Ok(value)
    None => Err(Truncated(16, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_9(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 18) {
    Some(value) => Ok(value)
    None => Err(Truncated(18, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_10(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 20) {
    Some(value) => Ok(value)
    None => Err(Truncated(20, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_11(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 22) {
    Some(value) => Ok(value)
    None => Err(Truncated(22, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_12(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 24) {
    Some(value) => Ok(value)
    None => Err(Truncated(24, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_13(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 26) {
    Some(value) => Ok(value)
    None => Err(Truncated(26, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_14(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 28) {
    Some(value) => Ok(value)
    None => Err(Truncated(28, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_15(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 30) {
    Some(value) => Ok(value)
    None => Err(Truncated(30, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_16(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 32) {
    Some(value) => Ok(value)
    None => Err(Truncated(32, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_17(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 34) {
    Some(value) => Ok(value)
    None => Err(Truncated(34, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_18(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 36) {
    Some(value) => Ok(value)
    None => Err(Truncated(36, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_19(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 38) {
    Some(value) => Ok(value)
    None => Err(Truncated(38, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_20(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 40) {
    Some(value) => Ok(value)
    None => Err(Truncated(40, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_21(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 42) {
    Some(value) => Ok(value)
    None => Err(Truncated(42, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_22(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 44) {
    Some(value) => Ok(value)
    None => Err(Truncated(44, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_23(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 46) {
    Some(value) => Ok(value)
    None => Err(Truncated(46, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_24(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 48) {
    Some(value) => Ok(value)
    None => Err(Truncated(48, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_25(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 50) {
    Some(value) => Ok(value)
    None => Err(Truncated(50, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_26(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 52) {
    Some(value) => Ok(value)
    None => Err(Truncated(52, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_27(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 54) {
    Some(value) => Ok(value)
    None => Err(Truncated(54, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_28(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 56) {
    Some(value) => Ok(value)
    None => Err(Truncated(56, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_29(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 58) {
    Some(value) => Ok(value)
    None => Err(Truncated(58, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_30(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 60) {
    Some(value) => Ok(value)
    None => Err(Truncated(60, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_31(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 62) {
    Some(value) => Ok(value)
    None => Err(Truncated(62, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_32(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 64) {
    Some(value) => Ok(value)
    None => Err(Truncated(64, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_33(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 66) {
    Some(value) => Ok(value)
    None => Err(Truncated(66, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_34(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 68) {
    Some(value) => Ok(value)
    None => Err(Truncated(68, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_35(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 70) {
    Some(value) => Ok(value)
    None => Err(Truncated(70, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_36(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 72) {
    Some(value) => Ok(value)
    None => Err(Truncated(72, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_37(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 74) {
    Some(value) => Ok(value)
    None => Err(Truncated(74, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_38(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 76) {
    Some(value) => Ok(value)
    None => Err(Truncated(76, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_39(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 78) {
    Some(value) => Ok(value)
    None => Err(Truncated(78, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_40(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 80) {
    Some(value) => Ok(value)
    None => Err(Truncated(80, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_41(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 82) {
    Some(value) => Ok(value)
    None => Err(Truncated(82, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_42(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 84) {
    Some(value) => Ok(value)
    None => Err(Truncated(84, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_43(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 86) {
    Some(value) => Ok(value)
    None => Err(Truncated(86, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_44(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 88) {
    Some(value) => Ok(value)
    None => Err(Truncated(88, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_45(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 90) {
    Some(value) => Ok(value)
    None => Err(Truncated(90, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_46(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 92) {
    Some(value) => Ok(value)
    None => Err(Truncated(92, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_47(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 94) {
    Some(value) => Ok(value)
    None => Err(Truncated(94, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_48(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 96) {
    Some(value) => Ok(value)
    None => Err(Truncated(96, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_49(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 98) {
    Some(value) => Ok(value)
    None => Err(Truncated(98, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_50(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 100) {
    Some(value) => Ok(value)
    None => Err(Truncated(100, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_51(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 102) {
    Some(value) => Ok(value)
    None => Err(Truncated(102, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_52(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 104) {
    Some(value) => Ok(value)
    None => Err(Truncated(104, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_53(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 106) {
    Some(value) => Ok(value)
    None => Err(Truncated(106, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_54(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 108) {
    Some(value) => Ok(value)
    None => Err(Truncated(108, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_55(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 110) {
    Some(value) => Ok(value)
    None => Err(Truncated(110, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_56(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 112) {
    Some(value) => Ok(value)
    None => Err(Truncated(112, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_57(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 114) {
    Some(value) => Ok(value)
    None => Err(Truncated(114, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_58(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 116) {
    Some(value) => Ok(value)
    None => Err(Truncated(116, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_59(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 118) {
    Some(value) => Ok(value)
    None => Err(Truncated(118, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_60(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 120) {
    Some(value) => Ok(value)
    None => Err(Truncated(120, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_61(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 122) {
    Some(value) => Ok(value)
    None => Err(Truncated(122, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_62(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 124) {
    Some(value) => Ok(value)
    None => Err(Truncated(124, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_63(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 126) {
    Some(value) => Ok(value)
    None => Err(Truncated(126, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_64(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 128) {
    Some(value) => Ok(value)
    None => Err(Truncated(128, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_65(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 130) {
    Some(value) => Ok(value)
    None => Err(Truncated(130, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_66(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 132) {
    Some(value) => Ok(value)
    None => Err(Truncated(132, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_67(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 134) {
    Some(value) => Ok(value)
    None => Err(Truncated(134, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_68(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 136) {
    Some(value) => Ok(value)
    None => Err(Truncated(136, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_69(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 138) {
    Some(value) => Ok(value)
    None => Err(Truncated(138, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_70(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 140) {
    Some(value) => Ok(value)
    None => Err(Truncated(140, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_71(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 142) {
    Some(value) => Ok(value)
    None => Err(Truncated(142, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_72(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 144) {
    Some(value) => Ok(value)
    None => Err(Truncated(144, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_73(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 146) {
    Some(value) => Ok(value)
    None => Err(Truncated(146, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_74(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 148) {
    Some(value) => Ok(value)
    None => Err(Truncated(148, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_75(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 150) {
    Some(value) => Ok(value)
    None => Err(Truncated(150, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_76(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 152) {
    Some(value) => Ok(value)
    None => Err(Truncated(152, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_77(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 154) {
    Some(value) => Ok(value)
    None => Err(Truncated(154, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_78(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 156) {
    Some(value) => Ok(value)
    None => Err(Truncated(156, 2, bytes.length()))
  }
}

///|
pub fn decode_u16_79(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u16(bytes, 158) {
    Some(value) => Ok(value)
    None => Err(Truncated(158, 2, bytes.length()))
  }
}

///|
pub fn decode_u32_0(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 0) {
    Some(value) => Ok(value)
    None => Err(Truncated(0, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_1(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 4) {
    Some(value) => Ok(value)
    None => Err(Truncated(4, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_2(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 8) {
    Some(value) => Ok(value)
    None => Err(Truncated(8, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_3(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 12) {
    Some(value) => Ok(value)
    None => Err(Truncated(12, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_4(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 16) {
    Some(value) => Ok(value)
    None => Err(Truncated(16, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_5(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 20) {
    Some(value) => Ok(value)
    None => Err(Truncated(20, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_6(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 24) {
    Some(value) => Ok(value)
    None => Err(Truncated(24, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_7(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 28) {
    Some(value) => Ok(value)
    None => Err(Truncated(28, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_8(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 32) {
    Some(value) => Ok(value)
    None => Err(Truncated(32, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_9(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 36) {
    Some(value) => Ok(value)
    None => Err(Truncated(36, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_10(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 40) {
    Some(value) => Ok(value)
    None => Err(Truncated(40, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_11(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 44) {
    Some(value) => Ok(value)
    None => Err(Truncated(44, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_12(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 48) {
    Some(value) => Ok(value)
    None => Err(Truncated(48, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_13(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 52) {
    Some(value) => Ok(value)
    None => Err(Truncated(52, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_14(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 56) {
    Some(value) => Ok(value)
    None => Err(Truncated(56, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_15(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 60) {
    Some(value) => Ok(value)
    None => Err(Truncated(60, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_16(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 64) {
    Some(value) => Ok(value)
    None => Err(Truncated(64, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_17(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 68) {
    Some(value) => Ok(value)
    None => Err(Truncated(68, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_18(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 72) {
    Some(value) => Ok(value)
    None => Err(Truncated(72, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_19(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 76) {
    Some(value) => Ok(value)
    None => Err(Truncated(76, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_20(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 80) {
    Some(value) => Ok(value)
    None => Err(Truncated(80, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_21(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 84) {
    Some(value) => Ok(value)
    None => Err(Truncated(84, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_22(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 88) {
    Some(value) => Ok(value)
    None => Err(Truncated(88, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_23(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 92) {
    Some(value) => Ok(value)
    None => Err(Truncated(92, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_24(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 96) {
    Some(value) => Ok(value)
    None => Err(Truncated(96, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_25(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 100) {
    Some(value) => Ok(value)
    None => Err(Truncated(100, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_26(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 104) {
    Some(value) => Ok(value)
    None => Err(Truncated(104, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_27(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 108) {
    Some(value) => Ok(value)
    None => Err(Truncated(108, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_28(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 112) {
    Some(value) => Ok(value)
    None => Err(Truncated(112, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_29(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 116) {
    Some(value) => Ok(value)
    None => Err(Truncated(116, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_30(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 120) {
    Some(value) => Ok(value)
    None => Err(Truncated(120, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_31(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 124) {
    Some(value) => Ok(value)
    None => Err(Truncated(124, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_32(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 128) {
    Some(value) => Ok(value)
    None => Err(Truncated(128, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_33(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 132) {
    Some(value) => Ok(value)
    None => Err(Truncated(132, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_34(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 136) {
    Some(value) => Ok(value)
    None => Err(Truncated(136, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_35(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 140) {
    Some(value) => Ok(value)
    None => Err(Truncated(140, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_36(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 144) {
    Some(value) => Ok(value)
    None => Err(Truncated(144, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_37(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 148) {
    Some(value) => Ok(value)
    None => Err(Truncated(148, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_38(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 152) {
    Some(value) => Ok(value)
    None => Err(Truncated(152, 4, bytes.length()))
  }
}

///|
pub fn decode_u32_39(bytes : Bytes) -> Result[UInt, ProtocolError] {
  match read_u32(bytes, 156) {
    Some(value) => Ok(value)
    None => Err(Truncated(156, 4, bytes.length()))
  }
}

///|
pub fn decode_u64_0(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 0) {
    Some(value) => Ok(value)
    None => Err(Truncated(0, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_1(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 8) {
    Some(value) => Ok(value)
    None => Err(Truncated(8, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_2(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 16) {
    Some(value) => Ok(value)
    None => Err(Truncated(16, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_3(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 24) {
    Some(value) => Ok(value)
    None => Err(Truncated(24, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_4(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 32) {
    Some(value) => Ok(value)
    None => Err(Truncated(32, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_5(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 40) {
    Some(value) => Ok(value)
    None => Err(Truncated(40, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_6(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 48) {
    Some(value) => Ok(value)
    None => Err(Truncated(48, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_7(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 56) {
    Some(value) => Ok(value)
    None => Err(Truncated(56, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_8(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 64) {
    Some(value) => Ok(value)
    None => Err(Truncated(64, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_9(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 72) {
    Some(value) => Ok(value)
    None => Err(Truncated(72, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_10(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 80) {
    Some(value) => Ok(value)
    None => Err(Truncated(80, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_11(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 88) {
    Some(value) => Ok(value)
    None => Err(Truncated(88, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_12(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 96) {
    Some(value) => Ok(value)
    None => Err(Truncated(96, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_13(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 104) {
    Some(value) => Ok(value)
    None => Err(Truncated(104, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_14(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 112) {
    Some(value) => Ok(value)
    None => Err(Truncated(112, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_15(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 120) {
    Some(value) => Ok(value)
    None => Err(Truncated(120, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_16(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 128) {
    Some(value) => Ok(value)
    None => Err(Truncated(128, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_17(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 136) {
    Some(value) => Ok(value)
    None => Err(Truncated(136, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_18(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 144) {
    Some(value) => Ok(value)
    None => Err(Truncated(144, 8, bytes.length()))
  }
}

///|
pub fn decode_u64_19(bytes : Bytes) -> Result[UInt64, ProtocolError] {
  match read_u64(bytes, 152) {
    Some(value) => Ok(value)
    None => Err(Truncated(152, 8, bytes.length()))
  }
}

///|
test "bounded decoder accessors" {
  let bytes : Bytes = b"\x01\x00\x02\x00"
  assert_true(decode_u16_0(bytes) is Ok(1U))
  assert_true(decode_u16_2(bytes) is Ok(2U))
  match decode_u32_1(bytes) {
    Err(_) => assert_true(true)
    Ok(_) => assert_true(false)
  }
}
