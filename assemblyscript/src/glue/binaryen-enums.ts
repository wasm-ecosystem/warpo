// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

/** Binaryen expression id constants. See wasm-delegations.def in Binaryen. */
export const enum ExpressionId {
  Invalid = 0 /* _BinaryenInvalidId */,
  Block = 1 /* _BinaryenBlockId */,
  If = 2 /* _BinaryenIfId */,
  Loop = 3 /* _BinaryenLoopId */,
  Break = 4 /* _BinaryenBreakId */,
  Switch = 5 /* _BinaryenSwitchId */,
  Call = 6 /* _BinaryenCallId */,
  CallIndirect = 7 /* _BinaryenCallIndirectId */,
  LocalGet = 8 /* _BinaryenLocalGetId */,
  LocalSet = 9 /* _BinaryenLocalSetId */,
  GlobalGet = 10 /* _BinaryenGlobalGetId */,
  GlobalSet = 11 /* _BinaryenGlobalSetId */,
  Load = 12 /* _BinaryenLoadId */,
  Store = 13 /* _BinaryenStoreId */,
  Const = 14 /* _BinaryenConstId */,
  Unary = 15 /* _BinaryenUnaryId */,
  Binary = 16 /* _BinaryenBinaryId */,
  Select = 17 /* _BinaryenSelectId */,
  Drop = 18 /* _BinaryenDropId */,
  Return = 19 /* _BinaryenReturnId */,
  MemorySize = 20 /* _BinaryenMemorySizeId */,
  MemoryGrow = 21 /* _BinaryenMemoryGrowId */,
  Nop = 22 /* _BinaryenNopId */,
  Unreachable = 23 /* _BinaryenUnreachableId */,
  SIMDExtract = 30 /* _BinaryenSIMDExtractId */,
  SIMDReplace = 31 /* _BinaryenSIMDReplaceId */,
  SIMDShuffle = 32 /* _BinaryenSIMDShuffleId */,
  SIMDTernary = 33 /* _BinaryenSIMDTernaryId */,
  SIMDShift = 34 /* _BinaryenSIMDShiftId */,
  SIMDLoad = 35 /* _BinaryenSIMDLoadId */,
  SIMDLoadStoreLane = 36 /* _BinaryenSIMDLoadStoreLaneId */,
  MemoryInit = 37 /* _BinaryenMemoryInitId */,
  DataDrop = 38 /* _BinaryenDataDropId */,
  MemoryCopy = 39 /* _BinaryenMemoryCopyId */,
  MemoryFill = 40 /* _BinaryenMemoryFillId */,
  Pop = 41 /* _BinaryenPopId */,
  RefNull = 42 /* _BinaryenRefNullId */,
  RefIsNull = 43 /* _BinaryenRefIsNullId */,
  RefFunc = 44 /* _BinaryenRefFuncId */,
  RefEq = 45 /* _BinaryenRefEqId */,
  TableGet = 46 /* _BinaryenTableGetId */,
  TableSet = 47 /* _BinaryenTableSetId */,
  TableSize = 48 /* _BinaryenTableSizeId */,
  TableGrow = 49 /* _BinaryenTableGrowId */,
  TableFill = 50 /* _BinaryenTableFillId */,
  TableCopy = 51 /* _BinaryenTableCopyId */,
  TableInit = 52 /* _BinaryenTableInitId */,
  Try = 54 /* _BinaryenTryId */,
  TryTable = 55 /* _BinaryenTryTableId */,
  Throw = 56 /* _BinaryenThrowId */,
  Rethrow = 57 /* _BinaryenRethrowId */,
  ThrowRef = 58 /* _BinaryenThrowRefId */,
  TupleMake = 59 /* _BinaryenTupleMakeId */,
  TupleExtract = 60 /* _BinaryenTupleExtractId */,
  RefI31 = 61 /* _BinaryenRefI31Id */,
  I31Get = 62 /* _BinaryenI31GetId */,
  CallRef = 63 /* _BinaryenCallRefId */,
  RefTest = 64 /* _BinaryenRefTestId */,
  RefCast = 65 /* _BinaryenRefCastId */,
  RefGetDesc = 66 /* _BinaryenRefGetDescId */,
  BrOn = 67 /* _BinaryenBrOnId */,
  StructNew = 68 /* _BinaryenStructNewId */,
  StructGet = 69 /* _BinaryenStructGetId */,
  StructSet = 70 /* _BinaryenStructSetId */,
  StructRMW = 71 /* _BinaryenStructRMWId */,
  StructCmpxchg = 72 /* _BinaryenStructCmpxchgId */,
  ArrayNew = 73 /* _BinaryenArrayNewId */,
  ArrayNewData = 74 /* _BinaryenArrayNewDataId */,
  ArrayNewElem = 75 /* _BinaryenArrayNewElemId */,
  ArrayNewFixed = 76 /* _BinaryenArrayNewFixedId */,
  ArrayGet = 77 /* _BinaryenArrayGetId */,
  ArraySet = 78 /* _BinaryenArraySetId */,
  ArrayLen = 79 /* _BinaryenArrayLenId */,
  ArrayCopy = 80 /* _BinaryenArrayCopyId */,
  ArrayFill = 81 /* _BinaryenArrayFillId */,
  ArrayInitData = 82 /* _BinaryenArrayInitDataId */,
  ArrayInitElem = 83 /* _BinaryenArrayInitElemId */,
  RefAs = 86 /* _BinaryenRefAsId */,
  StringNew = 87 /* _BinaryenStringNewId */,
  StringConst = 88 /* _BinaryenStringConstId */,
  StringMeasure = 89 /* _BinaryenStringMeasureId */,
  StringEncode = 90 /* _BinaryenStringEncodeId */,
  StringConcat = 91 /* _BinaryenStringConcatId */,
  StringEq = 92 /* _BinaryenStringEqId */,
  StringWTF16Get = 94 /* _BinaryenStringWTF16GetId */,
  StringSliceWTF = 95 /* _BinaryenStringSliceWTFId */,
  ContNew = 96 /* _BinaryenContNewId */,
  ContBind = 97 /* _BinaryenContBindId */,
  Suspend = 98 /* _BinaryenSuspendId */,
  Resume = 99 /* _BinaryenResumeId */,
  ResumeThrow = 100 /* _BinaryenResumeThrowId */,
  StackSwitch = 101 /* _BinaryenStackSwitchId */,
}

/** Binaryen external kind constants. */
export const enum ExternalKind {
  Function = 0 /* _BinaryenExternalFunction */,
  Table = 1 /* _BinaryenExternalTable */,
  Memory = 2 /* _BinaryenExternalMemory */,
  Global = 3 /* _BinaryenExternalGlobal */,
  Tag = 4 /* _BinaryenExternalTag */,
}

