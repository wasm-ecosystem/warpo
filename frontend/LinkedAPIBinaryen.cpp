// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <vector>

#include "LinkedAPI.hpp"
#include "binaryen/src/binaryen-c.h"
#include "binaryen/src/literal.h"

#include "src/WasmModule/WasmModule.hpp"
#include "src/core/common/NativeSymbol.hpp"
#include "src/core/common/function_traits.hpp"

namespace warpo::frontend {
namespace {

uint64_t BinaryenCallGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenReturnCallForLink(uint64_t module, uint64_t name, uint64_t operands, uint32_t numOperands,
                                   uint64_t returnType, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenReturnCall(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
      reinterpret_cast<BinaryenExpressionRef *>(operands), numOperands, static_cast<BinaryenType>(returnType)));
}
uint64_t BinaryenCallForLink(uint64_t module, uint64_t name, uint64_t operands, uint32_t numOperands,
                             uint64_t returnType, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCall(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
      reinterpret_cast<BinaryenExpressionRef *>(operands), numOperands, static_cast<BinaryenType>(returnType)));
}
uint32_t BinaryenLoadGetBytesForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenLoadGetBytes(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenBlockGetNameForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBlockGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenBlockGetNumChildrenForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenBlockGetNumChildren(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenBlockGetChildAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBlockGetChildAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenIfGetIfTrueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenIfGetIfTrue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenIfGetIfFalseForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenIfGetIfFalse(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSelectGetIfTrueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSelectGetIfTrue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSelectGetIfFalseForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSelectGetIfFalse(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenCallGetTargetForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallGetTarget(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenConstForLink(uint64_t module, uint64_t literal, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenConst(reinterpret_cast<BinaryenModuleRef>(module), *reinterpret_cast<BinaryenLiteral *>(literal)));
}
uint64_t BinaryenNopForLink(uint64_t module, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenNop(reinterpret_cast<BinaryenModuleRef>(module)));
}
uint64_t BinaryenBlockForLink(uint64_t module, uint64_t name, uint64_t children, uint32_t numChildren, uint64_t type,
                              [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenBlock(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
                    reinterpret_cast<BinaryenExpressionRef *>(children), numChildren, type));
}
uint64_t BinaryenBinaryForLink(uint64_t module, uint32_t op, uint64_t left, uint64_t right,
                               [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenBinary(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op),
                     reinterpret_cast<BinaryenExpressionRef>(left), reinterpret_cast<BinaryenExpressionRef>(right)));
}
uint64_t BinaryenUnaryForLink(uint64_t module, uint32_t op, uint64_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenUnary(reinterpret_cast<BinaryenModuleRef>(module),
                                                  static_cast<BinaryenOp>(op),
                                                  reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenRefIsNullForLink(uint64_t module, uint64_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenRefIsNull(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t ExpressionRunnerCreateForLink(uint64_t module, uint32_t flags, uint32_t maxDepth, uint32_t maxLoopIterations,
                                       [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      ExpressionRunnerCreate(reinterpret_cast<BinaryenModuleRef>(module), flags, maxDepth, maxLoopIterations));
}
uint64_t ExpressionRunnerRunAndDisposeForLink(uint64_t runner, uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(ExpressionRunnerRunAndDispose(reinterpret_cast<ExpressionRunnerRef>(runner),
                                                                  reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenTypeExternrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeExternref(); }
uint64_t BinaryenTypeAnyrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeAnyref(); }
uint64_t BinaryenTypeEqrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeEqref(); }
uint64_t BinaryenTypeStructrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeStructref(); }
uint64_t BinaryenTypeArrayrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeArrayref(); }
uint64_t BinaryenTypeI31refForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeI31ref(); }
uint64_t BinaryenTypeStringrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeStringref(); }
uint64_t BinaryenTypeNullrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeNullref(); }
uint64_t BinaryenTypeNullFuncrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeNullFuncref(); }
uint64_t BinaryenTypeNullExternrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeNullExternref(); }
uint64_t BinaryenUnreachableForLink(uint64_t module, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenUnreachable(reinterpret_cast<BinaryenModuleRef>(module)));
}
uint32_t BinaryenExpressionGetIdForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint32_t>(BinaryenExpressionGetId(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenLocalSetIsTeeForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenLocalSetIsTee(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenLocalSetGetIndexForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenLocalSetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenLocalGetGetIndexForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenLocalGetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenLocalSetGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLocalSetGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenGlobalGetGetNameForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalGetGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
int32_t BinaryenBinaryGetOpForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<int32_t>(BinaryenBinaryGetOp(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBinaryGetLeftForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBinaryGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBinaryGetRightForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBinaryGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
int32_t BinaryenConstGetValueI32ForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenConstGetValueI32(reinterpret_cast<BinaryenExpressionRef>(expr));
}
int32_t BinaryenUnaryGetOpForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<int32_t>(BinaryenUnaryGetOp(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenExpressionGetTypeForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint64_t>(BinaryenExpressionGetType(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
int32_t BinaryenConstGetValueI64LowForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenConstGetValueI64Low(reinterpret_cast<BinaryenExpressionRef>(expr));
}
int32_t BinaryenConstGetValueI64HighForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenConstGetValueI64High(reinterpret_cast<BinaryenExpressionRef>(expr));
}
float BinaryenConstGetValueF32ForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenConstGetValueF32(reinterpret_cast<BinaryenExpressionRef>(expr));
}
double BinaryenConstGetValueF64ForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenConstGetValueF64(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint32_t BinaryenLoadIsSignedForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenLoadIsSigned(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenTypeFuncrefForLink([[maybe_unused]] vb::WasmModule *ctx) { return BinaryenTypeFuncref(); }
uint32_t BinaryenSizeofLiteralForLink([[maybe_unused]] vb::WasmModule *ctx) { return sizeof(wasm::Literal); }
void BinaryenLiteralInt32ForLink(uint64_t ptr, int32_t x, [[maybe_unused]] vb::WasmModule *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralInt32(x);
}
void BinaryenLiteralInt64ForLink(uint64_t ptr, int32_t x, int32_t y, [[maybe_unused]] vb::WasmModule *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralInt64(static_cast<int64_t>(
      (static_cast<uint64_t>(static_cast<uint32_t>(y)) << 32U) | static_cast<uint64_t>(static_cast<uint32_t>(x))));
}
void BinaryenSetMemoryForLink(uint64_t module, uint32_t initial, uint32_t maximum, uint64_t exportName,
                              uint64_t segmentNames, uint64_t segmentDatas, uint64_t segmentPassives,
                              uint64_t segmentOffsets, uint64_t segmentSizes, uint32_t numSegments, uint32_t shared,
                              uint32_t memory64, uint64_t name, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenSetMemory(reinterpret_cast<BinaryenModuleRef>(module), initial, maximum,
                    reinterpret_cast<const char *>(exportName), reinterpret_cast<const char **>(segmentNames),
                    reinterpret_cast<const char **>(segmentDatas), reinterpret_cast<bool *>(segmentPassives),
                    reinterpret_cast<BinaryenExpressionRef *>(segmentOffsets),
                    reinterpret_cast<BinaryenIndex *>(segmentSizes), numSegments, shared != 0, memory64 != 0,
                    reinterpret_cast<const char *>(name));
}
uint32_t BinaryenModuleGetFeaturesForLink(uint64_t module, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenModuleGetFeatures(reinterpret_cast<BinaryenModuleRef>(module));
}
uint64_t BinaryenIfGetConditionForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenIfGetCondition(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenUnaryGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenUnaryGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenCallGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenCallGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenDropForLink(uint64_t module, uint64_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenDrop(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenIfForLink(uint64_t module, uint64_t condition, uint64_t ifTrue, uint64_t ifFalse,
                           [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenIf(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(condition),
                 reinterpret_cast<BinaryenExpressionRef>(ifTrue), reinterpret_cast<BinaryenExpressionRef>(ifFalse)));
}
uint64_t BinaryenLoopForLink(uint64_t module, uint64_t in, uint64_t body, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoop(reinterpret_cast<BinaryenModuleRef>(module),
                                                 reinterpret_cast<const char *>(in),
                                                 reinterpret_cast<BinaryenExpressionRef>(body)));
}
uint64_t BinaryenBreakForLink(uint64_t module, uint64_t name, uint64_t condition, uint64_t value,
                              [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBreak(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
      reinterpret_cast<BinaryenExpressionRef>(condition), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenReturnForLink(uint64_t module, uint64_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenReturn(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenLocalSetForLink(uint64_t module, uint32_t index, uint64_t value,
                                 [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLocalSet(reinterpret_cast<BinaryenModuleRef>(module), index,
                                                     reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenTypeFromHeapTypeForLink(uint64_t heapType, uint32_t nullable, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenTypeFromHeapType(static_cast<BinaryenHeapType>(heapType), nullable != 0);
}
uint64_t BinaryenTypeGetHeapTypeForLink(uint64_t type, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenTypeGetHeapType(static_cast<BinaryenType>(type));
}
uint64_t TypeBuilderCreateForLink(uint32_t size, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(TypeBuilderCreate(size));
}
uint32_t TypeBuilderGetSizeForLink(uint64_t builder, [[maybe_unused]] vb::WasmModule *ctx) {
  return TypeBuilderGetSize(reinterpret_cast<TypeBuilderRef>(builder));
}
void TypeBuilderGrowForLink(uint64_t builder, uint32_t count, [[maybe_unused]] vb::WasmModule *ctx) {
  TypeBuilderGrow(reinterpret_cast<TypeBuilderRef>(builder), count);
}
uint64_t TypeBuilderGetTempHeapTypeForLink(uint64_t builder, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return TypeBuilderGetTempHeapType(reinterpret_cast<TypeBuilderRef>(builder), index);
}
uint64_t TypeBuilderGetTempRefTypeForLink(uint64_t builder, uint64_t heapType, int32_t nullable,
                                          [[maybe_unused]] vb::WasmModule *ctx) {
  return TypeBuilderGetTempRefType(reinterpret_cast<TypeBuilderRef>(builder), heapType, nullable);
}
void TypeBuilderSetStructTypeForLink(uint64_t builder, uint32_t index, uint64_t fieldTypes, uint64_t fieldPackedTypes,
                                     uint64_t fieldMutables, uint32_t numFields, [[maybe_unused]] vb::WasmModule *ctx) {
  TypeBuilderSetStructType(reinterpret_cast<TypeBuilderRef>(builder), index,
                           reinterpret_cast<BinaryenType *>(fieldTypes),
                           reinterpret_cast<BinaryenPackedType *>(fieldPackedTypes),
                           reinterpret_cast<bool *>(fieldMutables), static_cast<int32_t>(numFields));
}
void TypeBuilderSetSubTypeForLink(uint64_t builder, uint32_t index, uint64_t superType,
                                  [[maybe_unused]] vb::WasmModule *ctx) {
  TypeBuilderSetSubType(reinterpret_cast<TypeBuilderRef>(builder), index, static_cast<BinaryenHeapType>(superType));
}
uint64_t TypeBuilderGetTempTupleTypeForLink(uint64_t builder, uint64_t types, uint32_t numTypes,
                                            [[maybe_unused]] vb::WasmModule *ctx) {
  return TypeBuilderGetTempTupleType(reinterpret_cast<TypeBuilderRef>(builder), reinterpret_cast<BinaryenType *>(types),
                                     numTypes);
}
void TypeBuilderSetSignatureTypeForLink(uint64_t builder, uint32_t index, uint64_t paramTypes, uint64_t resultTypes,
                                        [[maybe_unused]] vb::WasmModule *ctx) {
  TypeBuilderSetSignatureType(reinterpret_cast<TypeBuilderRef>(builder), index, static_cast<BinaryenType>(paramTypes),
                              static_cast<BinaryenType>(resultTypes));
}
uint32_t TypeBuilderBuildAndDisposeForLink(uint64_t builder, uint64_t heapTypes, uint64_t errorIndex,
                                           uint64_t errorReason, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(TypeBuilderBuildAndDispose(
      reinterpret_cast<TypeBuilderRef>(builder), reinterpret_cast<BinaryenHeapType *>(heapTypes),
      reinterpret_cast<BinaryenIndex *>(errorIndex), reinterpret_cast<TypeBuilderErrorReason *>(errorReason)));
}
uint32_t BinaryenStructTypeGetNumFieldsForLink(uint64_t heapType, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenStructTypeGetNumFields(static_cast<BinaryenHeapType>(heapType));
}
void BinaryenModuleSetFieldNameForLink(uint64_t module, uint64_t heapType, uint32_t index, uint64_t name,
                                       [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenModuleSetFieldName(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenHeapType>(heapType),
                             index, reinterpret_cast<const char *>(name));
}
uint64_t BinaryenLocalGetForLink(uint64_t module, uint32_t index, uint64_t type, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenLocalGet(reinterpret_cast<BinaryenModuleRef>(module), index, static_cast<BinaryenType>(type)));
}
uint64_t BinaryenAddFunctionForLink(uint64_t module, uint64_t name, uint64_t params, uint64_t results,
                                    uint64_t varTypes, uint32_t numVarTypes, uint64_t body,
                                    [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddFunction(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
      static_cast<BinaryenType>(params), static_cast<BinaryenType>(results), reinterpret_cast<BinaryenType *>(varTypes),
      numVarTypes, reinterpret_cast<BinaryenExpressionRef>(body)));
}
uint64_t BinaryenLocalTeeForLink(uint64_t module, uint32_t index, uint64_t value, uint64_t type,
                                 [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLocalTee(reinterpret_cast<BinaryenModuleRef>(module), index,
                                                     reinterpret_cast<BinaryenExpressionRef>(value),
                                                     static_cast<BinaryenType>(type)));
}
void BinaryenAddGlobalImportForLink(uint64_t module, uint64_t internalName, uint64_t externalModuleName,
                                    uint64_t externalBaseName, uint64_t globalType, uint32_t mutable_,
                                    [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenAddGlobalImport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(internalName),
                          reinterpret_cast<const char *>(externalModuleName),
                          reinterpret_cast<const char *>(externalBaseName), static_cast<BinaryenType>(globalType),
                          mutable_ != 0);
}
uint64_t BinaryenGetGlobalForLink(uint64_t module, uint64_t name, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenGetGlobal(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name)));
}
uint32_t BinaryenGlobalIsMutableForLink(uint64_t global, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenGlobalIsMutable(reinterpret_cast<BinaryenGlobalRef>(global)));
}
void BinaryenLiteralFloat64ForLink(uint64_t ptr, double x, [[maybe_unused]] vb::WasmModule *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralFloat64(x);
}
void BinaryenLiteralFloat32ForLink(uint64_t ptr, float x, [[maybe_unused]] vb::WasmModule *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralFloat32(x);
}
void BinaryenLiteralVec128ForLink(uint64_t ptr, uint64_t bytes, [[maybe_unused]] vb::WasmModule *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralVec128(reinterpret_cast<const uint8_t *>(bytes));
}
uint64_t BinaryenRefNullForLink(uint64_t module, uint64_t type, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenRefNull(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenType>(type)));
}
uint64_t BinaryenRefI31ForLink(uint64_t module, uint64_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenRefI31(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenAddGlobalForLink(uint64_t module, uint64_t name, uint64_t type, uint32_t mutable_, uint64_t init,
                                  [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenAddGlobal(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
                        static_cast<BinaryenType>(type), mutable_ != 0, reinterpret_cast<BinaryenExpressionRef>(init)));
}
uint64_t BinaryenGlobalSetForLink(uint64_t module, uint64_t name, uint64_t value,
                                  [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalSet(reinterpret_cast<BinaryenModuleRef>(module),
                                                      reinterpret_cast<const char *>(name),
                                                      reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenGlobalGetForLink(uint64_t module, uint64_t name, uint64_t type, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalGet(reinterpret_cast<BinaryenModuleRef>(module),
                                                      reinterpret_cast<const char *>(name),
                                                      static_cast<BinaryenType>(type)));
}
uint64_t BinaryenSwitchForLink(uint64_t module, uint64_t names, uint32_t numNames, uint64_t defaultName,
                               uint64_t condition, uint64_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSwitch(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char **>(names), numNames,
                     reinterpret_cast<const char *>(defaultName), reinterpret_cast<BinaryenExpressionRef>(condition),
                     reinterpret_cast<BinaryenExpressionRef>(value)));
}
void BinaryenConstGetValueV128ForLink(uint64_t expr, uint64_t out, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenConstGetValueV128(reinterpret_cast<BinaryenExpressionRef>(expr), reinterpret_cast<uint8_t *>(out));
}
uint64_t BinaryenTypeCreateForLink(uint64_t types, uint32_t numTypes, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenTypeCreate(reinterpret_cast<BinaryenType *>(types), numTypes);
}
void BinaryenFunctionSetDebugLocationForLink(uint64_t func, uint64_t expr, uint32_t fileIndex, uint32_t lineNumber,
                                             uint32_t columnNumber, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenFunctionSetDebugLocation(reinterpret_cast<BinaryenFunctionRef>(func),
                                   reinterpret_cast<BinaryenExpressionRef>(expr), fileIndex, lineNumber, columnNumber);
}
void BinaryenFunctionSetLocalNameForLink(uint64_t func, uint32_t index, uint64_t name,
                                         [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenFunctionSetLocalName(reinterpret_cast<BinaryenFunctionRef>(func), index,
                               reinterpret_cast<const char *>(name));
}
uint32_t BinaryenExpressionGetSideEffectsForLink(uint64_t expr, uint64_t module, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenExpressionGetSideEffects(reinterpret_cast<BinaryenExpressionRef>(expr),
                                                                reinterpret_cast<BinaryenModuleRef>(module)));
}
uint64_t BinaryenRefEqForLink(uint64_t module, uint64_t left, uint64_t right, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefEq(reinterpret_cast<BinaryenModuleRef>(module),
                                                  reinterpret_cast<BinaryenExpressionRef>(left),
                                                  reinterpret_cast<BinaryenExpressionRef>(right)));
}
uint64_t BinaryenStringEqForLink(uint64_t module, int32_t op, uint64_t left, uint64_t right,
                                 [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEq(reinterpret_cast<BinaryenModuleRef>(module), op,
                                                     reinterpret_cast<BinaryenExpressionRef>(left),
                                                     reinterpret_cast<BinaryenExpressionRef>(right)));
}
uint32_t BinaryenModuleAddDebugInfoFileNameForLink(uint64_t module, uint64_t filename,
                                                   [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenModuleAddDebugInfoFileName(reinterpret_cast<BinaryenModuleRef>(module),
                                            reinterpret_cast<const char *>(filename));
}
void BinaryenAddFunctionImportForLink(uint64_t module, uint64_t internalName, uint64_t externalModuleName,
                                      uint64_t externalBaseName, uint64_t params, uint64_t results,
                                      [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenAddFunctionImport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(internalName),
                            reinterpret_cast<const char *>(externalModuleName),
                            reinterpret_cast<const char *>(externalBaseName), static_cast<BinaryenType>(params),
                            static_cast<BinaryenType>(results));
}
uint64_t BinaryenGetFunctionForLink(uint64_t module, uint64_t name, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenGetFunction(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name)));
}
uint64_t BinaryenLoadForLink(uint64_t module, uint32_t bytes, uint32_t signed_, uint32_t offset, uint32_t align,
                             uint64_t type, uint64_t ptr, uint64_t memoryName, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoad(
      reinterpret_cast<BinaryenModuleRef>(module), bytes, signed_ != 0, offset, align, static_cast<BinaryenType>(type),
      reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenStoreForLink(uint64_t module, uint32_t bytes, uint32_t offset, uint32_t align, uint64_t ptr,
                              uint64_t value, uint64_t type, uint64_t memoryName,
                              [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenStore(reinterpret_cast<BinaryenModuleRef>(module), bytes, offset, align,
                    reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<BinaryenExpressionRef>(value),
                    static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint32_t BinaryenTypeIsNullableForLink(uint64_t type, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenTypeIsNullable(static_cast<BinaryenType>(type)));
}
uint64_t BinaryenRefAsForLink(uint64_t module, uint32_t op, uint64_t ref, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefAs(reinterpret_cast<BinaryenModuleRef>(module),
                                                  static_cast<BinaryenOp>(op),
                                                  reinterpret_cast<BinaryenExpressionRef>(ref)));
}
uint64_t BinaryenSelectForLink(uint64_t module, uint64_t condition, uint64_t ifTrue, uint64_t ifFalse,
                               [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSelect(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(condition),
      reinterpret_cast<BinaryenExpressionRef>(ifTrue), reinterpret_cast<BinaryenExpressionRef>(ifFalse)));
}
uint64_t BinaryenExpressionCopyForLink(uint64_t expr, uint64_t module, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenExpressionCopy(reinterpret_cast<BinaryenExpressionRef>(expr),
                                                           reinterpret_cast<BinaryenModuleRef>(module)));
}
uint64_t BinaryenReturnCallIndirectForLink(uint64_t module, uint64_t table, uint64_t target, uint64_t operands,
                                           uint32_t numOperands, uint64_t params, uint64_t results,
                                           [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenReturnCallIndirect(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(table),
      reinterpret_cast<BinaryenExpressionRef>(target), reinterpret_cast<BinaryenExpressionRef *>(operands), numOperands,
      static_cast<BinaryenType>(params), static_cast<BinaryenType>(results)));
}
uint64_t BinaryenCallIndirectForLink(uint64_t module, uint64_t table, uint64_t target, uint64_t operands,
                                     uint32_t numOperands, uint64_t params, uint64_t results,
                                     [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallIndirect(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(table),
      reinterpret_cast<BinaryenExpressionRef>(target), reinterpret_cast<BinaryenExpressionRef *>(operands), numOperands,
      static_cast<BinaryenType>(params), static_cast<BinaryenType>(results)));
}
uint64_t BinaryenRefFuncForLink(uint64_t module, uint64_t func, uint64_t type, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefFunc(reinterpret_cast<BinaryenModuleRef>(module),
                                                    reinterpret_cast<const char *>(func),
                                                    static_cast<BinaryenType>(type)));
}
uint64_t BinaryenAtomicLoadForLink(uint64_t module, uint32_t bytes, uint32_t offset, uint64_t type, uint64_t ptr,
                                   uint64_t memoryName, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenAtomicLoad(reinterpret_cast<BinaryenModuleRef>(module), bytes, offset, static_cast<BinaryenType>(type),
                         reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicStoreForLink(uint64_t module, uint32_t bytes, uint32_t offset, uint64_t ptr, uint64_t value,
                                    uint64_t type, uint64_t memoryName, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenAtomicStore(reinterpret_cast<BinaryenModuleRef>(module), bytes, offset,
                          reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<BinaryenExpressionRef>(value),
                          static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicRMWForLink(uint64_t module, uint32_t op, uint32_t bytes, uint32_t offset, uint64_t ptr,
                                  uint64_t value, uint64_t type, uint64_t memoryName,
                                  [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenAtomicRMW(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op), bytes, offset,
                        reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<BinaryenExpressionRef>(value),
                        static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicCmpxchgForLink(uint64_t module, uint32_t bytes, uint32_t offset, uint64_t ptr, uint64_t expected,
                                      uint64_t replacement, uint64_t type, uint64_t memoryName,
                                      [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicCmpxchg(
      reinterpret_cast<BinaryenModuleRef>(module), bytes, offset, reinterpret_cast<BinaryenExpressionRef>(ptr),
      reinterpret_cast<BinaryenExpressionRef>(expected), reinterpret_cast<BinaryenExpressionRef>(replacement),
      static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicWaitForLink(uint64_t module, uint64_t ptr, uint64_t expected, uint64_t timeout, uint64_t type,
                                   uint64_t memoryName, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicWait(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(ptr),
      reinterpret_cast<BinaryenExpressionRef>(expected), reinterpret_cast<BinaryenExpressionRef>(timeout),
      static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicNotifyForLink(uint64_t module, uint64_t ptr, uint64_t notifyCount, uint64_t memoryName,
                                     [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicNotify(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(ptr),
      reinterpret_cast<BinaryenExpressionRef>(notifyCount), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicFenceForLink(uint64_t module, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicFence(reinterpret_cast<BinaryenModuleRef>(module)));
}
uint64_t BinaryenMemorySizeForLink(uint64_t module, uint64_t memoryName, uint32_t memoryIs64,
                                   [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemorySize(reinterpret_cast<BinaryenModuleRef>(module),
                                                       reinterpret_cast<const char *>(memoryName), memoryIs64 != 0));
}
uint64_t BinaryenMemoryGrowForLink(uint64_t module, uint64_t delta, uint64_t memoryName, uint32_t memoryIs64,
                                   [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryGrow(reinterpret_cast<BinaryenModuleRef>(module),
                                                       reinterpret_cast<BinaryenExpressionRef>(delta),
                                                       reinterpret_cast<const char *>(memoryName), memoryIs64 != 0));
}
uint64_t BinaryenMemoryCopyForLink(uint64_t module, uint64_t dest, uint64_t source, uint64_t size,
                                   uint64_t destMemoryName, uint64_t sourceMemoryName,
                                   [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryCopy(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(dest),
      reinterpret_cast<BinaryenExpressionRef>(source), reinterpret_cast<BinaryenExpressionRef>(size),
      reinterpret_cast<const char *>(destMemoryName), reinterpret_cast<const char *>(sourceMemoryName)));
}
uint64_t BinaryenMemoryFillForLink(uint64_t module, uint64_t dest, uint64_t value, uint64_t size, uint64_t memoryName,
                                   [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenMemoryFill(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(dest),
                         reinterpret_cast<BinaryenExpressionRef>(value), reinterpret_cast<BinaryenExpressionRef>(size),
                         reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenI31GetForLink(uint64_t module, uint64_t i31, uint32_t signed_, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenI31Get(reinterpret_cast<BinaryenModuleRef>(module),
                                                   reinterpret_cast<BinaryenExpressionRef>(i31), signed_ != 0));
}
uint64_t BinaryenSIMDReplaceForLink(uint64_t module, uint32_t op, uint64_t vec, uint32_t index, uint64_t value,
                                    [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDReplace(
      reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op),
      reinterpret_cast<BinaryenExpressionRef>(vec), index, reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenSIMDExtractForLink(uint64_t module, uint32_t op, uint64_t vec, uint32_t index,
                                    [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDExtract(reinterpret_cast<BinaryenModuleRef>(module),
                                                        static_cast<BinaryenOp>(op),
                                                        reinterpret_cast<BinaryenExpressionRef>(vec), index));
}
uint64_t BinaryenSIMDShuffleForLink(uint64_t module, uint64_t left, uint64_t right, uint64_t mask,
                                    [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSIMDShuffle(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(left),
                          reinterpret_cast<BinaryenExpressionRef>(right), reinterpret_cast<const uint8_t *>(mask)));
}
uint64_t BinaryenSIMDLoadForLink(uint64_t module, uint32_t op, uint32_t offset, uint32_t align, uint64_t ptr,
                                 uint64_t memoryName, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSIMDLoad(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op), offset, align,
                       reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenSIMDLoadStoreLaneForLink(uint64_t module, uint32_t op, uint32_t offset, uint32_t align, uint32_t index,
                                          uint64_t ptr, uint64_t vec, uint64_t memoryName,
                                          [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDLoadStoreLane(
      reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op), offset, align, index,
      reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<BinaryenExpressionRef>(vec),
      reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenSIMDShiftForLink(uint64_t module, uint32_t op, uint64_t vec, uint64_t shift,
                                  [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSIMDShift(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op),
                        reinterpret_cast<BinaryenExpressionRef>(vec), reinterpret_cast<BinaryenExpressionRef>(shift)));
}
uint64_t BinaryenSIMDTernaryForLink(uint64_t module, uint32_t op, uint64_t a, uint64_t b, uint64_t c,
                                    [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSIMDTernary(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op),
                          reinterpret_cast<BinaryenExpressionRef>(a), reinterpret_cast<BinaryenExpressionRef>(b),
                          reinterpret_cast<BinaryenExpressionRef>(c)));
}
uint64_t BinaryenModuleCreateForLink([[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenModuleCreate());
}
void BinaryenSetLowMemoryUnusedForLink(uint32_t unused, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenSetLowMemoryUnused(unused != 0);
}
void BinaryenModuleSetFeaturesForLink(uint64_t module, uint32_t features, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenModuleSetFeatures(reinterpret_cast<BinaryenModuleRef>(module), features);
}
void BinaryenSetClosedWorldForLink(uint32_t closed, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenSetClosedWorld(closed != 0);
}
uint64_t BinaryenGetExportForLink(uint64_t module, uint64_t name, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenGetExport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name)));
}
uint64_t BinaryenAddFunctionExportForLink(uint64_t module, uint64_t internalName, uint64_t externalName,
                                          [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddFunctionExport(reinterpret_cast<BinaryenModuleRef>(module),
                                                              reinterpret_cast<const char *>(internalName),
                                                              reinterpret_cast<const char *>(externalName)));
}
uint64_t BinaryenAddGlobalExportForLink(uint64_t module, uint64_t internalName, uint64_t externalName,
                                        [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddGlobalExport(reinterpret_cast<BinaryenModuleRef>(module),
                                                            reinterpret_cast<const char *>(internalName),
                                                            reinterpret_cast<const char *>(externalName)));
}
void BinaryenRemoveFunctionForLink(uint64_t module, uint64_t name, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenRemoveFunction(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name));
}
void BinaryenRemoveGlobalForLink(uint64_t module, uint64_t name, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenRemoveGlobal(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name));
}
void BinaryenAddMemoryImportForLink(uint64_t module, uint64_t internalName, uint64_t externalModuleName,
                                    uint64_t externalBaseName, uint32_t shared, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenAddMemoryImport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(internalName),
                          reinterpret_cast<const char *>(externalModuleName),
                          reinterpret_cast<const char *>(externalBaseName), shared != 0 ? 1U : 0U);
}
void BinaryenAddTableImportForLink(uint64_t module, uint64_t internalName, uint64_t externalModuleName,
                                   uint64_t externalBaseName, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenAddTableImport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(internalName),
                         reinterpret_cast<const char *>(externalModuleName),
                         reinterpret_cast<const char *>(externalBaseName));
}
uint64_t BinaryenAddTableExportForLink(uint64_t module, uint64_t internalName, uint64_t externalName,
                                       [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddTableExport(reinterpret_cast<BinaryenModuleRef>(module),
                                                           reinterpret_cast<const char *>(internalName),
                                                           reinterpret_cast<const char *>(externalName)));
}
void BinaryenSetPassArgumentForLink(uint64_t key, uint64_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenSetPassArgument(reinterpret_cast<const char *>(key), reinterpret_cast<const char *>(value));
}
uint64_t BinaryenGetTableForLink(uint64_t module, uint64_t name, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenGetTable(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name)));
}
uint64_t BinaryenAddTableForLink(uint64_t module, uint64_t name, uint32_t initial, uint32_t maximum, uint64_t type,
                                 [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddTable(reinterpret_cast<BinaryenModuleRef>(module),
                                                     reinterpret_cast<const char *>(name), initial, maximum,
                                                     static_cast<BinaryenType>(type)));
}
void BinaryenTableSetInitialForLink(uint64_t table, uint32_t initial, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenTableSetInitial(reinterpret_cast<BinaryenTableRef>(table), initial);
}
void BinaryenTableSetMaxForLink(uint64_t table, uint32_t maximum, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenTableSetMax(reinterpret_cast<BinaryenTableRef>(table), maximum);
}
uint64_t BinaryenAddActiveElementSegmentForLink(uint64_t module, uint64_t table, uint64_t name, uint64_t funcNames,
                                                uint32_t numFuncNames, uint64_t offset,
                                                [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddActiveElementSegment(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(table),
      reinterpret_cast<const char *>(name), reinterpret_cast<const char **>(funcNames), numFuncNames,
      reinterpret_cast<BinaryenExpressionRef>(offset)));
}
void BinaryenSetStartForLink(uint64_t module, uint64_t start, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenSetStart(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenFunctionRef>(start));
}
uint32_t BinaryenGetNumFunctionsForLink(uint64_t module, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenGetNumFunctions(reinterpret_cast<BinaryenModuleRef>(module));
}
uint64_t BinaryenGetFunctionByIndexForLink(uint64_t module, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGetFunctionByIndex(reinterpret_cast<BinaryenModuleRef>(module), index));
}
uint64_t BinaryenFunctionGetBodyForLink(uint64_t func, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenFunctionGetBody(reinterpret_cast<BinaryenFunctionRef>(func)));
}
uint64_t BinaryenLoopGetNameForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoopGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenLoopGetBodyForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoopGetBody(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBreakGetNameForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBreakGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBreakGetConditionForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBreakGetCondition(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBreakGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBreakGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSwitchGetDefaultNameForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSwitchGetDefaultName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenSwitchGetNumNamesForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenSwitchGetNumNames(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenSwitchGetNameAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSwitchGetNameAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenSwitchGetConditionForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSwitchGetCondition(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSwitchGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSwitchGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenCallIndirectGetTargetForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallIndirectGetTarget(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenCallIndirectGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenCallIndirectGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenCallIndirectGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenCallIndirectGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenGlobalSetGetNameForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalSetGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenGlobalSetGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalSetGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenLoadGetPtrForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoadGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStoreGetPtrForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStoreGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStoreGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStoreGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSelectGetConditionForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSelectGetCondition(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenDropGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenDropGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenReturnGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenReturnGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryGrowGetDeltaForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryGrowGetDelta(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicRMWGetPtrForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicRMWGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicRMWGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicRMWGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicCmpxchgGetPtrForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicCmpxchgGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicCmpxchgGetExpectedForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicCmpxchgGetExpected(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicCmpxchgGetReplacementForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicCmpxchgGetReplacement(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicWaitGetPtrForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicWaitGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicWaitGetExpectedForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicWaitGetExpected(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicWaitGetTimeoutForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicWaitGetTimeout(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicNotifyGetPtrForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicNotifyGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicNotifyGetNotifyCountForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicNotifyGetNotifyCount(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDExtractGetVecForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDExtractGetVec(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDReplaceGetVecForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDReplaceGetVec(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDReplaceGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDReplaceGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDShuffleGetLeftForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDShuffleGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDShuffleGetRightForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDShuffleGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDTernaryGetAForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDTernaryGetA(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDTernaryGetBForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDTernaryGetB(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDTernaryGetCForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDTernaryGetC(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDShiftGetVecForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDShiftGetVec(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDShiftGetShiftForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDShiftGetShift(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDLoadGetPtrForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDLoadGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDLoadStoreLaneGetPtrForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDLoadStoreLaneGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDLoadStoreLaneGetVecForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDLoadStoreLaneGetVec(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryInitGetDestForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryInitGetDest(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryInitGetOffsetForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryInitGetOffset(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryInitGetSizeForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryInitGetSize(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryCopyGetDestForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryCopyGetDest(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryCopyGetSourceForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryCopyGetSource(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryCopyGetSizeForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryCopyGetSize(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryFillGetDestForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryFillGetDest(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryFillGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryFillGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryFillGetSizeForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryFillGetSize(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefIsNullGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefIsNullGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefFuncGetFuncForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefFuncGetFunc(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefEqGetLeftForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefEqGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefEqGetRightForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefEqGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenTryGetBodyForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenTryGetBody(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenTryGetNumCatchBodiesForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenTryGetNumCatchBodies(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenTryGetCatchBodyAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenTryGetCatchBodyAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenThrowGetTagForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenThrowGetTag(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenThrowGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenThrowGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenThrowGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenThrowGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint32_t BinaryenTupleMakeGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenTupleMakeGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenTupleMakeGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenTupleMakeGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenTupleExtractGetTupleForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenTupleExtractGetTuple(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefI31GetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefI31GetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenI31GetGetI31ForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenI31GetGetI31(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenCallRefGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenCallRefGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenCallRefGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallRefGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenCallRefGetTargetForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallRefGetTarget(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefTestGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefTestGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefCastGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefCastGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBrOnGetNameForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBrOnGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBrOnGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBrOnGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenStructNewGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenStructNewGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenStructNewGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenStructNewGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenStructGetGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStructGetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenStructGetGetIndexForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenStructGetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenStructSetGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStructSetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenStructSetGetIndexForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenStructSetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenStructSetGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStructSetGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayNewGetSizeForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayNewGetSize(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayNewGetInitForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayNewGetInit(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenArrayNewFixedGetNumValuesForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenArrayNewFixedGetNumValues(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenArrayNewFixedGetValueAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenArrayNewFixedGetValueAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenArrayGetGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayGetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayGetGetIndexForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayGetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArraySetGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArraySetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArraySetGetIndexForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArraySetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArraySetGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArraySetGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayLenGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayLenGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetDestRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetDestRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetDestIndexForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetDestIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetSrcRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetSrcRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetSrcIndexForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetSrcIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetLengthForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetLength(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefAsGetValueForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefAsGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringNewGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringNewGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringNewGetStartForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringNewGetStart(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringNewGetEndForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringNewGetEnd(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringMeasureGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringMeasureGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEncodeGetStrForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEncodeGetStr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEncodeGetArrayForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEncodeGetArray(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEncodeGetStartForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEncodeGetStart(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringConcatGetLeftForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringConcatGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringConcatGetRightForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringConcatGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEqGetLeftForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEqGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEqGetRightForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEqGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringWTF16GetGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringWTF16GetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringWTF16GetGetPosForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringWTF16GetGetPos(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringSliceWTFGetRefForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringSliceWTFGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringSliceWTFGetStartForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringSliceWTFGetStart(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringSliceWTFGetEndForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringSliceWTFGetEnd(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenGetNumGlobalsForLink(uint64_t module, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenGetNumGlobals(reinterpret_cast<BinaryenModuleRef>(module));
}
uint64_t BinaryenGetGlobalByIndexForLink(uint64_t module, uint32_t index, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGetGlobalByIndex(reinterpret_cast<BinaryenModuleRef>(module), index));
}
uint64_t BinaryenGlobalGetInitExprForLink(uint64_t global, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalGetInitExpr(reinterpret_cast<BinaryenGlobalRef>(global)));
}
uint32_t BinaryenModuleValidateForLink(uint64_t module, [[maybe_unused]] vb::WasmModule *ctx) {
  return static_cast<uint32_t>(BinaryenModuleValidate(reinterpret_cast<BinaryenModuleRef>(module)));
}
uint32_t BinaryenStoreGetOffsetForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenStoreGetOffset(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint32_t BinaryenStoreGetBytesForLink(uint64_t expr, [[maybe_unused]] vb::WasmModule *ctx) {
  return BinaryenStoreGetBytes(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenFunctionGetNameForLink(uint64_t func, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenFunctionGetName(reinterpret_cast<BinaryenFunctionRef>(func)));
}
void BinaryenStoreSetPtrForLink(uint64_t expr, uint64_t ptr, [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenStoreSetPtr(reinterpret_cast<BinaryenExpressionRef>(expr), reinterpret_cast<BinaryenExpressionRef>(ptr));
}
void BinaryenModuleSetTypeNameForLink(uint64_t module, uint64_t heapType, uint64_t name,
                                      [[maybe_unused]] vb::WasmModule *ctx) {
  BinaryenModuleSetTypeName(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenHeapType>(heapType),
                            reinterpret_cast<const char *>(name));
}
} // namespace

std::vector<vb::NativeSymbol> createBinaryenLinkedAPI() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("binaryen", "_BinaryenTypeFuncref", BinaryenTypeFuncrefForLink),
      STATIC_LINK("binaryen", "_BinaryenSizeofLiteral", BinaryenSizeofLiteralForLink),
      STATIC_LINK("binaryen", "_BinaryenCallGetOperandAt", BinaryenCallGetOperandAtForLink),
      STATIC_LINK("binaryen", "_BinaryenReturnCall", BinaryenReturnCallForLink),
      STATIC_LINK("binaryen", "_BinaryenCall", BinaryenCallForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeExternref", BinaryenTypeExternrefForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeAnyref", BinaryenTypeAnyrefForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeEqref", BinaryenTypeEqrefForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeStructref", BinaryenTypeStructrefForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeArrayref", BinaryenTypeArrayrefForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeI31ref", BinaryenTypeI31refForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeStringref", BinaryenTypeStringrefForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeNullref", BinaryenTypeNullrefForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeNullFuncref", BinaryenTypeNullFuncrefForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeNullExternref", BinaryenTypeNullExternrefForLink),
      STATIC_LINK("binaryen", "_BinaryenUnreachable", BinaryenUnreachableForLink),
      STATIC_LINK("binaryen", "_BinaryenExpressionGetId", BinaryenExpressionGetIdForLink),
      STATIC_LINK("binaryen", "_BinaryenLocalSetIsTee", BinaryenLocalSetIsTeeForLink),
      STATIC_LINK("binaryen", "_BinaryenLocalSetGetIndex", BinaryenLocalSetGetIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenLocalGetGetIndex", BinaryenLocalGetGetIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenLocalSetGetValue", BinaryenLocalSetGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenGlobalGetGetName", BinaryenGlobalGetGetNameForLink),
      STATIC_LINK("binaryen", "_BinaryenBinaryGetOp", BinaryenBinaryGetOpForLink),
      STATIC_LINK("binaryen", "_BinaryenBinaryGetLeft", BinaryenBinaryGetLeftForLink),
      STATIC_LINK("binaryen", "_BinaryenConstGetValueI32", BinaryenConstGetValueI32ForLink),
      STATIC_LINK("binaryen", "_BinaryenBinaryGetRight", BinaryenBinaryGetRightForLink),
      STATIC_LINK("binaryen", "_BinaryenUnaryGetOp", BinaryenUnaryGetOpForLink),
      STATIC_LINK("binaryen", "_BinaryenExpressionGetType", BinaryenExpressionGetTypeForLink),
      STATIC_LINK("binaryen", "_BinaryenConstGetValueI64Low", BinaryenConstGetValueI64LowForLink),
      STATIC_LINK("binaryen", "_BinaryenConstGetValueF32", BinaryenConstGetValueF32ForLink),
      STATIC_LINK("binaryen", "_BinaryenConstGetValueF64", BinaryenConstGetValueF64ForLink),
      STATIC_LINK("binaryen", "_BinaryenLoadIsSigned", BinaryenLoadIsSignedForLink),
      STATIC_LINK("binaryen", "_BinaryenLoadGetBytes", BinaryenLoadGetBytesForLink),
      STATIC_LINK("binaryen", "_BinaryenBlockGetName", BinaryenBlockGetNameForLink),
      STATIC_LINK("binaryen", "_BinaryenBlockGetNumChildren", BinaryenBlockGetNumChildrenForLink),
      STATIC_LINK("binaryen", "_BinaryenBlockGetChildAt", BinaryenBlockGetChildAtForLink),
      STATIC_LINK("binaryen", "_BinaryenIfGetIfTrue", BinaryenIfGetIfTrueForLink),
      STATIC_LINK("binaryen", "_BinaryenIfGetIfFalse", BinaryenIfGetIfFalseForLink),
      STATIC_LINK("binaryen", "_BinaryenSelectGetIfTrue", BinaryenSelectGetIfTrueForLink),
      STATIC_LINK("binaryen", "_BinaryenSelectGetIfFalse", BinaryenSelectGetIfFalseForLink),
      STATIC_LINK("binaryen", "_BinaryenCallGetTarget", BinaryenCallGetTargetForLink),
      STATIC_LINK("binaryen", "_BinaryenConst", BinaryenConstForLink),
      STATIC_LINK("binaryen", "_BinaryenNop", BinaryenNopForLink),
      STATIC_LINK("binaryen", "_BinaryenBlock", BinaryenBlockForLink),
      STATIC_LINK("binaryen", "_BinaryenBreak", BinaryenBreakForLink),
      STATIC_LINK("binaryen", "_BinaryenBinary", BinaryenBinaryForLink),
      STATIC_LINK("binaryen", "_BinaryenUnary", BinaryenUnaryForLink),
      STATIC_LINK("binaryen", "_BinaryenRefIsNull", BinaryenRefIsNullForLink),
      STATIC_LINK("binaryen", "_ExpressionRunnerCreate", ExpressionRunnerCreateForLink),
      STATIC_LINK("binaryen", "_ExpressionRunnerRunAndDispose", ExpressionRunnerRunAndDisposeForLink),
      STATIC_LINK("binaryen", "_BinaryenLiteralInt32", BinaryenLiteralInt32ForLink),
      STATIC_LINK("binaryen", "_BinaryenLiteralInt64", BinaryenLiteralInt64ForLink),
      STATIC_LINK("binaryen", "_BinaryenSetMemory", BinaryenSetMemoryForLink),
      STATIC_LINK("binaryen", "_BinaryenModuleGetFeatures", BinaryenModuleGetFeaturesForLink),
      STATIC_LINK("binaryen", "_BinaryenConstGetValueI64High", BinaryenConstGetValueI64HighForLink),
      STATIC_LINK("binaryen", "_BinaryenIfGetCondition", BinaryenIfGetConditionForLink),
      STATIC_LINK("binaryen", "_BinaryenUnaryGetValue", BinaryenUnaryGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenCallGetNumOperands", BinaryenCallGetNumOperandsForLink),
      STATIC_LINK("binaryen", "_BinaryenLoop", BinaryenLoopForLink),
      STATIC_LINK("binaryen", "_BinaryenDrop", BinaryenDropForLink),
      STATIC_LINK("binaryen", "_BinaryenIf", BinaryenIfForLink),
      STATIC_LINK("binaryen", "_BinaryenReturn", BinaryenReturnForLink),
      STATIC_LINK("binaryen", "_BinaryenLocalSet", BinaryenLocalSetForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeFromHeapType", BinaryenTypeFromHeapTypeForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeGetHeapType", BinaryenTypeGetHeapTypeForLink),
      STATIC_LINK("binaryen", "_TypeBuilderCreate", TypeBuilderCreateForLink),
      STATIC_LINK("binaryen", "_TypeBuilderGetSize", TypeBuilderGetSizeForLink),
      STATIC_LINK("binaryen", "_TypeBuilderGrow", TypeBuilderGrowForLink),
      STATIC_LINK("binaryen", "_TypeBuilderGetTempHeapType", TypeBuilderGetTempHeapTypeForLink),
      STATIC_LINK("binaryen", "_TypeBuilderGetTempRefType", TypeBuilderGetTempRefTypeForLink),
      STATIC_LINK("binaryen", "_TypeBuilderSetStructType", TypeBuilderSetStructTypeForLink),
      STATIC_LINK("binaryen", "_TypeBuilderSetSubType", TypeBuilderSetSubTypeForLink),
      STATIC_LINK("binaryen", "_TypeBuilderGetTempTupleType", TypeBuilderGetTempTupleTypeForLink),
      STATIC_LINK("binaryen", "_TypeBuilderSetSignatureType", TypeBuilderSetSignatureTypeForLink),
      STATIC_LINK("binaryen", "_TypeBuilderBuildAndDispose", TypeBuilderBuildAndDisposeForLink),
      STATIC_LINK("binaryen", "_BinaryenStructTypeGetNumFields", BinaryenStructTypeGetNumFieldsForLink),
      STATIC_LINK("binaryen", "_BinaryenModuleSetFieldName", BinaryenModuleSetFieldNameForLink),
      STATIC_LINK("binaryen", "_BinaryenLocalGet", BinaryenLocalGetForLink),
      STATIC_LINK("binaryen", "_BinaryenAddFunction", BinaryenAddFunctionForLink),
      STATIC_LINK("binaryen", "_BinaryenLocalTee", BinaryenLocalTeeForLink),
      STATIC_LINK("binaryen", "_BinaryenAddGlobalImport", BinaryenAddGlobalImportForLink),
      STATIC_LINK("binaryen", "_BinaryenGetGlobal", BinaryenGetGlobalForLink),
      STATIC_LINK("binaryen", "_BinaryenGlobalIsMutable", BinaryenGlobalIsMutableForLink),
      STATIC_LINK("binaryen", "_BinaryenLiteralFloat64", BinaryenLiteralFloat64ForLink),
      STATIC_LINK("binaryen", "_BinaryenLiteralFloat32", BinaryenLiteralFloat32ForLink),
      STATIC_LINK("binaryen", "_BinaryenLiteralVec128", BinaryenLiteralVec128ForLink),
      STATIC_LINK("binaryen", "_BinaryenRefNull", BinaryenRefNullForLink),
      STATIC_LINK("binaryen", "_BinaryenRefI31", BinaryenRefI31ForLink),
      STATIC_LINK("binaryen", "_BinaryenAddGlobal", BinaryenAddGlobalForLink),
      STATIC_LINK("binaryen", "_BinaryenGlobalSet", BinaryenGlobalSetForLink),
      STATIC_LINK("binaryen", "_BinaryenGlobalGet", BinaryenGlobalGetForLink),
      STATIC_LINK("binaryen", "_BinaryenSwitch", BinaryenSwitchForLink),
      STATIC_LINK("binaryen", "_BinaryenConstGetValueV128", BinaryenConstGetValueV128ForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeCreate", BinaryenTypeCreateForLink),
      STATIC_LINK("binaryen", "_BinaryenFunctionSetDebugLocation", BinaryenFunctionSetDebugLocationForLink),
      STATIC_LINK("binaryen", "_BinaryenFunctionSetLocalName", BinaryenFunctionSetLocalNameForLink),
      STATIC_LINK("binaryen", "_BinaryenExpressionGetSideEffects", BinaryenExpressionGetSideEffectsForLink),
      STATIC_LINK("binaryen", "_BinaryenRefEq", BinaryenRefEqForLink),
      STATIC_LINK("binaryen", "_BinaryenStringEq", BinaryenStringEqForLink),
      STATIC_LINK("binaryen", "_BinaryenModuleAddDebugInfoFileName", BinaryenModuleAddDebugInfoFileNameForLink),
      STATIC_LINK("binaryen", "_BinaryenAddFunctionImport", BinaryenAddFunctionImportForLink),
      STATIC_LINK("binaryen", "_BinaryenGetFunction", BinaryenGetFunctionForLink),
      STATIC_LINK("binaryen", "_BinaryenLoad", BinaryenLoadForLink),
      STATIC_LINK("binaryen", "_BinaryenStore", BinaryenStoreForLink),
      STATIC_LINK("binaryen", "_BinaryenTypeIsNullable", BinaryenTypeIsNullableForLink),
      STATIC_LINK("binaryen", "_BinaryenRefAs", BinaryenRefAsForLink),
      STATIC_LINK("binaryen", "_BinaryenSelect", BinaryenSelectForLink),
      STATIC_LINK("binaryen", "_BinaryenExpressionCopy", BinaryenExpressionCopyForLink),
      STATIC_LINK("binaryen", "_BinaryenReturnCallIndirect", BinaryenReturnCallIndirectForLink),
      STATIC_LINK("binaryen", "_BinaryenCallIndirect", BinaryenCallIndirectForLink),
      STATIC_LINK("binaryen", "_BinaryenRefFunc", BinaryenRefFuncForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicLoad", BinaryenAtomicLoadForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicStore", BinaryenAtomicStoreForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicRMW", BinaryenAtomicRMWForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicCmpxchg", BinaryenAtomicCmpxchgForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicWait", BinaryenAtomicWaitForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicNotify", BinaryenAtomicNotifyForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicFence", BinaryenAtomicFenceForLink),
      STATIC_LINK("binaryen", "_BinaryenMemorySize", BinaryenMemorySizeForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryGrow", BinaryenMemoryGrowForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryCopy", BinaryenMemoryCopyForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryFill", BinaryenMemoryFillForLink),
      STATIC_LINK("binaryen", "_BinaryenI31Get", BinaryenI31GetForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDReplace", BinaryenSIMDReplaceForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDExtract", BinaryenSIMDExtractForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDShuffle", BinaryenSIMDShuffleForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDLoad", BinaryenSIMDLoadForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDLoadStoreLane", BinaryenSIMDLoadStoreLaneForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDShift", BinaryenSIMDShiftForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDTernary", BinaryenSIMDTernaryForLink),
      STATIC_LINK("binaryen", "_BinaryenModuleCreate", BinaryenModuleCreateForLink),
      STATIC_LINK("binaryen", "_BinaryenSetLowMemoryUnused", BinaryenSetLowMemoryUnusedForLink),
      STATIC_LINK("binaryen", "_BinaryenModuleSetFeatures", BinaryenModuleSetFeaturesForLink),
      STATIC_LINK("binaryen", "_BinaryenSetClosedWorld", BinaryenSetClosedWorldForLink),
      STATIC_LINK("binaryen", "_BinaryenGetExport", BinaryenGetExportForLink),
      STATIC_LINK("binaryen", "_BinaryenAddFunctionExport", BinaryenAddFunctionExportForLink),
      STATIC_LINK("binaryen", "_BinaryenAddGlobalExport", BinaryenAddGlobalExportForLink),
      STATIC_LINK("binaryen", "_BinaryenRemoveFunction", BinaryenRemoveFunctionForLink),
      STATIC_LINK("binaryen", "_BinaryenRemoveGlobal", BinaryenRemoveGlobalForLink),
      STATIC_LINK("binaryen", "_BinaryenAddMemoryImport", BinaryenAddMemoryImportForLink),
      STATIC_LINK("binaryen", "_BinaryenAddTableImport", BinaryenAddTableImportForLink),
      STATIC_LINK("binaryen", "_BinaryenAddTableExport", BinaryenAddTableExportForLink),
      STATIC_LINK("binaryen", "_BinaryenSetPassArgument", BinaryenSetPassArgumentForLink),
      STATIC_LINK("binaryen", "_BinaryenGetTable", BinaryenGetTableForLink),
      STATIC_LINK("binaryen", "_BinaryenAddTable", BinaryenAddTableForLink),
      STATIC_LINK("binaryen", "_BinaryenTableSetInitial", BinaryenTableSetInitialForLink),
      STATIC_LINK("binaryen", "_BinaryenTableSetMax", BinaryenTableSetMaxForLink),
      STATIC_LINK("binaryen", "_BinaryenAddActiveElementSegment", BinaryenAddActiveElementSegmentForLink),
      STATIC_LINK("binaryen", "_BinaryenSetStart", BinaryenSetStartForLink),
      STATIC_LINK("binaryen", "_BinaryenGetNumFunctions", BinaryenGetNumFunctionsForLink),
      STATIC_LINK("binaryen", "_BinaryenGetFunctionByIndex", BinaryenGetFunctionByIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenFunctionGetBody", BinaryenFunctionGetBodyForLink),
      STATIC_LINK("binaryen", "_BinaryenLoopGetName", BinaryenLoopGetNameForLink),
      STATIC_LINK("binaryen", "_BinaryenLoopGetBody", BinaryenLoopGetBodyForLink),
      STATIC_LINK("binaryen", "_BinaryenBreakGetName", BinaryenBreakGetNameForLink),
      STATIC_LINK("binaryen", "_BinaryenBreakGetCondition", BinaryenBreakGetConditionForLink),
      STATIC_LINK("binaryen", "_BinaryenBreakGetValue", BinaryenBreakGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenSwitchGetDefaultName", BinaryenSwitchGetDefaultNameForLink),
      STATIC_LINK("binaryen", "_BinaryenSwitchGetNumNames", BinaryenSwitchGetNumNamesForLink),
      STATIC_LINK("binaryen", "_BinaryenSwitchGetNameAt", BinaryenSwitchGetNameAtForLink),
      STATIC_LINK("binaryen", "_BinaryenSwitchGetCondition", BinaryenSwitchGetConditionForLink),
      STATIC_LINK("binaryen", "_BinaryenSwitchGetValue", BinaryenSwitchGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenCallIndirectGetTarget", BinaryenCallIndirectGetTargetForLink),
      STATIC_LINK("binaryen", "_BinaryenCallIndirectGetNumOperands", BinaryenCallIndirectGetNumOperandsForLink),
      STATIC_LINK("binaryen", "_BinaryenCallIndirectGetOperandAt", BinaryenCallIndirectGetOperandAtForLink),
      STATIC_LINK("binaryen", "_BinaryenGlobalSetGetName", BinaryenGlobalSetGetNameForLink),
      STATIC_LINK("binaryen", "_BinaryenGlobalSetGetValue", BinaryenGlobalSetGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenLoadGetPtr", BinaryenLoadGetPtrForLink),
      STATIC_LINK("binaryen", "_BinaryenStoreGetPtr", BinaryenStoreGetPtrForLink),
      STATIC_LINK("binaryen", "_BinaryenStoreGetValue", BinaryenStoreGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenSelectGetCondition", BinaryenSelectGetConditionForLink),
      STATIC_LINK("binaryen", "_BinaryenDropGetValue", BinaryenDropGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenReturnGetValue", BinaryenReturnGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryGrowGetDelta", BinaryenMemoryGrowGetDeltaForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicRMWGetPtr", BinaryenAtomicRMWGetPtrForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicRMWGetValue", BinaryenAtomicRMWGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicCmpxchgGetPtr", BinaryenAtomicCmpxchgGetPtrForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicCmpxchgGetExpected", BinaryenAtomicCmpxchgGetExpectedForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicCmpxchgGetReplacement", BinaryenAtomicCmpxchgGetReplacementForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicWaitGetPtr", BinaryenAtomicWaitGetPtrForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicWaitGetExpected", BinaryenAtomicWaitGetExpectedForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicWaitGetTimeout", BinaryenAtomicWaitGetTimeoutForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicNotifyGetPtr", BinaryenAtomicNotifyGetPtrForLink),
      STATIC_LINK("binaryen", "_BinaryenAtomicNotifyGetNotifyCount", BinaryenAtomicNotifyGetNotifyCountForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDExtractGetVec", BinaryenSIMDExtractGetVecForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDReplaceGetVec", BinaryenSIMDReplaceGetVecForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDReplaceGetValue", BinaryenSIMDReplaceGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDShuffleGetLeft", BinaryenSIMDShuffleGetLeftForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDShuffleGetRight", BinaryenSIMDShuffleGetRightForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDTernaryGetA", BinaryenSIMDTernaryGetAForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDTernaryGetB", BinaryenSIMDTernaryGetBForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDTernaryGetC", BinaryenSIMDTernaryGetCForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDShiftGetVec", BinaryenSIMDShiftGetVecForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDShiftGetShift", BinaryenSIMDShiftGetShiftForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDLoadGetPtr", BinaryenSIMDLoadGetPtrForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDLoadStoreLaneGetPtr", BinaryenSIMDLoadStoreLaneGetPtrForLink),
      STATIC_LINK("binaryen", "_BinaryenSIMDLoadStoreLaneGetVec", BinaryenSIMDLoadStoreLaneGetVecForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryInitGetDest", BinaryenMemoryInitGetDestForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryInitGetOffset", BinaryenMemoryInitGetOffsetForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryInitGetSize", BinaryenMemoryInitGetSizeForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryCopyGetDest", BinaryenMemoryCopyGetDestForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryCopyGetSource", BinaryenMemoryCopyGetSourceForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryCopyGetSize", BinaryenMemoryCopyGetSizeForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryFillGetDest", BinaryenMemoryFillGetDestForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryFillGetValue", BinaryenMemoryFillGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenMemoryFillGetSize", BinaryenMemoryFillGetSizeForLink),
      STATIC_LINK("binaryen", "_BinaryenRefIsNullGetValue", BinaryenRefIsNullGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenRefFuncGetFunc", BinaryenRefFuncGetFuncForLink),
      STATIC_LINK("binaryen", "_BinaryenRefEqGetLeft", BinaryenRefEqGetLeftForLink),
      STATIC_LINK("binaryen", "_BinaryenRefEqGetRight", BinaryenRefEqGetRightForLink),
      STATIC_LINK("binaryen", "_BinaryenTryGetBody", BinaryenTryGetBodyForLink),
      STATIC_LINK("binaryen", "_BinaryenTryGetNumCatchBodies", BinaryenTryGetNumCatchBodiesForLink),
      STATIC_LINK("binaryen", "_BinaryenTryGetCatchBodyAt", BinaryenTryGetCatchBodyAtForLink),
      STATIC_LINK("binaryen", "_BinaryenThrowGetTag", BinaryenThrowGetTagForLink),
      STATIC_LINK("binaryen", "_BinaryenThrowGetNumOperands", BinaryenThrowGetNumOperandsForLink),
      STATIC_LINK("binaryen", "_BinaryenThrowGetOperandAt", BinaryenThrowGetOperandAtForLink),
      STATIC_LINK("binaryen", "_BinaryenTupleMakeGetNumOperands", BinaryenTupleMakeGetNumOperandsForLink),
      STATIC_LINK("binaryen", "_BinaryenTupleMakeGetOperandAt", BinaryenTupleMakeGetOperandAtForLink),
      STATIC_LINK("binaryen", "_BinaryenTupleExtractGetTuple", BinaryenTupleExtractGetTupleForLink),
      STATIC_LINK("binaryen", "_BinaryenRefI31GetValue", BinaryenRefI31GetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenI31GetGetI31", BinaryenI31GetGetI31ForLink),
      STATIC_LINK("binaryen", "_BinaryenCallRefGetNumOperands", BinaryenCallRefGetNumOperandsForLink),
      STATIC_LINK("binaryen", "_BinaryenCallRefGetOperandAt", BinaryenCallRefGetOperandAtForLink),
      STATIC_LINK("binaryen", "_BinaryenCallRefGetTarget", BinaryenCallRefGetTargetForLink),
      STATIC_LINK("binaryen", "_BinaryenRefTestGetRef", BinaryenRefTestGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenRefCastGetRef", BinaryenRefCastGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenBrOnGetName", BinaryenBrOnGetNameForLink),
      STATIC_LINK("binaryen", "_BinaryenBrOnGetRef", BinaryenBrOnGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenStructNewGetNumOperands", BinaryenStructNewGetNumOperandsForLink),
      STATIC_LINK("binaryen", "_BinaryenStructNewGetOperandAt", BinaryenStructNewGetOperandAtForLink),
      STATIC_LINK("binaryen", "_BinaryenStructGetGetRef", BinaryenStructGetGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenStructGetGetIndex", BinaryenStructGetGetIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenStructSetGetRef", BinaryenStructSetGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenStructSetGetIndex", BinaryenStructSetGetIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenStructSetGetValue", BinaryenStructSetGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayNewGetSize", BinaryenArrayNewGetSizeForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayNewGetInit", BinaryenArrayNewGetInitForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayNewFixedGetNumValues", BinaryenArrayNewFixedGetNumValuesForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayNewFixedGetValueAt", BinaryenArrayNewFixedGetValueAtForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayGetGetRef", BinaryenArrayGetGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayGetGetIndex", BinaryenArrayGetGetIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenArraySetGetRef", BinaryenArraySetGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenArraySetGetIndex", BinaryenArraySetGetIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenArraySetGetValue", BinaryenArraySetGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayLenGetRef", BinaryenArrayLenGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayCopyGetDestRef", BinaryenArrayCopyGetDestRefForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayCopyGetDestIndex", BinaryenArrayCopyGetDestIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayCopyGetSrcRef", BinaryenArrayCopyGetSrcRefForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayCopyGetSrcIndex", BinaryenArrayCopyGetSrcIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenArrayCopyGetLength", BinaryenArrayCopyGetLengthForLink),
      STATIC_LINK("binaryen", "_BinaryenRefAsGetValue", BinaryenRefAsGetValueForLink),
      STATIC_LINK("binaryen", "_BinaryenStringNewGetRef", BinaryenStringNewGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenStringNewGetStart", BinaryenStringNewGetStartForLink),
      STATIC_LINK("binaryen", "_BinaryenStringNewGetEnd", BinaryenStringNewGetEndForLink),
      STATIC_LINK("binaryen", "_BinaryenStringMeasureGetRef", BinaryenStringMeasureGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenStringEncodeGetStr", BinaryenStringEncodeGetStrForLink),
      STATIC_LINK("binaryen", "_BinaryenStringEncodeGetArray", BinaryenStringEncodeGetArrayForLink),
      STATIC_LINK("binaryen", "_BinaryenStringEncodeGetStart", BinaryenStringEncodeGetStartForLink),
      STATIC_LINK("binaryen", "_BinaryenStringConcatGetLeft", BinaryenStringConcatGetLeftForLink),
      STATIC_LINK("binaryen", "_BinaryenStringConcatGetRight", BinaryenStringConcatGetRightForLink),
      STATIC_LINK("binaryen", "_BinaryenStringEqGetLeft", BinaryenStringEqGetLeftForLink),
      STATIC_LINK("binaryen", "_BinaryenStringEqGetRight", BinaryenStringEqGetRightForLink),
      STATIC_LINK("binaryen", "_BinaryenStringWTF16GetGetRef", BinaryenStringWTF16GetGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenStringWTF16GetGetPos", BinaryenStringWTF16GetGetPosForLink),
      STATIC_LINK("binaryen", "_BinaryenStringSliceWTFGetRef", BinaryenStringSliceWTFGetRefForLink),
      STATIC_LINK("binaryen", "_BinaryenStringSliceWTFGetStart", BinaryenStringSliceWTFGetStartForLink),
      STATIC_LINK("binaryen", "_BinaryenStringSliceWTFGetEnd", BinaryenStringSliceWTFGetEndForLink),
      STATIC_LINK("binaryen", "_BinaryenGetNumGlobals", BinaryenGetNumGlobalsForLink),
      STATIC_LINK("binaryen", "_BinaryenGetGlobalByIndex", BinaryenGetGlobalByIndexForLink),
      STATIC_LINK("binaryen", "_BinaryenGlobalGetInitExpr", BinaryenGlobalGetInitExprForLink),
      STATIC_LINK("binaryen", "_BinaryenModuleValidate", BinaryenModuleValidateForLink),
      STATIC_LINK("binaryen", "_BinaryenStoreGetOffset", BinaryenStoreGetOffsetForLink),
      STATIC_LINK("binaryen", "_BinaryenStoreGetBytes", BinaryenStoreGetBytesForLink),
      STATIC_LINK("binaryen", "_BinaryenFunctionGetName", BinaryenFunctionGetNameForLink),
      STATIC_LINK("binaryen", "_BinaryenStoreSetPtr", BinaryenStoreSetPtrForLink),
      STATIC_LINK("binaryen", "_BinaryenModuleSetTypeName", BinaryenModuleSetTypeNameForLink),
  };
}

} // namespace warpo::frontend