/** Binaryen unary operation constants. */
export const enum UnaryOp {
  /** i32.clz */
  ClzI32 = 0 /* _BinaryenClzInt32 */,
  /** i64.clz */
  ClzI64 = 1 /* _BinaryenClzInt64 */,
  /** i32.ctz */
  CtzI32 = 2 /* _BinaryenCtzInt32 */,
  /** i64.ctz */
  CtzI64 = 3 /* _BinaryenCtzInt64 */,
  /** i32.popcnt */
  PopcntI32 = 4 /* _BinaryenPopcntInt32 */,
  /** i64.popcnt */
  PopcntI64 = 5 /* _BinaryenPopcntInt64 */,
  /** f32.neg */
  NegF32 = 6 /* _BinaryenNegFloat32 */,
  /** f64.neg */
  NegF64 = 7 /* _BinaryenNegFloat64 */,
  /** f32.abs */
  AbsF32 = 8 /* _BinaryenAbsFloat32 */,
  /** f64.abs */
  AbsF64 = 9 /* _BinaryenAbsFloat64 */,
  /** f32.ceil */
  CeilF32 = 10 /* _BinaryenCeilFloat32 */,
  /** f64.ceil */
  CeilF64 = 11 /* _BinaryenCeilFloat64 */,
  /** f32.floor */
  FloorF32 = 12 /* _BinaryenFloorFloat32 */,
  /** f64.floor */
  FloorF64 = 13 /* _BinaryenFloorFloat64 */,
  /** f32.trunc */
  TruncF32 = 14 /* _BinaryenTruncFloat32 */,
  /** f64.trunc */
  TruncF64 = 15 /* _BinaryenTruncFloat64 */,
  /** f32.nearest */
  NearestF32 = 16 /* _BinaryenNearestFloat32 */,
  /** f64.nearest */
  NearestF64 = 17 /* _BinaryenNearestFloat64 */,
  /** f32.sqrt */
  SqrtF32 = 18 /* _BinaryenSqrtFloat32 */,
  /** f64.sqrt */
  SqrtF64 = 19 /* _BinaryenSqrtFloat64 */,
  /** i32.eqz */
  EqzI32 = 20 /* _BinaryenEqZInt32 */,
  /** i64.eqz */
  EqzI64 = 21 /* _BinaryenEqZInt64 */,
  /** i64.extend_i32_s */
  ExtendI32ToI64 = 22 /* _BinaryenExtendSInt32 */,
  /** i64.extend_i32_u */
  ExtendU32ToU64 = 23 /* _BinaryenExtendUInt32 */,
  /** i32.wrap_i64 */
  WrapI64ToI32 = 24 /* _BinaryenWrapInt64 */,
  /** i32.trunc_f32_s */
  TruncF32ToI32 = 25 /* _BinaryenTruncSFloat32ToInt32 */,
  /** i64.trunc_f32_s */
  TruncF32ToI64 = 26 /* _BinaryenTruncSFloat32ToInt64 */,
  /** i32.trunc_f32_u */
  TruncF32ToU32 = 27 /* _BinaryenTruncUFloat32ToInt32 */,
  /** i64.trunc_f32_u */
  TruncF32ToU64 = 28 /* _BinaryenTruncUFloat32ToInt64 */,
  /** i32.trunc_f64_s */
  TruncF64ToI32 = 29 /* _BinaryenTruncSFloat64ToInt32 */,
  /** i64.trunc_f64_s */
  TruncF64ToI64 = 30 /* _BinaryenTruncSFloat64ToInt64 */,
  /** i32.trunc_f64_u */
  TruncF64ToU32 = 31 /* _BinaryenTruncUFloat64ToInt32 */,
  /** i64.trunc_f64_u */
  TruncF64ToU64 = 32 /* _BinaryenTruncUFloat64ToInt64 */,
  /** i32.reinterpret_f32 */
  ReinterpretF32ToI32 = 33 /* _BinaryenReinterpretFloat32 */,
  /** i64.reinterpret_f64 */
  ReinterpretF64ToI64 = 34 /* _BinaryenReinterpretFloat64 */,
  /** f32.convert_i32_s */
  ConvertI32ToF32 = 35 /* _BinaryenConvertSInt32ToFloat32 */,
  /** f64.convert_i32_s */
  ConvertI32ToF64 = 36 /* _BinaryenConvertSInt32ToFloat64 */,
  /** f32.convert_i32_u */
  ConvertU32ToF32 = 37 /* _BinaryenConvertUInt32ToFloat32 */,
  /** f64.convert_i32_u */
  ConvertU32ToF64 = 38 /* _BinaryenConvertUInt32ToFloat64 */,
  /** f32.convert_i64_s */
  ConvertI64ToF32 = 39 /* _BinaryenConvertSInt64ToFloat32 */,
  /** f64.convert_i64_s */
  ConvertI64ToF64 = 40 /* _BinaryenConvertSInt64ToFloat64 */,
  /** f32.convert_i64_u */
  ConvertU64ToF32 = 41 /* _BinaryenConvertUInt64ToFloat32 */,
  /** f64.convert_i64_u */
  ConvertU64ToF64 = 42 /* _BinaryenConvertUInt64ToFloat64 */,
  /** f64.promote.f32 */
  PromoteF32ToF64 = 43 /* _BinaryenPromoteFloat32 */,
  /** f32.demote_f64 */
  DemoteF64ToF32 = 44 /* _BinaryenDemoteFloat64 */,
  /** f32.reinterpret_i32 */
  ReinterpretI32ToF32 = 45 /* _BinaryenReinterpretInt32 */,
  /** f64.reinterpret_i64 */
  ReinterpretI64ToF64 = 46 /* _BinaryenReinterpretInt64 */,

  // see: https://github.com/WebAssembly/sign-extension-ops

  /** i32.extend8_s */
  Extend8I32 = 47 /* _BinaryenExtendS8Int32 */,
  /** i32.extend16_s */
  Extend16I32 = 48 /* _BinaryenExtendS16Int32 */,
  /** i64.extend8_s */
  Extend8I64 = 49 /* _BinaryenExtendS8Int64 */,
  /** i64.extend16_s */
  Extend16I64 = 50 /* _BinaryenExtendS16Int64 */,
  /** i64.extend32_s (i64 in, i64 out) */
  Extend32I64 = 51 /* _BinaryenExtendS32Int64 */,

  // see: https://github.com/WebAssembly/nontrapping-float-to-int-conversions

  /** i32.trunc_sat_f32_s */
  TruncSatF32ToI32 = 52 /* _BinaryenTruncSatSFloat32ToInt32 */,
  /** i32.trunc_sat_f32_u */
  TruncSatF32ToU32 = 53 /* _BinaryenTruncSatUFloat32ToInt32 */,
  /** i32.trunc_sat_f64_s */
  TruncSatF64ToI32 = 54 /* _BinaryenTruncSatSFloat64ToInt32 */,
  /** i32.trunc_sat_f64_u */
  TruncSatF64ToU32 = 55 /* _BinaryenTruncSatUFloat64ToInt32 */,
  /** i64.trunc_sat_f32_s */
  TruncSatF32ToI64 = 56 /* _BinaryenTruncSatSFloat32ToInt64 */,
  /** i64.trunc_sat_f32_u */
  TruncSatF32ToU64 = 57 /* _BinaryenTruncSatUFloat32ToInt64 */,
  /** i64.trunc_sat_f64_s */
  TruncSatF64ToI64 = 58 /* _BinaryenTruncSatSFloat64ToInt64 */,
  /** i64.trunc_sat_f64_u */
  TruncSatF64ToU64 = 59 /* _BinaryenTruncSatUFloat64ToInt64 */,

  // see: https://github.com/WebAssembly/simd

  /** i8x16.splat */
  SplatI8x16 = 60 /* _BinaryenSplatVecI8x16 */,
  /** i16x8.splat */
  SplatI16x8 = 61 /* _BinaryenSplatVecI16x8 */,
  /** i32x4.splat */
  SplatI32x4 = 62 /* _BinaryenSplatVecI32x4 */,
  /** i64x2.splat */
  SplatI64x2 = 63 /* _BinaryenSplatVecI64x2 */,
  /** f32x4.splat */
  SplatF32x4 = 64 /* _BinaryenSplatVecF32x4 */,
  /** f64x2.splat */
  SplatF64x2 = 65 /* _BinaryenSplatVecF64x2 */,
  /** v128.not */
  NotV128 = 66 /* _BinaryenNotVec128 */,
  /** v128.any_true */
  AnyTrueV128 = 67 /* _BinaryenAnyTrueVec128 */,
  /** i8x16.abs */
  AbsI8x16 = 68 /* _BinaryenAbsVecI8x16 */,
  /** i8x16.neg */
  NegI8x16 = 69 /* _BinaryenNegVecI8x16 */,
  /** i8x16.all_true */
  AllTrueI8x16 = 70 /* _BinaryenAllTrueVecI8x16 */,
  /** i8x16.bitmask */
  BitmaskI8x16 = 71 /* _BinaryenBitmaskVecI8x16 */,
  /** i8x16.popcnt */
  PopcntI8x16 = 72 /* _BinaryenPopcntVecI8x16 */,
  /** i16x8.abs */
  AbsI16x8 = 73 /* _BinaryenAbsVecI16x8 */,
  /** i16x8.neg */
  NegI16x8 = 74 /* _BinaryenNegVecI16x8 */,
  /** i16x8.all_true */
  AllTrueI16x8 = 75 /* _BinaryenAllTrueVecI16x8 */,
  /** i16x8.bitmask */
  BitmaskI16x8 = 76 /* _BinaryenBitmaskVecI16x8 */,
  /** i32x4.abs */
  AbsI32x4 = 77 /* _BinaryenAbsVecI32x4 */,
  /** i32x4.neg */
  NegI32x4 = 78 /* _BinaryenNegVecI32x4 */,
  /** i32x4.all_true */
  AllTrueI32x4 = 79 /* _BinaryenAllTrueVecI32x4 */,
  /** i32x4.bitmask */
  BitmaskI32x4 = 80 /* _BinaryenBitmaskVecI32x4 */,
  /** i64x2.abs */
  AbsI64x2 = 81 /* _BinaryenAbsVecI64x2 */,
  /** i64x2.neg */
  NegI64x2 = 82 /* _BinaryenNegVecI64x2 */,
  /** i64x2.all_true */
  AllTrueI64x2 = 83 /* _BinaryenAllTrueVecI64x2 */,
  /** i64x2.bitmask */
  BitmaskI64x2 = 84 /* _BinaryenBitmaskVecI64x2 */,
  /** f32x4.abs */
  AbsF32x4 = 92 /* _BinaryenAbsVecF32x4 */,
  /** f32x4.neg */
  NegF32x4 = 93 /* _BinaryenNegVecF32x4 */,
  /** f32x4.sqrt */
  SqrtF32x4 = 94 /* _BinaryenSqrtVecF32x4 */,
  /** f32x4.ceil */
  CeilF32x4 = 95 /* _BinaryenCeilVecF32x4 */,
  /** f32x4.floor */
  FloorF32x4 = 96 /* _BinaryenFloorVecF32x4 */,
  /** f32x4.trunc */
  TruncF32x4 = 97 /* _BinaryenTruncVecF32x4 */,
  /** f32x4.nearest */
  NearestF32x4 = 98 /* _BinaryenNearestVecF32x4 */,
  /** f64x2.abs */
  AbsF64x2 = 99 /* _BinaryenAbsVecF64x2 */,
  /** f64x2.neg */
  NegF64x2 = 100 /* _BinaryenNegVecF64x2 */,
  /** f64x2.sqrt */
  SqrtF64x2 = 101 /* _BinaryenSqrtVecF64x2 */,
  /** f64x2.ceil */
  CeilF64x2 = 102 /* _BinaryenCeilVecF64x2 */,
  /** f64x2.floor */
  FloorF64x2 = 103 /* _BinaryenFloorVecF64x2 */,
  /** f64x2.trunc */
  TruncF64x2 = 104 /* _BinaryenTruncVecF64x2 */,
  /** f64x2.nearest */
  NearestF64x2 = 105 /* _BinaryenNearestVecF64x2 */,
  /** i16x8.extadd_pairwise_i8x16_s */
  ExtaddPairwiseI8x16ToI16x8 = 106 /* _BinaryenExtAddPairwiseSVecI8x16ToI16x8 */,
  /** i16x8.extadd_pairwise.i8x16_u */
  ExtaddPairwiseU8x16ToU16x8 = 107 /* _BinaryenExtAddPairwiseUVecI8x16ToI16x8 */,
  /** i32x4.extadd_pairwise.i16x8_s */
  ExtaddPairwiseI16x8ToI32x4 = 108 /* _BinaryenExtAddPairwiseSVecI16x8ToI32x4 */,
  /** i32x4.extadd_pairwise.i64x8_u */
  ExtaddPairwiseU16x8ToU32x4 = 109 /* _BinaryenExtAddPairwiseUVecI16x8ToI32x4 */,
  /** i32x4.trunc_sat_f32x4_s */
  TruncSatF32x4ToI32x4 = 110 /* _BinaryenTruncSatSVecF32x4ToVecI32x4 */,
  /** i32x4.trunc_sat_f32x4_u */
  TruncSatF32x4ToU32x4 = 111 /* _BinaryenTruncSatUVecF32x4ToVecI32x4 */,
  /** f32x4.convert_i32x4_s */
  ConvertI32x4ToF32x4 = 112 /* _BinaryenConvertSVecI32x4ToVecF32x4 */,
  /** f32x4.convert_i32x4_u */
  ConvertU32x4ToF32x4 = 113 /* _BinaryenConvertUVecI32x4ToVecF32x4 */,
  /** i16x8.extend_low_i8x16_s */
  ExtendLowI8x16ToI16x8 = 114 /* _BinaryenExtendLowSVecI8x16ToVecI16x8 */,
  /** i16x8.extend_high_i8x16_s */
  ExtendHighI8x16ToI16x8 = 115 /* _BinaryenExtendHighSVecI8x16ToVecI16x8 */,
  /** i16x8.extend_low_i8x16_u */
  ExtendLowU8x16ToU16x8 = 116 /* _BinaryenExtendLowUVecI8x16ToVecI16x8 */,
  /** i16x8.extend_high_i8x16_u */
  ExtendHighU8x16ToU16x8 = 117 /* _BinaryenExtendHighUVecI8x16ToVecI16x8 */,
  /** i32x4.extend_low_i16x8_s */
  ExtendLowI16x8ToI32x4 = 118 /* _BinaryenExtendLowSVecI16x8ToVecI32x4 */,
  /** i32x4.extend_high_i16x8_s */
  ExtendHighI16x8ToI32x4 = 119 /* _BinaryenExtendHighSVecI16x8ToVecI32x4 */,
  /** i32x4.extend_low_i16x8_u */
  ExtendLowU16x8ToU32x4 = 120 /* _BinaryenExtendLowUVecI16x8ToVecI32x4 */,
  /** i32x4.extend_high_i16x8_u */
  ExtendHighU16x8ToU32x4 = 121 /* _BinaryenExtendHighUVecI16x8ToVecI32x4 */,
  /** i64x2.extend_low_i32x4_s */
  ExtendLowI32x4ToI64x2 = 122 /* _BinaryenExtendLowSVecI32x4ToVecI64x2 */,
  /** i64x2.extend_high_i32x4_s */
  ExtendHighI32x4ToI64x2 = 123 /* _BinaryenExtendHighSVecI32x4ToVecI64x2 */,
  /** i64x2.extend_low_i32x4_u */
  ExtendLowU32x4ToU64x2 = 124 /* _BinaryenExtendLowUVecI32x4ToVecI64x2 */,
  /** i64x2.extend_high_i32x4_u */
  ExtendHighU32x4ToU64x2 = 125 /* _BinaryenExtendHighUVecI32x4ToVecI64x2 */,
  /** f32x4.convert_i32x4_s */
  ConvertLowI32x4ToF64x2 = 126 /* _BinaryenConvertLowSVecI32x4ToVecF64x2 */,
  /** f32x4.convert_i32x4_u */
  ConvertLowU32x4ToF64x2 = 127 /* _BinaryenConvertLowUVecI32x4ToVecF64x2 */,
  /** i32x4.trunc_sat_f64x2_s_zero */
  TruncSatF64x2ToI32x4Zero = 128 /* _BinaryenTruncSatZeroSVecF64x2ToVecI32x4 */,
  /** i32x4.trunc_sat_f64x2_u_zero */
  TruncSatF64x2ToU32x4Zero = 129 /* _BinaryenTruncSatZeroUVecF64x2ToVecI32x4 */,
  /** f32x4.demote_f64x2_zero */
  DemoteZeroF64x2ToF32x4 = 130 /* _BinaryenDemoteZeroVecF64x2ToVecF32x4 */,
  /** f64x2.promote_low_f32x4 */
  PromoteLowF32x4ToF64x2 = 131 /* _BinaryenPromoteLowVecF32x4ToVecF64x2 */,
  /** i32x4.relaxed_trunc_f32x4_s */
  RelaxedTruncF32x4ToI32x4 = 132 /* _BinaryenRelaxedTruncSVecF32x4ToVecI32x4 */,
  /** i32x4.relaxed_trunc_f32x4_u */
  RelaxedTruncF32x4ToU32x4 = 133 /* _BinaryenRelaxedTruncUVecF32x4ToVecI32x4 */,
  /** i32x4.relaxed_trunc_f64x2_s_zero */
  RelaxedTruncF64x2ToI32x4Zero = 134 /* _BinaryenRelaxedTruncZeroSVecF64x2ToVecI32x4 */,
  /** i32x4.relaxed_trunc_f64x2_u_zero */
  RelaxedTruncF64x2ToU32x4Zero = 135 /* _BinaryenRelaxedTruncZeroUVecF64x2ToVecI32x4 */,

  _last = RelaxedTruncF64x2ToU32x4Zero,

  // Target dependent

  /** i32.clz or i64.clz, depending on target word size */
  ClzSize,
  /** i32.ctz or i64.ctz, depending on target word size */
  CtzSize,
  /** i32.popcnt or i64.popcnt, depending on target word size */
  PopcntSize,
  /** i32.eqz or i64.eqz, depending on target word size */
  EqzSize,
}

/** Binaryen binary operation constants. */
export const enum BinaryOp {
  /** i32.add */
  AddI32 = 0 /* _BinaryenAddInt32 */,
  /** i32.sub */
  SubI32 = 1 /* _BinaryenSubInt32 */,
  /** i32.mul */
  MulI32 = 2 /* _BinaryenMulInt32 */,
  /** i32.div_s */
  DivI32 = 3 /* _BinaryenDivSInt32 */,
  /** i32.div_u */
  DivU32 = 4 /* _BinaryenDivUInt32 */,
  /** i32.rem_s */
  RemI32 = 5 /* _BinaryenRemSInt32 */,
  /** i32.rem_u */
  RemU32 = 6 /* _BinaryenRemUInt32 */,
  /** i32.and */
  AndI32 = 7 /* _BinaryenAndInt32 */,
  /** i32.or */
  OrI32 = 8 /* _BinaryenOrInt32 */,
  /** i32.xor */
  XorI32 = 9 /* _BinaryenXorInt32 */,
  /** i32.shl */
  ShlI32 = 10 /* _BinaryenShlInt32 */,
  /** i32.shr_s */
  ShrI32 = 11 /* _BinaryenShrSInt32 */,
  /** i32.shr_u */
  ShrU32 = 12 /* _BinaryenShrUInt32 */,
  /** i32.rotl */
  RotlI32 = 13 /* _BinaryenRotLInt32 */,
  /** i32.rotr */
  RotrI32 = 14 /* _BinaryenRotRInt32 */,
  /** i32.eq */
  EqI32 = 15 /* _BinaryenEqInt32 */,
  /** i32.ne */
  NeI32 = 16 /* _BinaryenNeInt32 */,
  /** i32.lt_s */
  LtI32 = 17 /* _BinaryenLtSInt32 */,
  /** i32.lt_u */
  LtU32 = 18 /* _BinaryenLtUInt32 */,
  /** i32.le_s */
  LeI32 = 19 /* _BinaryenLeSInt32 */,
  /** i32.le_u */
  LeU32 = 20 /* _BinaryenLeUInt32 */,
  /** i32.gt_s */
  GtI32 = 21 /* _BinaryenGtSInt32 */,
  /** i32.gt_u */
  GtU32 = 22 /* _BinaryenGtUInt32 */,
  /** i32.ge_s */
  GeI32 = 23 /* _BinaryenGeSInt32 */,
  /** i32.ge_u */
  GeU32 = 24 /* _BinaryenGeUInt32 */,
  /** i64.add */
  AddI64 = 25 /* _BinaryenAddInt64 */,
  /** i64.sub */
  SubI64 = 26 /* _BinaryenSubInt64 */,
  /** i64.mul */
  MulI64 = 27 /* _BinaryenMulInt64 */,
  /** i64.div_s */
  DivI64 = 28 /* _BinaryenDivSInt64 */,
  /** i64.div_u */
  DivU64 = 29 /* _BinaryenDivUInt64 */,
  /** i64.rem_s */
  RemI64 = 30 /* _BinaryenRemSInt64 */,
  /** i64.rem_u */
  RemU64 = 31 /* _BinaryenRemUInt64 */,
  /** i64.and */
  AndI64 = 32 /* _BinaryenAndInt64 */,
  /** i64.or */
  OrI64 = 33 /* _BinaryenOrInt64 */,
  /** i64.xor */
  XorI64 = 34 /* _BinaryenXorInt64 */,
  /** i64.shl */
  ShlI64 = 35 /* _BinaryenShlInt64 */,
  /** i64.shr_s */
  ShrI64 = 36 /* _BinaryenShrSInt64 */,
  /** i64.shr_u */
  ShrU64 = 37 /* _BinaryenShrUInt64 */,
  /** i64.rotl */
  RotlI64 = 38 /* _BinaryenRotLInt64 */,
  /** i64.rotr */
  RotrI64 = 39 /* _BinaryenRotRInt64 */,
  /** i64.eq */
  EqI64 = 40 /* _BinaryenEqInt64 */,
  /** i64.ne */
  NeI64 = 41 /* _BinaryenNeInt64 */,
  /** i64.lt_s */
  LtI64 = 42 /* _BinaryenLtSInt64 */,
  /** i64.lt_u */
  LtU64 = 43 /* _BinaryenLtUInt64 */,
  /** i64.le_s */
  LeI64 = 44 /* _BinaryenLeSInt64 */,
  /** i64.le_u */
  LeU64 = 45 /* _BinaryenLeUInt64 */,
  /** i64.gt_s */
  GtI64 = 46 /* _BinaryenGtSInt64 */,
  /** i64.gt_u */
  GtU64 = 47 /* _BinaryenGtUInt64 */,
  /** i64.ge_s */
  GeI64 = 48 /* _BinaryenGeSInt64 */,
  /** i64.ge_u */
  GeU64 = 49 /* _BinaryenGeUInt64 */,
  /** f32.add */
  AddF32 = 50 /* _BinaryenAddFloat32 */,
  /** f32.sub */
  SubF32 = 51 /* _BinaryenSubFloat32 */,
  /** f32.mul */
  MulF32 = 52 /* _BinaryenMulFloat32 */,
  /** f32.div */
  DivF32 = 53 /* _BinaryenDivFloat32 */,
  /** f32.copysign */
  CopysignF32 = 54 /* _BinaryenCopySignFloat32 */,
  /** f32.min */
  MinF32 = 55 /* _BinaryenMinFloat32 */,
  /** f32.max */
  MaxF32 = 56 /* _BinaryenMaxFloat32 */,
  /** f32.eq */
  EqF32 = 57 /* _BinaryenEqFloat32 */,
  /** f32.ne */
  NeF32 = 58 /* _BinaryenNeFloat32 */,
  /** f32.lt */
  LtF32 = 59 /* _BinaryenLtFloat32 */,
  /** f32.le */
  LeF32 = 60 /* _BinaryenLeFloat32 */,
  /** f32.gt */
  GtF32 = 61 /* _BinaryenGtFloat32 */,
  /** f32.ge */
  GeF32 = 62 /* _BinaryenGeFloat32 */,
  /** f64.add */
  AddF64 = 63 /* _BinaryenAddFloat64 */,
  /** f64.sub */
  SubF64 = 64 /* _BinaryenSubFloat64 */,
  /** f64.mul */
  MulF64 = 65 /* _BinaryenMulFloat64 */,
  /** f64.div */
  DivF64 = 66 /* _BinaryenDivFloat64 */,
  /** f64.copysign */
  CopysignF64 = 67 /* _BinaryenCopySignFloat64 */,
  /** f64.min */
  MinF64 = 68 /* _BinaryenMinFloat64 */,
  /** f64.max */
  MaxF64 = 69 /* _BinaryenMaxFloat64 */,
  /** f64.eq */
  EqF64 = 70 /* _BinaryenEqFloat64 */,
  /** f64.ne */
  NeF64 = 71 /* _BinaryenNeFloat64 */,
  /** f64.lt */
  LtF64 = 72 /* _BinaryenLtFloat64 */,
  /** f64.le */
  LeF64 = 73 /* _BinaryenLeFloat64 */,
  /** f64.gt */
  GtF64 = 74 /* _BinaryenGtFloat64 */,
  /** f64.ge */
  GeF64 = 75 /* _BinaryenGeFloat64 */,

  /** i8x16.eq */
  EqI8x16 = 76 /* _BinaryenEqVecI8x16 */,
  /** i8x16.he */
  NeI8x16 = 77 /* _BinaryenNeVecI8x16 */,
  /** i8x16.lt_s */
  LtI8x16 = 78 /* _BinaryenLtSVecI8x16 */,
  /** i8x16.lt_u */
  LtU8x16 = 79 /* _BinaryenLtUVecI8x16 */,
  /** i8x16.gt_s */
  GtI8x16 = 80 /* _BinaryenGtSVecI8x16 */,
  /** i8x16.gt_u */
  GtU8x16 = 81 /* _BinaryenGtUVecI8x16 */,
  /** i8x16.le_s */
  LeI8x16 = 82 /* _BinaryenLeSVecI8x16 */,
  /** i8x16.le_u */
  LeU8x16 = 83 /* _BinaryenLeUVecI8x16 */,
  /** i8x16.ge_s */
  GeI8x16 = 84 /* _BinaryenGeSVecI8x16 */,
  /** i8x16.ge_u */
  GeU8x16 = 85 /* _BinaryenGeUVecI8x16 */,
  /** i16x8.eq */
  EqI16x8 = 86 /* _BinaryenEqVecI16x8 */,
  /** i16x8.ne */
  NeI16x8 = 87 /* _BinaryenNeVecI16x8 */,
  /** i16x8.lt_s */
  LtI16x8 = 88 /* _BinaryenLtSVecI16x8 */,
  /** i16x8.lt_u */
  LtU16x8 = 89 /* _BinaryenLtUVecI16x8 */,
  /** i16x8.gt_s */
  GtI16x8 = 90 /* _BinaryenGtSVecI16x8 */,
  /** i16x8.gt_u */
  GtU16x8 = 91 /* _BinaryenGtUVecI16x8 */,
  /** i16x8.le_s */
  LeI16x8 = 92 /* _BinaryenLeSVecI16x8 */,
  /** i16x8.le_u */
  LeU16x8 = 93 /* _BinaryenLeUVecI16x8 */,
  /** i16x8.ge_s */
  GeI16x8 = 94 /* _BinaryenGeSVecI16x8 */,
  /** i16x8.ge_u */
  GeU16x8 = 95 /* _BinaryenGeUVecI16x8 */,
  /** i32x4.eq */
  EqI32x4 = 96 /* _BinaryenEqVecI32x4 */,
  /** i32x4.ne */
  NeI32x4 = 97 /* _BinaryenNeVecI32x4 */,
  /** i32x4.lt_s */
  LtI32x4 = 98 /* _BinaryenLtSVecI32x4 */,
  /** i32x4.lt_u */
  LtU32x4 = 99 /* _BinaryenLtUVecI32x4 */,
  /** i32x4.gt_s */
  GtI32x4 = 100 /* _BinaryenGtSVecI32x4 */,
  /** i32x4.gt_u */
  GtU32x4 = 101 /* _BinaryenGtUVecI32x4 */,
  /** i32x4.le_s */
  LeI32x4 = 102 /* _BinaryenLeSVecI32x4 */,
  /** i32x4.le_u */
  LeU32x4 = 103 /* _BinaryenLeUVecI32x4 */,
  /** i32x4.ge_s */
  GeI32x4 = 104 /* _BinaryenGeSVecI32x4 */,
  /** i32x4.ge_u */
  GeU32x4 = 105 /* _BinaryenGeUVecI32x4 */,
  /** i64x2.eq */
  EqI64x2 = 106 /* _BinaryenEqVecI64x2 */,
  /** i64x2.ne */
  NeI64x2 = 107 /* _BinaryenNeVecI64x2 */,
  /** i64x2.lt_s */
  LtI64x2 = 108 /* _BinaryenLtSVecI64x2 */,
  /** i64x2.gt_s */
  GtI64x2 = 109 /* _BinaryenGtSVecI64x2 */,
  /** i64x2.le_s */
  LeI64x2 = 110 /* _BinaryenLeSVecI64x2 */,
  /** i64x2.ge_s */
  GeI64x2 = 111 /* _BinaryenGeSVecI64x2 */,
  /** f32x4.eq */
  EqF32x4 = 118 /* _BinaryenEqVecF32x4 */,
  /** f32x4.ne */
  NeF32x4 = 119 /* _BinaryenNeVecF32x4 */,
  /** f32x4.lt */
  LtF32x4 = 120 /* _BinaryenLtVecF32x4 */,
  /** f32x4.gt */
  GtF32x4 = 121 /* _BinaryenGtVecF32x4 */,
  /** f32x4.le */
  LeF32x4 = 122 /* _BinaryenLeVecF32x4 */,
  /** f32x4.ge */
  GeF32x4 = 123 /* _BinaryenGeVecF32x4 */,
  /** f64x2.eq */
  EqF64x2 = 124 /* _BinaryenEqVecF64x2 */,
  /** f64x2.ne */
  NeF64x2 = 125 /* _BinaryenNeVecF64x2 */,
  /** f64x2.lt */
  LtF64x2 = 126 /* _BinaryenLtVecF64x2 */,
  /** f64x2.gt */
  GtF64x2 = 127 /* _BinaryenGtVecF64x2 */,
  /** f64x2.le */
  LeF64x2 = 128 /* _BinaryenLeVecF64x2 */,
  /** f64x2.ge */
  GeF64x2 = 129 /* _BinaryenGeVecF64x2 */,
  /** v128.and */
  AndV128 = 130 /* _BinaryenAndVec128 */,
  /** v128.or */
  OrV128 = 131 /* _BinaryenOrVec128 */,
  /** v128.xor */
  XorV128 = 132 /* _BinaryenXorVec128 */,
  /** v128.andnot */
  AndnotV128 = 133 /* _BinaryenAndNotVec128 */,
  /** i8x16.add */
  AddI8x16 = 134 /* _BinaryenAddVecI8x16 */,
  /** i8x16.add_sat_s */
  AddSatI8x16 = 135 /* _BinaryenAddSatSVecI8x16 */,
  /** i8x16.add_sat_u */
  AddSatU8x16 = 136 /* _BinaryenAddSatUVecI8x16 */,
  /** i8x16.sub */
  SubI8x16 = 137 /* _BinaryenSubVecI8x16 */,
  /** i8x16.sub_sat_s */
  SubSatI8x16 = 138 /* _BinaryenSubSatSVecI8x16 */,
  /** i8x16.sub_sat_u */
  SubSatU8x16 = 139 /* _BinaryenSubSatUVecI8x16 */,
  /** i8x16.min_s */
  MinI8x16 = 140 /* _BinaryenMinSVecI8x16 */,
  /** i8x16.min_u */
  MinU8x16 = 141 /* _BinaryenMinUVecI8x16 */,
  /** i8x16.max_s */
  MaxI8x16 = 142 /* _BinaryenMaxSVecI8x16 */,
  /** i8x16.max_u */
  MaxU8x16 = 143 /* _BinaryenMaxUVecI8x16 */,
  /** i8x16.avgr_u */
  AvgrU8x16 = 144 /* _BinaryenAvgrUVecI8x16 */,
  /** i16x8.add */
  AddI16x8 = 145 /* _BinaryenAddVecI16x8 */,
  /** i16x8.add_sat_s */
  AddSatI16x8 = 146 /* _BinaryenAddSatSVecI16x8 */,
  /** i16x8.add_sat_u */
  AddSatU16x8 = 147 /* _BinaryenAddSatUVecI16x8 */,
  /** i16x8.sub */
  SubI16x8 = 148 /* _BinaryenSubVecI16x8 */,
  /** i16x8.sub_sat_s */
  SubSatI16x8 = 149 /* _BinaryenSubSatSVecI16x8 */,
  /** i16x8.sub_sat_u */
  SubSatU16x8 = 150 /* _BinaryenSubSatUVecI16x8 */,
  /** i16x8.mul */
  MulI16x8 = 151 /* _BinaryenMulVecI16x8 */,
  /** i16x8.min_s */
  MinI16x8 = 152 /* _BinaryenMinSVecI16x8 */,
  /** i16x8.min_u */
  MinU16x8 = 153 /* _BinaryenMinUVecI16x8 */,
  /** i16x8.max_s */
  MaxI16x8 = 154 /* _BinaryenMaxSVecI16x8 */,
  /** i16x8.max_u */
  MaxU16x8 = 155 /* _BinaryenMaxUVecI16x8 */,
  /** i16x8.avgr_u */
  AvgrU16x8 = 156 /* _BinaryenAvgrUVecI16x8 */,
  /** i16x8.q15mulr_sat_s */
  Q15mulrSatI16x8 = 157 /* _BinaryenQ15MulrSatSVecI16x8 */,
  /** i16x8.extmul_low_i8x16_s */
  ExtmulLowI16x8 = 158 /* _BinaryenExtMulLowSVecI16x8 */,
  /** i16x8.extmul_high_i8x16_s */
  ExtmulHighI16x8 = 159 /* _BinaryenExtMulHighSVecI16x8 */,
  /** i16x8.extmul_low_i8x16_u */
  ExtmulLowU16x8 = 160 /* _BinaryenExtMulLowUVecI16x8 */,
  /** i16x8.extmul_high_i8x16_u */
  ExtmulHighU16x8 = 161 /* _BinaryenExtMulHighUVecI16x8 */,
  /** i32x4.add */
  AddI32x4 = 162 /* _BinaryenAddVecI32x4 */,
  /** i32x4.sub */
  SubI32x4 = 163 /* _BinaryenSubVecI32x4 */,
  /** i32x4.mul */
  MulI32x4 = 164 /* _BinaryenMulVecI32x4 */,
  /** i32x4.min_s */
  MinI32x4 = 165 /* _BinaryenMinSVecI32x4 */,
  /** i32x4.min_u */
  MinU32x4 = 166 /* _BinaryenMinUVecI32x4 */,
  /** i32x4.max_s */
  MaxI32x4 = 167 /* _BinaryenMaxSVecI32x4 */,
  /** i32x4.max_u */
  MaxU32x4 = 168 /* _BinaryenMaxUVecI32x4 */,
  /** i32x4.dot_i16x8_s */
  DotI16x8 = 169 /* _BinaryenDotSVecI16x8ToVecI32x4 */,
  /** i32x4.extmul_low_i16x8_s */
  ExtmulLowI32x4 = 170 /* _BinaryenExtMulLowSVecI32x4 */,
  /** i32x4.extmul_high_i16x8_s */
  ExtmulHighI32x4 = 171 /* _BinaryenExtMulHighSVecI32x4 */,
  /** i32x4.extmul_low_i16x8_u */
  ExtmulLowU32x4 = 172 /* _BinaryenExtMulLowUVecI32x4 */,
  /** i32x4.extmul_high_i16x8_u */
  ExtmulHighU32x4 = 173 /* _BinaryenExtMulHighUVecI32x4 */,
  /** i64x2.add */
  AddI64x2 = 174 /* _BinaryenAddVecI64x2 */,
  /** i64x2.sub */
  SubI64x2 = 175 /* _BinaryenSubVecI64x2 */,
  /** i64x2.mul */
  MulI64x2 = 176 /* _BinaryenMulVecI64x2 */,
  /** i64x2.extmul_low_i32x4_s */
  ExtmulLowI64x2 = 177 /* _BinaryenExtMulLowSVecI64x2 */,
  /** i64x2.extmul_high_i32x4_s */
  ExtmulHighI64x2 = 178 /* _BinaryenExtMulHighSVecI64x2 */,
  /** i64x2.extmul_low_i32x4_u */
  ExtmulLowU64x2 = 179 /* _BinaryenExtMulLowUVecI64x2 */,
  /** i64x2.extmul_high_i32x4_u */
  ExtmulHighU64x2 = 180 /* _BinaryenExtMulHighUVecI64x2 */,
  /** f32x4.add */
  AddF32x4 = 189 /* _BinaryenAddVecF32x4 */,
  /** f32x4.sub */
  SubF32x4 = 190 /* _BinaryenSubVecF32x4 */,
  /** f32x4.mul */
  MulF32x4 = 191 /* _BinaryenMulVecF32x4 */,
  /** f32x4.div */
  DivF32x4 = 192 /* _BinaryenDivVecF32x4 */,
  /** f32x4.min */
  MinF32x4 = 193 /* _BinaryenMinVecF32x4 */,
  /** f32x4.max */
  MaxF32x4 = 194 /* _BinaryenMaxVecF32x4 */,
  /** f32x4.pmin */
  PminF32x4 = 195 /* _BinaryenPMinVecF32x4 */,
  /** f32x4.pmax */
  PmaxF32x4 = 196 /* _BinaryenPMaxVecF32x4 */,
  /** f64x2.add */
  AddF64x2 = 197 /* _BinaryenAddVecF64x2 */,
  /** f64x2.sub */
  SubF64x2 = 198 /* _BinaryenSubVecF64x2 */,
  /** f64x2.mul */
  MulF64x2 = 199 /* _BinaryenMulVecF64x2 */,
  /** f64x2.div */
  DivF64x2 = 200 /* _BinaryenDivVecF64x2 */,
  /** f64x2.min */
  MinF64x2 = 201 /* _BinaryenMinVecF64x2 */,
  /** f64x2.max */
  MaxF64x2 = 202 /* _BinaryenMaxVecF64x2 */,
  /** f64x2.pmin */
  PminF64x2 = 203 /* _BinaryenPMinVecF64x2 */,
  /** f64x2.pmax */
  PmaxF64x2 = 204 /* _BinaryenPMaxVecF64x2 */,
  /** i8x16.narrow_i16x8_s */
  NarrowI16x8ToI8x16 = 205 /* _BinaryenNarrowSVecI16x8ToVecI8x16 */,
  /** i8x16.narrow_i16x8_u */
  NarrowU16x8ToU8x16 = 206 /* _BinaryenNarrowUVecI16x8ToVecI8x16 */,
  /** i16x8.narrow_i32x4_s */
  NarrowI32x4ToI16x8 = 207 /* _BinaryenNarrowSVecI32x4ToVecI16x8 */,
  /** i16x8.narrow_i32x4_u */
  NarrowU32x4ToU16x8 = 208 /* _BinaryenNarrowUVecI32x4ToVecI16x8 */,
  /** i8x16.swizzle */
  SwizzleI8x16 = 209 /* _BinaryenSwizzleVecI8x16 */,
  /** i8x16.relaxed_swizzle */
  RelaxedSwizzleI8x16 = 210 /* _BinaryenRelaxedSwizzleVecI8x16 */,
  /** f32x4.relaxed_min */
  RelaxedMinF32x4 = 211 /* _BinaryenRelaxedMinVecF32x4 */,
  /** f32x4.relaxed_max */
  RelaxedMaxF32x4 = 212 /* _BinaryenRelaxedMaxVecF32x4 */,
  /** f64x2.relaxed_min */
  RelaxedMinF64x2 = 213 /* _BinaryenRelaxedMinVecF64x2 */,
  /** f64x2.relaxed_max */
  RelaxedMaxF64x2 = 214 /* _BinaryenRelaxedMaxVecF64x2 */,
  /** i16x8.relaxed_q15mulr_s */
  RelaxedQ15MulrI16x8 = 215 /* _BinaryenRelaxedQ15MulrSVecI16x8 */,
  /** i16x8.relaxed_dot_i8x16_i7x16_s */
  RelaxedDotI8x16I7x16ToI16x8 = 216 /* _BinaryenDotI8x16I7x16SToVecI16x8 */,

  _last = RelaxedDotI8x16I7x16ToI16x8,

  // Target dependent

  /** i32.add or i64.add, depending on target word size */
  AddSize,
  /** i32.sub or i64.sub, depending on target word size */
  SubSize,
  /** i32.mul or i64.mul, depending on target word size */
  MulSize,
  /** i32.div_s or i64.div_s, depending on target word size */
  DivISize,
  /** i32.div_u or i64.div_u, depending on target word size */
  DivUSize,
  /** i32.rem_s or i64.rem_s, depending on target word size */
  RemISize,
  /** i32.rem_u or i64.rem_u, depending on target word size */
  RemUSize,
  /** i32.and or i64.and, depending on target word size */
  AndSize,
  /** i32.or or i64.or, depending on target word size */
  OrSize,
  /** i32.xor or i64.xor, depending on target word size */
  XorSize,
  /** i32.shl or i64.shl, depending on target word size */
  ShlSize,
  /** i32.shr_s or i64.shr_s, depending on target word size */
  ShrISize,
  /** i32.shr_u or i64.shr_u, depending on target word size */
  ShrUSize,
  /** i32.rotl or i64.rotl, depending on target word size */
  RotlSize,
  /** i32.rotr or i64.rotr, depending on target word size */
  RotrSize,
  /** i32.eq or i64.eq, depending on target word size */
  EqSize,
  /** i32.ne or i64.ne, depending on target word size */
  NeSize,
  /** i32.lt_s or i64.lt_s, depending on target word size */
  LtISize,
  /** i32.lt_u or i64.lt_u, depending on target word size */
  LtUSize,
  /** i32.le_s or i64.le_s, depending on target word size */
  LeISize,
  /** i32.le_u or i64.le_u, depending on target word size */
  LeUSize,
  /** i32.gt_s or i64.gt_s, depending on target word size */
  GtISize,
  /** i32.gt_u or i64.gt_u, depending on target word size */
  GtUSize,
  /** i32.ge_s or i64.ge_s, depending on target word size */
  GeISize,
  /** i32.ge_u or i64.ge_u, depending on target word size */
  GeUSize,
}

/** Binaryen SIMD extract operation constants. */
export const enum SIMDExtractOp {
  /** i8x16.extract_lane_s */
  ExtractLaneI8x16 = 0 /* _BinaryenExtractLaneSVecI8x16 */,
  /** i8x16.extract_lane_u */
  ExtractLaneU8x16 = 1 /* _BinaryenExtractLaneUVecI8x16 */,
  /** i16x8.extract_lane_s */
  ExtractLaneI16x8 = 2 /* _BinaryenExtractLaneSVecI16x8 */,
  /** i16x8.extract_lane_u */
  ExtractLaneU16x8 = 3 /* _BinaryenExtractLaneUVecI16x8 */,
  /** i32x4.extract_lane_s */
  ExtractLaneI32x4 = 4 /* _BinaryenExtractLaneVecI32x4 */,
  /** i32x4.extract_lane_u */
  ExtractLaneI64x2 = 5 /* _BinaryenExtractLaneVecI64x2 */,
  /** i64x2.extract_lane_s */
  ExtractLaneF32x4 = 7 /* _BinaryenExtractLaneVecF32x4 */,
  /** i64x2.extract_lane_u */
  ExtractLaneF64x2 = 8 /* _BinaryenExtractLaneVecF64x2 */,
}

/** Binaryen SIMD replace operation constants. */
export const enum SIMDReplaceOp {
  /** i8x16.replace_lane */
  ReplaceLaneI8x16 = 0 /* _BinaryenReplaceLaneVecI8x16 */,
  /** i16x8.replace_lane */
  ReplaceLaneI16x8 = 1 /* _BinaryenReplaceLaneVecI16x8 */,
  /** i32x4.replace_lane */
  ReplaceLaneI32x4 = 2 /* _BinaryenReplaceLaneVecI32x4 */,
  /** i64x2.replace_lane */
  ReplaceLaneI64x2 = 3 /* _BinaryenReplaceLaneVecI64x2 */,
  /** f32x4.replace_lane */
  ReplaceLaneF32x4 = 5 /* _BinaryenReplaceLaneVecF32x4 */,
  /** f64x2.replace_lane */
  ReplaceLaneF64x2 = 6 /* _BinaryenReplaceLaneVecF64x2 */,
}

/** Binaryen SIMD shift operation constants. */
export const enum SIMDShiftOp {
  /** i8x16.shl */
  ShlI8x16 = 0 /* _BinaryenShlVecI8x16 */,
  /** i8x16.shr_s */
  ShrI8x16 = 1 /* _BinaryenShrSVecI8x16 */,
  /** i8x16.shr_u */
  ShrU8x16 = 2 /* _BinaryenShrUVecI8x16 */,
  /** i16x8.shl */
  ShlI16x8 = 3 /* _BinaryenShlVecI16x8 */,
  /** i16x8.shr_s */
  ShrI16x8 = 4 /* _BinaryenShrSVecI16x8 */,
  /** i16x8.shr_u */
  ShrU16x8 = 5 /* _BinaryenShrUVecI16x8 */,
  /** i16x8.shl */
  ShlI32x4 = 6 /* _BinaryenShlVecI32x4 */,
  /** i32x4.shr_s */
  ShrI32x4 = 7 /* _BinaryenShrSVecI32x4 */,
  /** i32x4.shr_u */
  ShrU32x4 = 8 /* _BinaryenShrUVecI32x4 */,
  /** i64x2.shl */
  ShlI64x2 = 9 /* _BinaryenShlVecI64x2 */,
  /** i64x2.shr_u */
  ShrI64x2 = 10 /* _BinaryenShrSVecI64x2 */,
  /** i64x2.shr_u */
  ShrU64x2 = 11 /* _BinaryenShrUVecI64x2 */,
}

/** Binaryen SIMD load operation constants. */
export const enum SIMDLoadOp {
  /** v128.load8_splat */
  Load8Splat = 0 /* _BinaryenLoad8SplatVec128 */,
  /** v128.load16_splat */
  Load16Splat = 1 /* _BinaryenLoad16SplatVec128 */,
  /** v128.load32_splat */
  Load32Splat = 2 /* _BinaryenLoad32SplatVec128 */,
  /** v128.load64_splat */
  Load64Splat = 3 /* _BinaryenLoad64SplatVec128 */,
  /** v128.load8x8_s */
  Load8x8S = 4 /* _BinaryenLoad8x8SVec128 */,
  /** v128.load8x8_u */
  Load8x8U = 5 /* _BinaryenLoad8x8UVec128 */,
  /** v128.load16x4_s */
  Load16x4S = 6 /* _BinaryenLoad16x4SVec128 */,
  /** v128.load16x4_u */
  Load16x4U = 7 /* _BinaryenLoad16x4UVec128 */,
  /** v128.load32x2_s */
  Load32x2S = 8 /* _BinaryenLoad32x2SVec128 */,
  /** v128.load32x2_u */
  Load32x2U = 9 /* _BinaryenLoad32x2UVec128 */,
  /** v128.load32_zero */
  Load32Zero = 10 /* _BinaryenLoad32ZeroVec128 */,
  /** v128.load64_zero */
  Load64Zero = 11 /* _BinaryenLoad64ZeroVec128 */,
}

/** Binaryen SIMD load/store lane operation constants. */
export const enum SIMDLoadStoreLaneOp {
  /** v128.load8_lane */
  Load8Lane = 0 /* _BinaryenLoad8LaneVec128 */,
  /** v128.load16_lane */
  Load16Lane = 1 /* _BinaryenLoad16LaneVec128 */,
  /** v128.load32_lane */
  Load32Lane = 2 /* _BinaryenLoad32LaneVec128 */,
  /** v128.load64_lane */
  Load64Lane = 3 /* _BinaryenLoad64LaneVec128 */,
  /** v128.store8_lane */
  Store8Lane = 4 /* _BinaryenStore8LaneVec128 */,
  /** v128.store16_lane */
  Store16Lane = 5 /* _BinaryenStore16LaneVec128 */,
  /** v128.store32_lane */
  Store32Lane = 6 /* _BinaryenStore32LaneVec128 */,
  /** v128.store64_lane */
  Store64Lane = 7 /* _BinaryenStore64LaneVec128 */,
}

/** Binaryen SIMD ternary operation constants. */
export const enum SIMDTernaryOp {
  /** v128.bitselect */
  Bitselect = 0 /* _BinaryenBitselectVec128 */,

  /** f32x4.relaxed_madd */
  RelaxedMaddF32x4 = 3 /* _BinaryenRelaxedMaddVecF32x4 */,
  /** f32x4.relaxed_nmadd */
  RelaxedNmaddF32x4 = 4 /* _BinaryenRelaxedNmaddVecF32x4 */,
  /** f64x2.relaxed_madd */
  RelaxedMaddF64x2 = 5 /* _BinaryenRelaxedMaddVecF64x2 */,
  /** f64x2.relaxed_nmadd */
  RelaxedNmaddF64x2 = 6 /* _BinaryenRelaxedNmaddVecF64x2 */,
  /** i8x16.relaxed_laneselect */
  RelaxedLaneselectI8x16 = 7 /* _BinaryenLaneselectI8x16 */,
  /** i16x8.relaxed_laneselect */
  RelaxedLaneselectI16x8 = 8 /* _BinaryenLaneselectI16x8 */,
  /** i32x4.relaxed_laneselect */
  RelaxedLaneselectI32x4 = 9 /* _BinaryenLaneselectI32x4 */,
  /** i64x2.relaxed_laneselect */
  RelaxedLaneselectI64x2 = 10 /* _BinaryenLaneselectI64x2 */,
  /** i32x4.relaxed_dot_i8x16_i7x16_add_s */
  RelaxedDotI8x16I7x16AddToI32x4 = 11 /* _BinaryenDotI8x16I7x16AddSToVecI32x4 */,
}

/** Binaryen RefAs operation constants. */
export const enum RefAsOp {
  /** ref.as_non_null */
  NonNull = 0 /* _BinaryenRefAsNonNull */,
  /** any.convert_extern */
  ExternInternalize = 1 /* _BinaryenRefAsAnyConvertExtern */,
  /** extern.convert_any */
  ExternExternalize = 2 /* _BinaryenRefAsExternConvertAny */,
}

/** Binaryen BrOn operation constants. */
export const enum BrOnOp {
  /** br_on_null */
  Null = 0 /* _BinaryenBrOnNull */,
  /** br_on_non_null */
  NonNull = 1 /* _BinaryenBrOnNonNull */,
  /** br_on_cast */
  Cast = 2 /* _BinaryenBrOnCast */,
  /** br_on_cast_fail */
  CastFail = 3 /* _BinaryenBrOnCastFail */,
}

/** Binaryen StringNew operation constants. */
export const enum StringNewOp {
  /** string.new_wtf8_array replace */
  LossyUTF8Array = 0 /* _BinaryenStringNewLossyUTF8Array */,
  /** string.new_wtf16_array */
  WTF16Array = 1 /* _BinaryenStringNewWTF16Array */,
  /** string.from_code_point */
  FromCodePoint = 2 /* _BinaryenStringNewFromCodePoint */,
}

/** Binaryen StringMeasure operation constants. */
export const enum StringMeasureOp {
  /** string.measure_wtf8 utf8 */
  UTF8 = 0 /* _BinaryenStringMeasureUTF8 */,
  /** string.measure_wtf16 */
  WTF16 = 1 /* _BinaryenStringMeasureWTF16 */,
}

/** Binaryen StringEncode operation constants. */
export const enum StringEncodeOp {
  /** string.encode_lossy_utf8_array utf8 */
  LossyUTF8Array = 0 /* _BinaryenStringEncodeLossyUTF8Array */,
  /** string.encode_wtf16_array */
  WTF16Array = 1 /* _BinaryenStringEncodeWTF16Array */,
}

/** Binaryen StringEq operation constants. */
export const enum StringEqOp {
  /** string.eq */
  Equal = 0 /* _BinaryenStringEqEqual */,
  /** string.compare */
  Compare = 1 /* _BinaryenStringEqCompare */,
}

/** Binaryen expression runner flags. */
export const enum ExpressionRunnerFlags {
  Default = 0 /* _ExpressionRunnerFlagsDefault */,
  PreserveSideeffects = 1 /* _ExpressionRunnerFlagsPreserveSideeffects */,
}
