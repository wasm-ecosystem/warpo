#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <iostream>
#include <sstream>
#include <utility>
#include <vector>

#include "LinkedAPI.hpp"
#include "binaryen/src/binaryen-c.h"
#include "binaryen/src/literal.h"
#include "wasm-compiler/src/WasmModule/WasmModule.hpp"
#include "wasm-compiler/src/core/common/NativeSymbol.hpp"
#include "wasm-compiler/src/core/common/function_traits.hpp"

namespace export_to_asc {
namespace {

uint64_t BinaryenCallGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenReturnCallForLink(uint64_t module, uint64_t name, uint64_t operands, uint32_t numOperands,
                                   uint64_t returnType, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenReturnCall(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
      reinterpret_cast<BinaryenExpressionRef *>(operands), numOperands, static_cast<BinaryenType>(returnType)));
}
uint64_t BinaryenCallForLink(uint64_t module, uint64_t name, uint64_t operands, uint32_t numOperands,
                             uint64_t returnType, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCall(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
      reinterpret_cast<BinaryenExpressionRef *>(operands), numOperands, static_cast<BinaryenType>(returnType)));
}
uint32_t BinaryenLoadGetBytesForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenLoadGetBytes(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenBlockGetNameForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBlockGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenBlockGetNumChildrenForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenBlockGetNumChildren(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenBlockGetChildAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBlockGetChildAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenIfGetIfTrueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenIfGetIfTrue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenIfGetIfFalseForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenIfGetIfFalse(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSelectGetIfTrueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSelectGetIfTrue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSelectGetIfFalseForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSelectGetIfFalse(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenCallGetTargetForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallGetTarget(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenConstForLink(uint64_t module, uint64_t literal, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenConst(reinterpret_cast<BinaryenModuleRef>(module), *reinterpret_cast<BinaryenLiteral *>(literal)));
}
uint64_t BinaryenNopForLink(uint64_t module, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenNop(reinterpret_cast<BinaryenModuleRef>(module)));
}
uint64_t BinaryenBlockForLink(uint64_t module, uint64_t name, uint64_t children, uint32_t numChildren, uint64_t type,
                              [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenBlock(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
                    reinterpret_cast<BinaryenExpressionRef *>(children), numChildren, type));
}
uint64_t BinaryenBinaryForLink(uint64_t module, uint32_t op, uint64_t left, uint64_t right,
                               [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBinary(reinterpret_cast<BinaryenModuleRef>(module), op,
                                                   reinterpret_cast<BinaryenExpressionRef>(left),
                                                   reinterpret_cast<BinaryenExpressionRef>(right)));
}
uint64_t BinaryenUnaryForLink(uint64_t module, uint32_t op, uint64_t value, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenUnary(reinterpret_cast<BinaryenModuleRef>(module), op, reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenRefIsNullForLink(uint64_t module, uint64_t value, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenRefIsNull(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t ExpressionRunnerCreateForLink(uint64_t module, uint32_t flags, uint32_t maxDepth, uint32_t maxLoopIterations,
                                       [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      ExpressionRunnerCreate(reinterpret_cast<BinaryenModuleRef>(module), flags, maxDepth, maxLoopIterations));
}
uint64_t ExpressionRunnerRunAndDisposeForLink(uint64_t runner, uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(ExpressionRunnerRunAndDispose(reinterpret_cast<ExpressionRunnerRef>(runner),
                                                                  reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenTypeExternrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeExternref(); }
uint64_t BinaryenTypeAnyrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeAnyref(); }
uint64_t BinaryenTypeEqrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeEqref(); }
uint64_t BinaryenTypeStructrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeStructref(); }
uint64_t BinaryenTypeArrayrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeArrayref(); }
uint64_t BinaryenTypeI31refForLink([[maybe_unused]] void *ctx) { return BinaryenTypeI31ref(); }
uint64_t BinaryenTypeStringrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeStringref(); }
uint64_t BinaryenTypeNullrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeNullref(); }
uint64_t BinaryenTypeNullFuncrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeNullFuncref(); }
uint64_t BinaryenTypeNullExternrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeNullExternref(); }
uint64_t BinaryenUnreachableForLink(uint64_t module, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenUnreachable(reinterpret_cast<BinaryenModuleRef>(module)));
}
uint32_t BinaryenExpressionGetIdForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint32_t>(BinaryenExpressionGetId(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenLocalSetIsTeeForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenLocalSetIsTee(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenLocalSetGetIndexForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenLocalSetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenLocalGetGetIndexForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenLocalGetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenLocalSetGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLocalSetGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenGlobalGetGetNameForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalGetGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
int32_t BinaryenBinaryGetOpForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return static_cast<int32_t>(BinaryenBinaryGetOp(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBinaryGetLeftForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBinaryGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBinaryGetRightForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBinaryGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
int32_t BinaryenConstGetValueI32ForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenConstGetValueI32(reinterpret_cast<BinaryenExpressionRef>(expr));
}
int32_t BinaryenUnaryGetOpForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return static_cast<int32_t>(BinaryenUnaryGetOp(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenExpressionGetTypeForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return static_cast<uint64_t>(BinaryenExpressionGetType(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
int32_t BinaryenConstGetValueI64LowForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenConstGetValueI64Low(reinterpret_cast<BinaryenExpressionRef>(expr));
}
int32_t BinaryenConstGetValueI64HighForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenConstGetValueI64High(reinterpret_cast<BinaryenExpressionRef>(expr));
}
float BinaryenConstGetValueF32ForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenConstGetValueF32(reinterpret_cast<BinaryenExpressionRef>(expr));
}
double BinaryenConstGetValueF64ForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenConstGetValueF64(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint32_t BinaryenLoadIsSignedForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenLoadIsSigned(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenTypeFuncrefForLink([[maybe_unused]] void *ctx) { return BinaryenTypeFuncref(); }
uint32_t BinaryenSizeofLiteralForLink([[maybe_unused]] void *ctx) { return sizeof(wasm::Literal); }
void BinaryenLiteralInt32ForLink(uint64_t ptr, int32_t x, [[maybe_unused]] void *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralInt32(x);
}
void BinaryenLiteralInt64ForLink(uint64_t ptr, int32_t x, int32_t y, [[maybe_unused]] void *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) =
      BinaryenLiteralInt64((static_cast<int64_t>(y) << 32) | (static_cast<uint32_t>(x)));
}
void BinaryenSetMemoryForLink(uint64_t module, uint32_t initial, uint32_t maximum, uint64_t exportName,
                              uint64_t segmentNames, uint64_t segmentDatas, uint64_t segmentPassives,
                              uint64_t segmentOffsets, uint64_t segmentSizes, uint32_t numSegments, uint32_t shared,
                              uint32_t memory64, uint64_t name, [[maybe_unused]] void *ctx) {
  BinaryenSetMemory(reinterpret_cast<BinaryenModuleRef>(module), initial, maximum,
                    reinterpret_cast<const char *>(exportName), reinterpret_cast<const char **>(segmentNames),
                    reinterpret_cast<const char **>(segmentDatas), reinterpret_cast<bool *>(segmentPassives),
                    reinterpret_cast<BinaryenExpressionRef *>(segmentOffsets),
                    reinterpret_cast<BinaryenIndex *>(segmentSizes), numSegments, shared != 0, memory64 != 0,
                    reinterpret_cast<const char *>(name));
}
uint32_t BinaryenModuleGetFeaturesForLink(uint64_t module, [[maybe_unused]] void *ctx) {
  return BinaryenModuleGetFeatures(reinterpret_cast<BinaryenModuleRef>(module));
}
uint64_t BinaryenIfGetConditionForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenIfGetCondition(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenUnaryGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenUnaryGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenCallGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenCallGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenDropForLink(uint64_t module, uint64_t value, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenDrop(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenIfForLink(uint64_t module, uint64_t condition, uint64_t ifTrue, uint64_t ifFalse,
                           [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenIf(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(condition),
                 reinterpret_cast<BinaryenExpressionRef>(ifTrue), reinterpret_cast<BinaryenExpressionRef>(ifFalse)));
}
uint64_t BinaryenLoopForLink(uint64_t module, uint64_t in, uint64_t body, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoop(reinterpret_cast<BinaryenModuleRef>(module),
                                                 reinterpret_cast<const char *>(in),
                                                 reinterpret_cast<BinaryenExpressionRef>(body)));
}
uint64_t BinaryenBreakForLink(uint64_t module, uint64_t name, uint64_t condition, uint64_t value,
                              [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBreak(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
      reinterpret_cast<BinaryenExpressionRef>(condition), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenReturnForLink(uint64_t module, uint64_t value, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenReturn(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenLocalSetForLink(uint64_t module, uint32_t index, uint64_t value, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLocalSet(reinterpret_cast<BinaryenModuleRef>(module), index,
                                                     reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenTypeFromHeapTypeForLink(uint64_t heapType, uint32_t nullable, [[maybe_unused]] void *ctx) {
  return BinaryenTypeFromHeapType(static_cast<BinaryenHeapType>(heapType), nullable != 0);
}
uint64_t BinaryenTypeGetHeapTypeForLink(uint64_t type, [[maybe_unused]] void *ctx) {
  return BinaryenTypeGetHeapType(static_cast<BinaryenType>(type));
}
uint64_t TypeBuilderCreateForLink(uint32_t size, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(TypeBuilderCreate(size));
}
uint32_t TypeBuilderGetSizeForLink(uint64_t builder, [[maybe_unused]] void *ctx) {
  return TypeBuilderGetSize(reinterpret_cast<TypeBuilderRef>(builder));
}
void TypeBuilderGrowForLink(uint64_t builder, uint32_t count, [[maybe_unused]] void *ctx) {
  TypeBuilderGrow(reinterpret_cast<TypeBuilderRef>(builder), count);
}
uint64_t TypeBuilderGetTempHeapTypeForLink(uint64_t builder, uint32_t index, [[maybe_unused]] void *ctx) {
  return TypeBuilderGetTempHeapType(reinterpret_cast<TypeBuilderRef>(builder), index);
}
uint64_t TypeBuilderGetTempRefTypeForLink(uint64_t builder, uint64_t heapType, int32_t nullable,
                                          [[maybe_unused]] void *ctx) {
  return TypeBuilderGetTempRefType(reinterpret_cast<TypeBuilderRef>(builder), heapType, nullable);
}
void TypeBuilderSetStructTypeForLink(uint64_t builder, uint32_t index, uint64_t fieldTypes, uint64_t fieldPackedTypes,
                                     uint64_t fieldMutables, uint32_t numFields, [[maybe_unused]] void *ctx) {
  TypeBuilderSetStructType(
      reinterpret_cast<TypeBuilderRef>(builder), index, reinterpret_cast<BinaryenType *>(fieldTypes),
      reinterpret_cast<BinaryenPackedType *>(fieldPackedTypes), reinterpret_cast<bool *>(fieldMutables), numFields);
}
void TypeBuilderSetSubTypeForLink(uint64_t builder, uint32_t index, uint64_t superType, [[maybe_unused]] void *ctx) {
  TypeBuilderSetSubType(reinterpret_cast<TypeBuilderRef>(builder), index, static_cast<BinaryenHeapType>(superType));
}
uint64_t TypeBuilderGetTempTupleTypeForLink(uint64_t builder, uint64_t types, uint32_t numTypes,
                                            [[maybe_unused]] void *ctx) {
  return TypeBuilderGetTempTupleType(reinterpret_cast<TypeBuilderRef>(builder), reinterpret_cast<BinaryenType *>(types),
                                     numTypes);
}
void TypeBuilderSetSignatureTypeForLink(uint64_t builder, uint32_t index, uint64_t paramTypes, uint64_t resultTypes,
                                        [[maybe_unused]] void *ctx) {
  TypeBuilderSetSignatureType(reinterpret_cast<TypeBuilderRef>(builder), index, static_cast<BinaryenType>(paramTypes),
                              static_cast<BinaryenType>(resultTypes));
}
uint32_t TypeBuilderBuildAndDisposeForLink(uint64_t builder, uint64_t heapTypes, uint64_t errorIndex,
                                           uint64_t errorReason, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(TypeBuilderBuildAndDispose(
      reinterpret_cast<TypeBuilderRef>(builder), reinterpret_cast<BinaryenHeapType *>(heapTypes),
      reinterpret_cast<BinaryenIndex *>(errorIndex), reinterpret_cast<TypeBuilderErrorReason *>(errorReason)));
}
uint32_t BinaryenStructTypeGetNumFieldsForLink(uint64_t heapType, [[maybe_unused]] void *ctx) {
  return BinaryenStructTypeGetNumFields(static_cast<BinaryenHeapType>(heapType));
}
void BinaryenModuleSetFieldNameForLink(uint64_t module, uint64_t heapType, uint32_t index, uint64_t name,
                                       [[maybe_unused]] void *ctx) {
  BinaryenModuleSetFieldName(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenHeapType>(heapType),
                             index, reinterpret_cast<const char *>(name));
}
uint64_t BinaryenLocalGetForLink(uint64_t module, uint32_t index, uint64_t type, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenLocalGet(reinterpret_cast<BinaryenModuleRef>(module), index, static_cast<BinaryenType>(type)));
}
uint64_t BinaryenAddFunctionForLink(uint64_t module, uint64_t name, uint64_t params, uint64_t results,
                                    uint64_t varTypes, uint32_t numVarTypes, uint64_t body,
                                    [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddFunction(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
      static_cast<BinaryenType>(params), static_cast<BinaryenType>(results), reinterpret_cast<BinaryenType *>(varTypes),
      numVarTypes, reinterpret_cast<BinaryenExpressionRef>(body)));
}
uint64_t BinaryenLocalTeeForLink(uint64_t module, uint32_t index, uint64_t value, uint64_t type,
                                 [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLocalTee(reinterpret_cast<BinaryenModuleRef>(module), index,
                                                     reinterpret_cast<BinaryenExpressionRef>(value),
                                                     static_cast<BinaryenType>(type)));
}
void BinaryenAddGlobalImportForLink(uint64_t module, uint64_t internalName, uint64_t externalModuleName,
                                    uint64_t externalBaseName, uint64_t globalType, uint32_t mutable_,
                                    [[maybe_unused]] void *ctx) {
  BinaryenAddGlobalImport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(internalName),
                          reinterpret_cast<const char *>(externalModuleName),
                          reinterpret_cast<const char *>(externalBaseName), static_cast<BinaryenType>(globalType),
                          mutable_ != 0);
}
uint64_t BinaryenGetGlobalForLink(uint64_t module, uint64_t name, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenGetGlobal(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name)));
}
uint32_t BinaryenGlobalIsMutableForLink(uint64_t global, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenGlobalIsMutable(reinterpret_cast<BinaryenGlobalRef>(global)));
}
void BinaryenLiteralFloat64ForLink(uint64_t ptr, double x, [[maybe_unused]] void *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralFloat64(x);
}
void BinaryenLiteralFloat32ForLink(uint64_t ptr, float x, [[maybe_unused]] void *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralFloat32(x);
}
void BinaryenLiteralVec128ForLink(uint64_t ptr, uint64_t bytes, [[maybe_unused]] void *ctx) {
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralVec128(reinterpret_cast<const uint8_t *>(bytes));
}
uint64_t BinaryenRefNullForLink(uint64_t module, uint64_t type, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenRefNull(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenType>(type)));
}
uint64_t BinaryenRefI31ForLink(uint64_t module, uint64_t value, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenRefI31(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenAddGlobalForLink(uint64_t module, uint64_t name, uint64_t type, uint32_t mutable_, uint64_t init,
                                  [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenAddGlobal(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name),
                        static_cast<BinaryenType>(type), mutable_ != 0, reinterpret_cast<BinaryenExpressionRef>(init)));
}
uint64_t BinaryenGlobalSetForLink(uint64_t module, uint64_t name, uint64_t value, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalSet(reinterpret_cast<BinaryenModuleRef>(module),
                                                      reinterpret_cast<const char *>(name),
                                                      reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenGlobalGetForLink(uint64_t module, uint64_t name, uint64_t type, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalGet(reinterpret_cast<BinaryenModuleRef>(module),
                                                      reinterpret_cast<const char *>(name),
                                                      static_cast<BinaryenType>(type)));
}
uint64_t BinaryenSwitchForLink(uint64_t module, uint64_t names, uint32_t numNames, uint64_t defaultName,
                               uint64_t condition, uint64_t value, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSwitch(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char **>(names), numNames,
                     reinterpret_cast<const char *>(defaultName), reinterpret_cast<BinaryenExpressionRef>(condition),
                     reinterpret_cast<BinaryenExpressionRef>(value)));
}
void BinaryenConstGetValueV128ForLink(uint64_t expr, uint64_t out, [[maybe_unused]] void *ctx) {
  BinaryenConstGetValueV128(reinterpret_cast<BinaryenExpressionRef>(expr), reinterpret_cast<uint8_t *>(out));
}
uint64_t BinaryenTypeCreateForLink(uint64_t types, uint32_t numTypes, [[maybe_unused]] void *ctx) {
  return BinaryenTypeCreate(reinterpret_cast<BinaryenType *>(types), numTypes);
}
void BinaryenFunctionSetDebugLocationForLink(uint64_t func, uint64_t expr, uint32_t fileIndex, uint32_t lineNumber,
                                             uint32_t columnNumber, [[maybe_unused]] void *ctx) {
  BinaryenFunctionSetDebugLocation(reinterpret_cast<BinaryenFunctionRef>(func),
                                   reinterpret_cast<BinaryenExpressionRef>(expr), fileIndex, lineNumber, columnNumber);
}
void BinaryenFunctionSetLocalNameForLink(uint64_t func, uint32_t index, uint64_t name, [[maybe_unused]] void *ctx) {
  BinaryenFunctionSetLocalName(reinterpret_cast<BinaryenFunctionRef>(func), index,
                               reinterpret_cast<const char *>(name));
}
uint32_t BinaryenExpressionGetSideEffectsForLink(uint64_t expr, uint64_t module, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenExpressionGetSideEffects(reinterpret_cast<BinaryenExpressionRef>(expr),
                                                                reinterpret_cast<BinaryenModuleRef>(module)));
}
uint64_t BinaryenRefEqForLink(uint64_t module, uint64_t left, uint64_t right, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefEq(reinterpret_cast<BinaryenModuleRef>(module),
                                                  reinterpret_cast<BinaryenExpressionRef>(left),
                                                  reinterpret_cast<BinaryenExpressionRef>(right)));
}
uint64_t BinaryenStringEqForLink(uint64_t module, int32_t op, uint64_t left, uint64_t right,
                                 [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEq(reinterpret_cast<BinaryenModuleRef>(module), op,
                                                     reinterpret_cast<BinaryenExpressionRef>(left),
                                                     reinterpret_cast<BinaryenExpressionRef>(right)));
}
uint32_t BinaryenModuleAddDebugInfoFileNameForLink(uint64_t module, uint64_t filename, [[maybe_unused]] void *ctx) {
  return BinaryenModuleAddDebugInfoFileName(reinterpret_cast<BinaryenModuleRef>(module),
                                            reinterpret_cast<const char *>(filename));
}
void BinaryenAddFunctionImportForLink(uint64_t module, uint64_t internalName, uint64_t externalModuleName,
                                      uint64_t externalBaseName, uint64_t params, uint64_t results,
                                      [[maybe_unused]] void *ctx) {
  BinaryenAddFunctionImport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(internalName),
                            reinterpret_cast<const char *>(externalModuleName),
                            reinterpret_cast<const char *>(externalBaseName), static_cast<BinaryenType>(params),
                            static_cast<BinaryenType>(results));
}
uint64_t BinaryenGetFunctionForLink(uint64_t module, uint64_t name, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenGetFunction(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name)));
}
uint64_t BinaryenLoadForLink(uint64_t module, uint32_t bytes, uint32_t signed_, uint32_t offset, uint32_t align,
                             uint64_t type, uint64_t ptr, uint64_t memoryName, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoad(
      reinterpret_cast<BinaryenModuleRef>(module), bytes, signed_ != 0, offset, align, static_cast<BinaryenType>(type),
      reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenStoreForLink(uint64_t module, uint32_t bytes, uint32_t offset, uint32_t align, uint64_t ptr,
                              uint64_t value, uint64_t type, uint64_t memoryName, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenStore(reinterpret_cast<BinaryenModuleRef>(module), bytes, offset, align,
                    reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<BinaryenExpressionRef>(value),
                    static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint32_t BinaryenTypeIsNullableForLink(uint64_t type, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenTypeIsNullable(static_cast<BinaryenType>(type)));
}
uint64_t BinaryenRefAsForLink(uint64_t module, uint32_t op, uint64_t ref, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefAs(reinterpret_cast<BinaryenModuleRef>(module),
                                                  static_cast<BinaryenOp>(op),
                                                  reinterpret_cast<BinaryenExpressionRef>(ref)));
}
uint64_t BinaryenSelectForLink(uint64_t module, uint64_t condition, uint64_t ifTrue, uint64_t ifFalse,
                               [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSelect(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(condition),
      reinterpret_cast<BinaryenExpressionRef>(ifTrue), reinterpret_cast<BinaryenExpressionRef>(ifFalse)));
}
uint64_t BinaryenExpressionCopyForLink(uint64_t expr, uint64_t module, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenExpressionCopy(reinterpret_cast<BinaryenExpressionRef>(expr),
                                                           reinterpret_cast<BinaryenModuleRef>(module)));
}
uint64_t BinaryenReturnCallIndirectForLink(uint64_t module, uint64_t table, uint64_t target, uint64_t operands,
                                           uint32_t numOperands, uint64_t params, uint64_t results,
                                           [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenReturnCallIndirect(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(table),
      reinterpret_cast<BinaryenExpressionRef>(target), reinterpret_cast<BinaryenExpressionRef *>(operands), numOperands,
      static_cast<BinaryenType>(params), static_cast<BinaryenType>(results)));
}
uint64_t BinaryenCallIndirectForLink(uint64_t module, uint64_t table, uint64_t target, uint64_t operands,
                                     uint32_t numOperands, uint64_t params, uint64_t results,
                                     [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallIndirect(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(table),
      reinterpret_cast<BinaryenExpressionRef>(target), reinterpret_cast<BinaryenExpressionRef *>(operands), numOperands,
      static_cast<BinaryenType>(params), static_cast<BinaryenType>(results)));
}
uint64_t BinaryenRefFuncForLink(uint64_t module, uint64_t func, uint64_t type, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefFunc(reinterpret_cast<BinaryenModuleRef>(module),
                                                    reinterpret_cast<const char *>(func),
                                                    static_cast<BinaryenType>(type)));
}
uint64_t BinaryenAtomicLoadForLink(uint64_t module, uint32_t bytes, uint32_t offset, uint64_t type, uint64_t ptr,
                                   uint64_t memoryName, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenAtomicLoad(reinterpret_cast<BinaryenModuleRef>(module), bytes, offset, static_cast<BinaryenType>(type),
                         reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicStoreForLink(uint64_t module, uint32_t bytes, uint32_t offset, uint64_t ptr, uint64_t value,
                                    uint64_t type, uint64_t memoryName, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenAtomicStore(reinterpret_cast<BinaryenModuleRef>(module), bytes, offset,
                          reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<BinaryenExpressionRef>(value),
                          static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicRMWForLink(uint64_t module, uint32_t op, uint32_t bytes, uint32_t offset, uint64_t ptr,
                                  uint64_t value, uint64_t type, uint64_t memoryName, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenAtomicRMW(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op), bytes, offset,
                        reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<BinaryenExpressionRef>(value),
                        static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicCmpxchgForLink(uint64_t module, uint32_t bytes, uint32_t offset, uint64_t ptr, uint64_t expected,
                                      uint64_t replacement, uint64_t type, uint64_t memoryName,
                                      [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicCmpxchg(
      reinterpret_cast<BinaryenModuleRef>(module), bytes, offset, reinterpret_cast<BinaryenExpressionRef>(ptr),
      reinterpret_cast<BinaryenExpressionRef>(expected), reinterpret_cast<BinaryenExpressionRef>(replacement),
      static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicWaitForLink(uint64_t module, uint64_t ptr, uint64_t expected, uint64_t timeout, uint64_t type,
                                   uint64_t memoryName, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicWait(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(ptr),
      reinterpret_cast<BinaryenExpressionRef>(expected), reinterpret_cast<BinaryenExpressionRef>(timeout),
      static_cast<BinaryenType>(type), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicNotifyForLink(uint64_t module, uint64_t ptr, uint64_t notifyCount, uint64_t memoryName,
                                     [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicNotify(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(ptr),
      reinterpret_cast<BinaryenExpressionRef>(notifyCount), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenAtomicFenceForLink(uint64_t module, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicFence(reinterpret_cast<BinaryenModuleRef>(module)));
}
uint64_t BinaryenMemorySizeForLink(uint64_t module, uint64_t memoryName, uint32_t memoryIs64,
                                   [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemorySize(reinterpret_cast<BinaryenModuleRef>(module),
                                                       reinterpret_cast<const char *>(memoryName), memoryIs64 != 0));
}
uint64_t BinaryenMemoryGrowForLink(uint64_t module, uint64_t delta, uint64_t memoryName, uint32_t memoryIs64,
                                   [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryGrow(reinterpret_cast<BinaryenModuleRef>(module),
                                                       reinterpret_cast<BinaryenExpressionRef>(delta),
                                                       reinterpret_cast<const char *>(memoryName), memoryIs64 != 0));
}
uint64_t BinaryenMemoryCopyForLink(uint64_t module, uint64_t dest, uint64_t source, uint64_t size,
                                   uint64_t destMemoryName, uint64_t sourceMemoryName, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryCopy(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(dest),
      reinterpret_cast<BinaryenExpressionRef>(source), reinterpret_cast<BinaryenExpressionRef>(size),
      reinterpret_cast<const char *>(destMemoryName), reinterpret_cast<const char *>(sourceMemoryName)));
}
uint64_t BinaryenMemoryFillForLink(uint64_t module, uint64_t dest, uint64_t value, uint64_t size, uint64_t memoryName,
                                   [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenMemoryFill(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(dest),
                         reinterpret_cast<BinaryenExpressionRef>(value), reinterpret_cast<BinaryenExpressionRef>(size),
                         reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenI31GetForLink(uint64_t module, uint64_t i31, uint32_t signed_, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenI31Get(reinterpret_cast<BinaryenModuleRef>(module),
                                                   reinterpret_cast<BinaryenExpressionRef>(i31), signed_ != 0));
}
uint64_t BinaryenSIMDReplaceForLink(uint64_t module, uint32_t op, uint64_t vec, uint32_t index, uint64_t value,
                                    [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDReplace(
      reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op),
      reinterpret_cast<BinaryenExpressionRef>(vec), index, reinterpret_cast<BinaryenExpressionRef>(value)));
}
uint64_t BinaryenSIMDExtractForLink(uint64_t module, uint32_t op, uint64_t vec, uint32_t index,
                                    [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDExtract(reinterpret_cast<BinaryenModuleRef>(module),
                                                        static_cast<BinaryenOp>(op),
                                                        reinterpret_cast<BinaryenExpressionRef>(vec), index));
}
uint64_t BinaryenSIMDShuffleForLink(uint64_t module, uint64_t left, uint64_t right, uint64_t mask,
                                    [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSIMDShuffle(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenExpressionRef>(left),
                          reinterpret_cast<BinaryenExpressionRef>(right), reinterpret_cast<const uint8_t *>(mask)));
}
uint64_t BinaryenSIMDLoadForLink(uint64_t module, uint32_t op, uint32_t offset, uint32_t align, uint64_t ptr,
                                 uint64_t memoryName, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSIMDLoad(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op), offset, align,
                       reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenSIMDLoadStoreLaneForLink(uint64_t module, uint32_t op, uint32_t offset, uint32_t align, uint32_t index,
                                          uint64_t ptr, uint64_t vec, uint64_t memoryName, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDLoadStoreLane(
      reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op), offset, align, index,
      reinterpret_cast<BinaryenExpressionRef>(ptr), reinterpret_cast<BinaryenExpressionRef>(vec),
      reinterpret_cast<const char *>(memoryName)));
}
uint64_t BinaryenSIMDShiftForLink(uint64_t module, uint32_t op, uint64_t vec, uint64_t shift,
                                  [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSIMDShift(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op),
                        reinterpret_cast<BinaryenExpressionRef>(vec), reinterpret_cast<BinaryenExpressionRef>(shift)));
}
uint64_t BinaryenSIMDTernaryForLink(uint64_t module, uint32_t op, uint64_t a, uint64_t b, uint64_t c,
                                    [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenSIMDTernary(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenOp>(op),
                          reinterpret_cast<BinaryenExpressionRef>(a), reinterpret_cast<BinaryenExpressionRef>(b),
                          reinterpret_cast<BinaryenExpressionRef>(c)));
}
uint64_t BinaryenModuleCreateForLink([[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenModuleCreate());
}
void BinaryenSetLowMemoryUnusedForLink(uint32_t unused, [[maybe_unused]] void *ctx) {
  BinaryenSetLowMemoryUnused(unused != 0);
}
void BinaryenModuleSetFeaturesForLink(uint64_t module, uint32_t features, [[maybe_unused]] void *ctx) {
  BinaryenModuleSetFeatures(reinterpret_cast<BinaryenModuleRef>(module), features);
}
void BinaryenSetClosedWorldForLink(uint32_t closed, [[maybe_unused]] void *ctx) { BinaryenSetClosedWorld(closed != 0); }
uint64_t BinaryenGetExportForLink(uint64_t module, uint64_t name, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenGetExport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name)));
}
uint64_t BinaryenAddFunctionExportForLink(uint64_t module, uint64_t internalName, uint64_t externalName,
                                          [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddFunctionExport(reinterpret_cast<BinaryenModuleRef>(module),
                                                              reinterpret_cast<const char *>(internalName),
                                                              reinterpret_cast<const char *>(externalName)));
}
uint64_t BinaryenAddGlobalExportForLink(uint64_t module, uint64_t internalName, uint64_t externalName,
                                        [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddGlobalExport(reinterpret_cast<BinaryenModuleRef>(module),
                                                            reinterpret_cast<const char *>(internalName),
                                                            reinterpret_cast<const char *>(externalName)));
}
void BinaryenRemoveFunctionForLink(uint64_t module, uint64_t name, [[maybe_unused]] void *ctx) {
  BinaryenRemoveFunction(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name));
}
void BinaryenRemoveGlobalForLink(uint64_t module, uint64_t name, [[maybe_unused]] void *ctx) {
  BinaryenRemoveGlobal(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name));
}
void BinaryenAddMemoryImportForLink(uint64_t module, uint64_t internalName, uint64_t externalModuleName,
                                    uint64_t externalBaseName, uint32_t shared, [[maybe_unused]] void *ctx) {
  BinaryenAddMemoryImport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(internalName),
                          reinterpret_cast<const char *>(externalModuleName),
                          reinterpret_cast<const char *>(externalBaseName), shared != 0);
}
void BinaryenAddTableImportForLink(uint64_t module, uint64_t internalName, uint64_t externalModuleName,
                                   uint64_t externalBaseName, [[maybe_unused]] void *ctx) {
  BinaryenAddTableImport(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(internalName),
                         reinterpret_cast<const char *>(externalModuleName),
                         reinterpret_cast<const char *>(externalBaseName));
}
uint64_t BinaryenAddTableExportForLink(uint64_t module, uint64_t internalName, uint64_t externalName,
                                       [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddTableExport(reinterpret_cast<BinaryenModuleRef>(module),
                                                           reinterpret_cast<const char *>(internalName),
                                                           reinterpret_cast<const char *>(externalName)));
}
void BinaryenSetPassArgumentForLink(uint64_t key, uint64_t value, [[maybe_unused]] void *ctx) {
  BinaryenSetPassArgument(reinterpret_cast<const char *>(key), reinterpret_cast<const char *>(value));
}
uint64_t BinaryenGetTableForLink(uint64_t module, uint64_t name, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenGetTable(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(name)));
}
uint64_t BinaryenAddTableForLink(uint64_t module, uint64_t name, uint32_t initial, uint32_t maximum, uint64_t type,
                                 [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddTable(reinterpret_cast<BinaryenModuleRef>(module),
                                                     reinterpret_cast<const char *>(name), initial, maximum,
                                                     static_cast<BinaryenType>(type)));
}
void BinaryenTableSetInitialForLink(uint64_t table, uint32_t initial, [[maybe_unused]] void *ctx) {
  BinaryenTableSetInitial(reinterpret_cast<BinaryenTableRef>(table), initial);
}
void BinaryenTableSetMaxForLink(uint64_t table, uint32_t maximum, [[maybe_unused]] void *ctx) {
  BinaryenTableSetMax(reinterpret_cast<BinaryenTableRef>(table), maximum);
}
uint64_t BinaryenAddActiveElementSegmentForLink(uint64_t module, uint64_t table, uint64_t name, uint64_t funcNames,
                                                uint32_t numFuncNames, uint64_t offset, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAddActiveElementSegment(
      reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<const char *>(table),
      reinterpret_cast<const char *>(name), reinterpret_cast<const char **>(funcNames), numFuncNames,
      reinterpret_cast<BinaryenExpressionRef>(offset)));
}
void BinaryenSetStartForLink(uint64_t module, uint64_t start, [[maybe_unused]] void *ctx) {
  BinaryenSetStart(reinterpret_cast<BinaryenModuleRef>(module), reinterpret_cast<BinaryenFunctionRef>(start));
}
uint32_t BinaryenGetNumFunctionsForLink(uint64_t module, [[maybe_unused]] void *ctx) {
  return BinaryenGetNumFunctions(reinterpret_cast<BinaryenModuleRef>(module));
}
uint64_t BinaryenGetFunctionByIndexForLink(uint64_t module, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGetFunctionByIndex(reinterpret_cast<BinaryenModuleRef>(module), index));
}
uint64_t BinaryenFunctionGetBodyForLink(uint64_t func, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenFunctionGetBody(reinterpret_cast<BinaryenFunctionRef>(func)));
}
uint64_t BinaryenLoopGetNameForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoopGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenLoopGetBodyForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoopGetBody(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBreakGetNameForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBreakGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBreakGetConditionForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBreakGetCondition(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBreakGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBreakGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSwitchGetDefaultNameForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSwitchGetDefaultName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenSwitchGetNumNamesForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenSwitchGetNumNames(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenSwitchGetNameAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSwitchGetNameAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenSwitchGetConditionForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSwitchGetCondition(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSwitchGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSwitchGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenCallIndirectGetTargetForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallIndirectGetTarget(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenCallIndirectGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenCallIndirectGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenCallIndirectGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenCallIndirectGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenGlobalSetGetNameForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalSetGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenGlobalSetGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalSetGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenLoadGetPtrForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenLoadGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStoreGetPtrForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStoreGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStoreGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStoreGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSelectGetConditionForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSelectGetCondition(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenDropGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenDropGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenReturnGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenReturnGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryGrowGetDeltaForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryGrowGetDelta(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicRMWGetPtrForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicRMWGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicRMWGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicRMWGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicCmpxchgGetPtrForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicCmpxchgGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicCmpxchgGetExpectedForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicCmpxchgGetExpected(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicCmpxchgGetReplacementForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicCmpxchgGetReplacement(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicWaitGetPtrForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicWaitGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicWaitGetExpectedForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicWaitGetExpected(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicWaitGetTimeoutForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicWaitGetTimeout(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicNotifyGetPtrForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicNotifyGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenAtomicNotifyGetNotifyCountForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenAtomicNotifyGetNotifyCount(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDExtractGetVecForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDExtractGetVec(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDReplaceGetVecForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDReplaceGetVec(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDReplaceGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDReplaceGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDShuffleGetLeftForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDShuffleGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDShuffleGetRightForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDShuffleGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDTernaryGetAForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDTernaryGetA(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDTernaryGetBForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDTernaryGetB(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDTernaryGetCForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDTernaryGetC(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDShiftGetVecForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDShiftGetVec(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDShiftGetShiftForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDShiftGetShift(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDLoadGetPtrForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDLoadGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDLoadStoreLaneGetPtrForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDLoadStoreLaneGetPtr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenSIMDLoadStoreLaneGetVecForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenSIMDLoadStoreLaneGetVec(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryInitGetDestForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryInitGetDest(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryInitGetOffsetForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryInitGetOffset(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryInitGetSizeForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryInitGetSize(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryCopyGetDestForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryCopyGetDest(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryCopyGetSourceForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryCopyGetSource(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryCopyGetSizeForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryCopyGetSize(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryFillGetDestForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryFillGetDest(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryFillGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryFillGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenMemoryFillGetSizeForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenMemoryFillGetSize(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefIsNullGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefIsNullGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefFuncGetFuncForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefFuncGetFunc(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefEqGetLeftForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefEqGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefEqGetRightForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefEqGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenTryGetBodyForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenTryGetBody(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenTryGetNumCatchBodiesForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenTryGetNumCatchBodies(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenTryGetCatchBodyAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenTryGetCatchBodyAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenThrowGetTagForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenThrowGetTag(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenThrowGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenThrowGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenThrowGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenThrowGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint32_t BinaryenTupleMakeGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenTupleMakeGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenTupleMakeGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenTupleMakeGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenTupleExtractGetTupleForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenTupleExtractGetTuple(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefI31GetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefI31GetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenI31GetGetI31ForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenI31GetGetI31(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenCallRefGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenCallRefGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenCallRefGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallRefGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenCallRefGetTargetForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenCallRefGetTarget(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefTestGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefTestGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefCastGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefCastGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBrOnGetNameForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBrOnGetName(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenBrOnGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenBrOnGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenStructNewGetNumOperandsForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenStructNewGetNumOperands(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenStructNewGetOperandAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenStructNewGetOperandAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenStructGetGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStructGetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenStructGetGetIndexForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenStructGetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenStructSetGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStructSetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenStructSetGetIndexForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenStructSetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenStructSetGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStructSetGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayNewGetSizeForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayNewGetSize(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayNewGetInitForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayNewGetInit(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenArrayNewFixedGetNumValuesForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenArrayNewFixedGetNumValues(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenArrayNewFixedGetValueAtForLink(uint64_t expr, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(
      BinaryenArrayNewFixedGetValueAt(reinterpret_cast<BinaryenExpressionRef>(expr), index));
}
uint64_t BinaryenArrayGetGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayGetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayGetGetIndexForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayGetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArraySetGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArraySetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArraySetGetIndexForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArraySetGetIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArraySetGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArraySetGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayLenGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayLenGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetDestRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetDestRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetDestIndexForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetDestIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetSrcRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetSrcRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetSrcIndexForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetSrcIndex(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenArrayCopyGetLengthForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenArrayCopyGetLength(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenRefAsGetValueForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenRefAsGetValue(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringNewGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringNewGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringNewGetStartForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringNewGetStart(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringNewGetEndForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringNewGetEnd(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringMeasureGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringMeasureGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEncodeGetStrForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEncodeGetStr(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEncodeGetArrayForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEncodeGetArray(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEncodeGetStartForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEncodeGetStart(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringConcatGetLeftForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringConcatGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringConcatGetRightForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringConcatGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEqGetLeftForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEqGetLeft(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringEqGetRightForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringEqGetRight(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringWTF16GetGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringWTF16GetGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringWTF16GetGetPosForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringWTF16GetGetPos(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringSliceWTFGetRefForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringSliceWTFGetRef(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringSliceWTFGetStartForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringSliceWTFGetStart(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint64_t BinaryenStringSliceWTFGetEndForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenStringSliceWTFGetEnd(reinterpret_cast<BinaryenExpressionRef>(expr)));
}
uint32_t BinaryenGetNumGlobalsForLink(uint64_t module, [[maybe_unused]] void *ctx) {
  return BinaryenGetNumGlobals(reinterpret_cast<BinaryenModuleRef>(module));
}
uint64_t BinaryenGetGlobalByIndexForLink(uint64_t module, uint32_t index, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGetGlobalByIndex(reinterpret_cast<BinaryenModuleRef>(module), index));
}
uint64_t BinaryenGlobalGetInitExprForLink(uint64_t global, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenGlobalGetInitExpr(reinterpret_cast<BinaryenGlobalRef>(global)));
}
uint32_t BinaryenModuleValidateForLink(uint64_t module, [[maybe_unused]] void *ctx) {
  return static_cast<uint32_t>(BinaryenModuleValidate(reinterpret_cast<BinaryenModuleRef>(module)));
}
uint32_t BinaryenStoreGetOffsetForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenStoreGetOffset(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint32_t BinaryenStoreGetBytesForLink(uint64_t expr, [[maybe_unused]] void *ctx) {
  return BinaryenStoreGetBytes(reinterpret_cast<BinaryenExpressionRef>(expr));
}
uint64_t BinaryenFunctionGetNameForLink(uint64_t func, [[maybe_unused]] void *ctx) {
  return reinterpret_cast<uint64_t>(BinaryenFunctionGetName(reinterpret_cast<BinaryenFunctionRef>(func)));
}
void BinaryenStoreSetPtrForLink(uint64_t expr, uint64_t ptr, [[maybe_unused]] void *ctx) {
  BinaryenStoreSetPtr(reinterpret_cast<BinaryenExpressionRef>(expr), reinterpret_cast<BinaryenExpressionRef>(ptr));
}
void BinaryenModuleSetTypeNameForLink(uint64_t module, uint64_t heapType, uint64_t name, [[maybe_unused]] void *ctx) {
  BinaryenModuleSetTypeName(reinterpret_cast<BinaryenModuleRef>(module), static_cast<BinaryenHeapType>(heapType),
                            reinterpret_cast<const char *>(name));
}
} // namespace

namespace {

uint32_t loadU8(uint64_t ptr, [[maybe_unused]] void *ctx) { return reinterpret_cast<uint8_t *>(ptr)[0]; }
uint32_t loadI32(uint64_t ptr, [[maybe_unused]] void *ctx) { return reinterpret_cast<int32_t *>(ptr)[0]; }
void store8(uint64_t ptr, uint32_t value, [[maybe_unused]] void *ctx) { reinterpret_cast<uint8_t *>(ptr)[0] = value; }
void store32(uint64_t ptr, uint32_t value, [[maybe_unused]] void *ctx) { reinterpret_cast<uint32_t *>(ptr)[0] = value; }
void store64(uint64_t ptr, uint64_t value, [[maybe_unused]] void *ctx) { reinterpret_cast<uint64_t *>(ptr)[0] = value; }

uint64_t malloc(uint32_t size, [[maybe_unused]] void *ctx) { return reinterpret_cast<uint64_t>(std::malloc(size)); }
void free(uint64_t ptr, [[maybe_unused]] void *ctx) { std::free(reinterpret_cast<void *>(ptr)); }

std::string getAsString(uint32_t ptr, vb::WasmModule *ctx) {
  if (ptr == 0U)
    return "<<NULL>>";
  uint8_t const *header = ctx->getLinearMemoryRegion(ptr - 20U, 20);
  uint32_t size = 0;
  std::memcpy(&size, header + 16, sizeof(size));
  uint8_t const *content = ctx->getLinearMemoryRegion(ptr, size);
  size /= 2U;

  std::stringstream ss{};
  for (uint32_t i = 0; i < size; ++i) {
    ss << content[i * 2U];
  }
  return std::move(ss).str();
}

void abort(uint32_t messagePtr, uint32_t fileNamePtr, uint32_t lineNumber, uint32_t columnNumber, vb::WasmModule *ctx) {
  std::stringstream ss{};
  ss << "abort: " << getAsString(messagePtr, ctx) << " in " << getAsString(fileNamePtr, ctx) << ":" << lineNumber << ":"
     << columnNumber;
  std::cerr << std::move(ss).str() << std::endl;
  // ctx->requestInterruption(vb::TrapCode::BUILTIN_TRAP);
}

void trace(uint32_t ptr, uint32_t n, double d1, double d2, double d3, double d4, double d5, vb::WasmModule *ctx) {
  std::stringstream ss{};
  ss << getAsString(ptr, ctx);
  for (size_t i = 0; i < n; i++) {
    switch (i) {
    case 1:
      ss << " " << d1;
      break;
    case 2:
      ss << " " << d2;
      break;
    case 3:
      ss << " " << d3;
      break;
    case 4:
      ss << " " << d4;
      break;
    case 5:
      ss << " " << d5;
      break;
    }
  }
  std::cout << std::move(ss).str() << std::endl;
}

} // namespace
} // namespace export_to_asc

const std::vector<vb::NativeSymbol> warpo::frontend ::linkedAPI{
    STATIC_LINK("env", "abort", export_to_asc::abort),
    STATIC_LINK("env", "trace", export_to_asc::trace),

    STATIC_LINK("binaryen", "__i32_load8_u", export_to_asc::loadU8),
    STATIC_LINK("binaryen", "__i32_load", export_to_asc::loadI32),
    STATIC_LINK("binaryen", "__i32_store8", export_to_asc::store8),
    STATIC_LINK("binaryen", "__i32_store", export_to_asc::store32),
    STATIC_LINK("binaryen", "__i64_store", export_to_asc::store64),
    STATIC_LINK("binaryen", "_malloc", export_to_asc::malloc),
    STATIC_LINK("binaryen", "_free", export_to_asc::free),

    STATIC_LINK("binaryen", "_BinaryenTypeFuncref", export_to_asc::BinaryenTypeFuncrefForLink),
    STATIC_LINK("binaryen", "_BinaryenSizeofLiteral", export_to_asc::BinaryenSizeofLiteralForLink),
    STATIC_LINK("binaryen", "_BinaryenCallGetOperandAt", export_to_asc::BinaryenCallGetOperandAtForLink),
    STATIC_LINK("binaryen", "_BinaryenReturnCall", export_to_asc::BinaryenReturnCallForLink),
    STATIC_LINK("binaryen", "_BinaryenCall", export_to_asc::BinaryenCallForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeExternref", export_to_asc::BinaryenTypeExternrefForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeAnyref", export_to_asc::BinaryenTypeAnyrefForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeEqref", export_to_asc::BinaryenTypeEqrefForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeStructref", export_to_asc::BinaryenTypeStructrefForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeArrayref", export_to_asc::BinaryenTypeArrayrefForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeI31ref", export_to_asc::BinaryenTypeI31refForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeStringref", export_to_asc::BinaryenTypeStringrefForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeNullref", export_to_asc::BinaryenTypeNullrefForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeNullFuncref", export_to_asc::BinaryenTypeNullFuncrefForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeNullExternref", export_to_asc::BinaryenTypeNullExternrefForLink),
    STATIC_LINK("binaryen", "_BinaryenUnreachable", export_to_asc::BinaryenUnreachableForLink),
    STATIC_LINK("binaryen", "_BinaryenExpressionGetId", export_to_asc::BinaryenExpressionGetIdForLink),
    STATIC_LINK("binaryen", "_BinaryenLocalSetIsTee", export_to_asc::BinaryenLocalSetIsTeeForLink),
    STATIC_LINK("binaryen", "_BinaryenLocalSetGetIndex", export_to_asc::BinaryenLocalSetGetIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenLocalGetGetIndex", export_to_asc::BinaryenLocalGetGetIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenLocalSetGetValue", export_to_asc::BinaryenLocalSetGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenGlobalGetGetName", export_to_asc::BinaryenGlobalGetGetNameForLink),
    STATIC_LINK("binaryen", "_BinaryenBinaryGetOp", export_to_asc::BinaryenBinaryGetOpForLink),
    STATIC_LINK("binaryen", "_BinaryenBinaryGetLeft", export_to_asc::BinaryenBinaryGetLeftForLink),
    STATIC_LINK("binaryen", "_BinaryenConstGetValueI32", export_to_asc::BinaryenConstGetValueI32ForLink),
    STATIC_LINK("binaryen", "_BinaryenBinaryGetRight", export_to_asc::BinaryenBinaryGetRightForLink),
    STATIC_LINK("binaryen", "_BinaryenUnaryGetOp", export_to_asc::BinaryenUnaryGetOpForLink),
    STATIC_LINK("binaryen", "_BinaryenExpressionGetType", export_to_asc::BinaryenExpressionGetTypeForLink),
    STATIC_LINK("binaryen", "_BinaryenConstGetValueI64Low", export_to_asc::BinaryenConstGetValueI64LowForLink),
    STATIC_LINK("binaryen", "_BinaryenConstGetValueF32", export_to_asc::BinaryenConstGetValueF32ForLink),
    STATIC_LINK("binaryen", "_BinaryenConstGetValueF64", export_to_asc::BinaryenConstGetValueF64ForLink),
    STATIC_LINK("binaryen", "_BinaryenLoadIsSigned", export_to_asc::BinaryenLoadIsSignedForLink),
    STATIC_LINK("binaryen", "_BinaryenLoadGetBytes", export_to_asc::BinaryenLoadGetBytesForLink),
    STATIC_LINK("binaryen", "_BinaryenBlockGetName", export_to_asc::BinaryenBlockGetNameForLink),
    STATIC_LINK("binaryen", "_BinaryenBlockGetNumChildren", export_to_asc::BinaryenBlockGetNumChildrenForLink),
    STATIC_LINK("binaryen", "_BinaryenBlockGetChildAt", export_to_asc::BinaryenBlockGetChildAtForLink),
    STATIC_LINK("binaryen", "_BinaryenIfGetIfTrue", export_to_asc::BinaryenIfGetIfTrueForLink),
    STATIC_LINK("binaryen", "_BinaryenIfGetIfFalse", export_to_asc::BinaryenIfGetIfFalseForLink),
    STATIC_LINK("binaryen", "_BinaryenSelectGetIfTrue", export_to_asc::BinaryenSelectGetIfTrueForLink),
    STATIC_LINK("binaryen", "_BinaryenSelectGetIfFalse", export_to_asc::BinaryenSelectGetIfFalseForLink),
    STATIC_LINK("binaryen", "_BinaryenCallGetTarget", export_to_asc::BinaryenCallGetTargetForLink),
    STATIC_LINK("binaryen", "_BinaryenConst", export_to_asc::BinaryenConstForLink),
    STATIC_LINK("binaryen", "_BinaryenNop", export_to_asc::BinaryenNopForLink),
    STATIC_LINK("binaryen", "_BinaryenBlock", export_to_asc::BinaryenBlockForLink),
    STATIC_LINK("binaryen", "_BinaryenBreak", export_to_asc::BinaryenBreakForLink),
    STATIC_LINK("binaryen", "_BinaryenBinary", export_to_asc::BinaryenBinaryForLink),
    STATIC_LINK("binaryen", "_BinaryenUnary", export_to_asc::BinaryenUnaryForLink),
    STATIC_LINK("binaryen", "_BinaryenRefIsNull", export_to_asc::BinaryenRefIsNullForLink),
    STATIC_LINK("binaryen", "_ExpressionRunnerCreate", export_to_asc::ExpressionRunnerCreateForLink),
    STATIC_LINK("binaryen", "_ExpressionRunnerRunAndDispose", export_to_asc::ExpressionRunnerRunAndDisposeForLink),
    STATIC_LINK("binaryen", "_BinaryenLiteralInt32", export_to_asc::BinaryenLiteralInt32ForLink),
    STATIC_LINK("binaryen", "_BinaryenLiteralInt64", export_to_asc::BinaryenLiteralInt64ForLink),
    STATIC_LINK("binaryen", "_BinaryenSetMemory", export_to_asc::BinaryenSetMemoryForLink),
    STATIC_LINK("binaryen", "_BinaryenModuleGetFeatures", export_to_asc::BinaryenModuleGetFeaturesForLink),
    STATIC_LINK("binaryen", "_BinaryenConstGetValueI64High", export_to_asc::BinaryenConstGetValueI64HighForLink),
    STATIC_LINK("binaryen", "_BinaryenIfGetCondition", export_to_asc::BinaryenIfGetConditionForLink),
    STATIC_LINK("binaryen", "_BinaryenUnaryGetValue", export_to_asc::BinaryenUnaryGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenCallGetNumOperands", export_to_asc::BinaryenCallGetNumOperandsForLink),
    STATIC_LINK("binaryen", "_BinaryenLoop", export_to_asc::BinaryenLoopForLink),
    STATIC_LINK("binaryen", "_BinaryenDrop", export_to_asc::BinaryenDropForLink),
    STATIC_LINK("binaryen", "_BinaryenIf", export_to_asc::BinaryenIfForLink),
    STATIC_LINK("binaryen", "_BinaryenReturn", export_to_asc::BinaryenReturnForLink),
    STATIC_LINK("binaryen", "_BinaryenLocalSet", export_to_asc::BinaryenLocalSetForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeFromHeapType", export_to_asc::BinaryenTypeFromHeapTypeForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeGetHeapType", export_to_asc::BinaryenTypeGetHeapTypeForLink),
    STATIC_LINK("binaryen", "_TypeBuilderCreate", export_to_asc::TypeBuilderCreateForLink),
    STATIC_LINK("binaryen", "_TypeBuilderGetSize", export_to_asc::TypeBuilderGetSizeForLink),
    STATIC_LINK("binaryen", "_TypeBuilderGrow", export_to_asc::TypeBuilderGrowForLink),
    STATIC_LINK("binaryen", "_TypeBuilderGetTempHeapType", export_to_asc::TypeBuilderGetTempHeapTypeForLink),
    STATIC_LINK("binaryen", "_TypeBuilderGetTempRefType", export_to_asc::TypeBuilderGetTempRefTypeForLink),
    STATIC_LINK("binaryen", "_TypeBuilderSetStructType", export_to_asc::TypeBuilderSetStructTypeForLink),
    STATIC_LINK("binaryen", "_TypeBuilderSetSubType", export_to_asc::TypeBuilderSetSubTypeForLink),
    STATIC_LINK("binaryen", "_TypeBuilderGetTempTupleType", export_to_asc::TypeBuilderGetTempTupleTypeForLink),
    STATIC_LINK("binaryen", "_TypeBuilderSetSignatureType", export_to_asc::TypeBuilderSetSignatureTypeForLink),
    STATIC_LINK("binaryen", "_TypeBuilderBuildAndDispose", export_to_asc::TypeBuilderBuildAndDisposeForLink),
    STATIC_LINK("binaryen", "_BinaryenStructTypeGetNumFields", export_to_asc::BinaryenStructTypeGetNumFieldsForLink),
    STATIC_LINK("binaryen", "_BinaryenModuleSetFieldName", export_to_asc::BinaryenModuleSetFieldNameForLink),
    STATIC_LINK("binaryen", "_BinaryenLocalGet", export_to_asc::BinaryenLocalGetForLink),
    STATIC_LINK("binaryen", "_BinaryenAddFunction", export_to_asc::BinaryenAddFunctionForLink),
    STATIC_LINK("binaryen", "_BinaryenLocalTee", export_to_asc::BinaryenLocalTeeForLink),
    STATIC_LINK("binaryen", "_BinaryenAddGlobalImport", export_to_asc::BinaryenAddGlobalImportForLink),
    STATIC_LINK("binaryen", "_BinaryenGetGlobal", export_to_asc::BinaryenGetGlobalForLink),
    STATIC_LINK("binaryen", "_BinaryenGlobalIsMutable", export_to_asc::BinaryenGlobalIsMutableForLink),
    STATIC_LINK("binaryen", "_BinaryenLiteralFloat64", export_to_asc::BinaryenLiteralFloat64ForLink),
    STATIC_LINK("binaryen", "_BinaryenLiteralFloat32", export_to_asc::BinaryenLiteralFloat32ForLink),
    STATIC_LINK("binaryen", "_BinaryenLiteralVec128", export_to_asc::BinaryenLiteralVec128ForLink),
    STATIC_LINK("binaryen", "_BinaryenRefNull", export_to_asc::BinaryenRefNullForLink),
    STATIC_LINK("binaryen", "_BinaryenRefI31", export_to_asc::BinaryenRefI31ForLink),
    STATIC_LINK("binaryen", "_BinaryenAddGlobal", export_to_asc::BinaryenAddGlobalForLink),
    STATIC_LINK("binaryen", "_BinaryenGlobalSet", export_to_asc::BinaryenGlobalSetForLink),
    STATIC_LINK("binaryen", "_BinaryenGlobalGet", export_to_asc::BinaryenGlobalGetForLink),
    STATIC_LINK("binaryen", "_BinaryenSwitch", export_to_asc::BinaryenSwitchForLink),
    STATIC_LINK("binaryen", "_BinaryenConstGetValueV128", export_to_asc::BinaryenConstGetValueV128ForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeCreate", export_to_asc::BinaryenTypeCreateForLink),
    STATIC_LINK("binaryen", "_BinaryenFunctionSetDebugLocation",
                export_to_asc::BinaryenFunctionSetDebugLocationForLink),
    STATIC_LINK("binaryen", "_BinaryenFunctionSetLocalName", export_to_asc::BinaryenFunctionSetLocalNameForLink),
    STATIC_LINK("binaryen", "_BinaryenExpressionGetSideEffects",
                export_to_asc::BinaryenExpressionGetSideEffectsForLink),
    STATIC_LINK("binaryen", "_BinaryenRefEq", export_to_asc::BinaryenRefEqForLink),
    STATIC_LINK("binaryen", "_BinaryenStringEq", export_to_asc::BinaryenStringEqForLink),
    STATIC_LINK("binaryen", "_BinaryenModuleAddDebugInfoFileName",
                export_to_asc::BinaryenModuleAddDebugInfoFileNameForLink),
    STATIC_LINK("binaryen", "_BinaryenAddFunctionImport", export_to_asc::BinaryenAddFunctionImportForLink),
    STATIC_LINK("binaryen", "_BinaryenGetFunction", export_to_asc::BinaryenGetFunctionForLink),
    STATIC_LINK("binaryen", "_BinaryenLoad", export_to_asc::BinaryenLoadForLink),
    STATIC_LINK("binaryen", "_BinaryenStore", export_to_asc::BinaryenStoreForLink),
    STATIC_LINK("binaryen", "_BinaryenTypeIsNullable", export_to_asc::BinaryenTypeIsNullableForLink),
    STATIC_LINK("binaryen", "_BinaryenRefAs", export_to_asc::BinaryenRefAsForLink),
    STATIC_LINK("binaryen", "_BinaryenSelect", export_to_asc::BinaryenSelectForLink),
    STATIC_LINK("binaryen", "_BinaryenExpressionCopy", export_to_asc::BinaryenExpressionCopyForLink),
    STATIC_LINK("binaryen", "_BinaryenReturnCallIndirect", export_to_asc::BinaryenReturnCallIndirectForLink),
    STATIC_LINK("binaryen", "_BinaryenCallIndirect", export_to_asc::BinaryenCallIndirectForLink),
    STATIC_LINK("binaryen", "_BinaryenRefFunc", export_to_asc::BinaryenRefFuncForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicLoad", export_to_asc::BinaryenAtomicLoadForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicStore", export_to_asc::BinaryenAtomicStoreForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicRMW", export_to_asc::BinaryenAtomicRMWForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicCmpxchg", export_to_asc::BinaryenAtomicCmpxchgForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicWait", export_to_asc::BinaryenAtomicWaitForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicNotify", export_to_asc::BinaryenAtomicNotifyForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicFence", export_to_asc::BinaryenAtomicFenceForLink),
    STATIC_LINK("binaryen", "_BinaryenMemorySize", export_to_asc::BinaryenMemorySizeForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryGrow", export_to_asc::BinaryenMemoryGrowForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryCopy", export_to_asc::BinaryenMemoryCopyForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryFill", export_to_asc::BinaryenMemoryFillForLink),
    STATIC_LINK("binaryen", "_BinaryenI31Get", export_to_asc::BinaryenI31GetForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDReplace", export_to_asc::BinaryenSIMDReplaceForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDExtract", export_to_asc::BinaryenSIMDExtractForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDShuffle", export_to_asc::BinaryenSIMDShuffleForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDLoad", export_to_asc::BinaryenSIMDLoadForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDLoadStoreLane", export_to_asc::BinaryenSIMDLoadStoreLaneForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDShift", export_to_asc::BinaryenSIMDShiftForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDTernary", export_to_asc::BinaryenSIMDTernaryForLink),
    STATIC_LINK("binaryen", "_BinaryenModuleCreate", export_to_asc::BinaryenModuleCreateForLink),
    STATIC_LINK("binaryen", "_BinaryenSetLowMemoryUnused", export_to_asc::BinaryenSetLowMemoryUnusedForLink),
    STATIC_LINK("binaryen", "_BinaryenModuleSetFeatures", export_to_asc::BinaryenModuleSetFeaturesForLink),
    STATIC_LINK("binaryen", "_BinaryenSetClosedWorld", export_to_asc::BinaryenSetClosedWorldForLink),
    STATIC_LINK("binaryen", "_BinaryenGetExport", export_to_asc::BinaryenGetExportForLink),
    STATIC_LINK("binaryen", "_BinaryenAddFunctionExport", export_to_asc::BinaryenAddFunctionExportForLink),
    STATIC_LINK("binaryen", "_BinaryenAddGlobalExport", export_to_asc::BinaryenAddGlobalExportForLink),
    STATIC_LINK("binaryen", "_BinaryenRemoveFunction", export_to_asc::BinaryenRemoveFunctionForLink),
    STATIC_LINK("binaryen", "_BinaryenRemoveGlobal", export_to_asc::BinaryenRemoveGlobalForLink),
    STATIC_LINK("binaryen", "_BinaryenAddMemoryImport", export_to_asc::BinaryenAddMemoryImportForLink),
    STATIC_LINK("binaryen", "_BinaryenAddTableImport", export_to_asc::BinaryenAddTableImportForLink),
    STATIC_LINK("binaryen", "_BinaryenAddTableExport", export_to_asc::BinaryenAddTableExportForLink),
    STATIC_LINK("binaryen", "_BinaryenSetPassArgument", export_to_asc::BinaryenSetPassArgumentForLink),
    STATIC_LINK("binaryen", "_BinaryenGetTable", export_to_asc::BinaryenGetTableForLink),
    STATIC_LINK("binaryen", "_BinaryenAddTable", export_to_asc::BinaryenAddTableForLink),
    STATIC_LINK("binaryen", "_BinaryenTableSetInitial", export_to_asc::BinaryenTableSetInitialForLink),
    STATIC_LINK("binaryen", "_BinaryenTableSetMax", export_to_asc::BinaryenTableSetMaxForLink),
    STATIC_LINK("binaryen", "_BinaryenAddActiveElementSegment", export_to_asc::BinaryenAddActiveElementSegmentForLink),
    STATIC_LINK("binaryen", "_BinaryenSetStart", export_to_asc::BinaryenSetStartForLink),
    STATIC_LINK("binaryen", "_BinaryenGetNumFunctions", export_to_asc::BinaryenGetNumFunctionsForLink),
    STATIC_LINK("binaryen", "_BinaryenGetFunctionByIndex", export_to_asc::BinaryenGetFunctionByIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenFunctionGetBody", export_to_asc::BinaryenFunctionGetBodyForLink),
    STATIC_LINK("binaryen", "_BinaryenLoopGetName", export_to_asc::BinaryenLoopGetNameForLink),
    STATIC_LINK("binaryen", "_BinaryenLoopGetBody", export_to_asc::BinaryenLoopGetBodyForLink),
    STATIC_LINK("binaryen", "_BinaryenBreakGetName", export_to_asc::BinaryenBreakGetNameForLink),
    STATIC_LINK("binaryen", "_BinaryenBreakGetCondition", export_to_asc::BinaryenBreakGetConditionForLink),
    STATIC_LINK("binaryen", "_BinaryenBreakGetValue", export_to_asc::BinaryenBreakGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenSwitchGetDefaultName", export_to_asc::BinaryenSwitchGetDefaultNameForLink),
    STATIC_LINK("binaryen", "_BinaryenSwitchGetNumNames", export_to_asc::BinaryenSwitchGetNumNamesForLink),
    STATIC_LINK("binaryen", "_BinaryenSwitchGetNameAt", export_to_asc::BinaryenSwitchGetNameAtForLink),
    STATIC_LINK("binaryen", "_BinaryenSwitchGetCondition", export_to_asc::BinaryenSwitchGetConditionForLink),
    STATIC_LINK("binaryen", "_BinaryenSwitchGetValue", export_to_asc::BinaryenSwitchGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenCallIndirectGetTarget", export_to_asc::BinaryenCallIndirectGetTargetForLink),
    STATIC_LINK("binaryen", "_BinaryenCallIndirectGetNumOperands",
                export_to_asc::BinaryenCallIndirectGetNumOperandsForLink),
    STATIC_LINK("binaryen", "_BinaryenCallIndirectGetOperandAt",
                export_to_asc::BinaryenCallIndirectGetOperandAtForLink),
    STATIC_LINK("binaryen", "_BinaryenGlobalSetGetName", export_to_asc::BinaryenGlobalSetGetNameForLink),
    STATIC_LINK("binaryen", "_BinaryenGlobalSetGetValue", export_to_asc::BinaryenGlobalSetGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenLoadGetPtr", export_to_asc::BinaryenLoadGetPtrForLink),
    STATIC_LINK("binaryen", "_BinaryenStoreGetPtr", export_to_asc::BinaryenStoreGetPtrForLink),
    STATIC_LINK("binaryen", "_BinaryenStoreGetValue", export_to_asc::BinaryenStoreGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenSelectGetCondition", export_to_asc::BinaryenSelectGetConditionForLink),
    STATIC_LINK("binaryen", "_BinaryenDropGetValue", export_to_asc::BinaryenDropGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenReturnGetValue", export_to_asc::BinaryenReturnGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryGrowGetDelta", export_to_asc::BinaryenMemoryGrowGetDeltaForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicRMWGetPtr", export_to_asc::BinaryenAtomicRMWGetPtrForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicRMWGetValue", export_to_asc::BinaryenAtomicRMWGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicCmpxchgGetPtr", export_to_asc::BinaryenAtomicCmpxchgGetPtrForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicCmpxchgGetExpected",
                export_to_asc::BinaryenAtomicCmpxchgGetExpectedForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicCmpxchgGetReplacement",
                export_to_asc::BinaryenAtomicCmpxchgGetReplacementForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicWaitGetPtr", export_to_asc::BinaryenAtomicWaitGetPtrForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicWaitGetExpected", export_to_asc::BinaryenAtomicWaitGetExpectedForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicWaitGetTimeout", export_to_asc::BinaryenAtomicWaitGetTimeoutForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicNotifyGetPtr", export_to_asc::BinaryenAtomicNotifyGetPtrForLink),
    STATIC_LINK("binaryen", "_BinaryenAtomicNotifyGetNotifyCount",
                export_to_asc::BinaryenAtomicNotifyGetNotifyCountForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDExtractGetVec", export_to_asc::BinaryenSIMDExtractGetVecForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDReplaceGetVec", export_to_asc::BinaryenSIMDReplaceGetVecForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDReplaceGetValue", export_to_asc::BinaryenSIMDReplaceGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDShuffleGetLeft", export_to_asc::BinaryenSIMDShuffleGetLeftForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDShuffleGetRight", export_to_asc::BinaryenSIMDShuffleGetRightForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDTernaryGetA", export_to_asc::BinaryenSIMDTernaryGetAForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDTernaryGetB", export_to_asc::BinaryenSIMDTernaryGetBForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDTernaryGetC", export_to_asc::BinaryenSIMDTernaryGetCForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDShiftGetVec", export_to_asc::BinaryenSIMDShiftGetVecForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDShiftGetShift", export_to_asc::BinaryenSIMDShiftGetShiftForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDLoadGetPtr", export_to_asc::BinaryenSIMDLoadGetPtrForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDLoadStoreLaneGetPtr", export_to_asc::BinaryenSIMDLoadStoreLaneGetPtrForLink),
    STATIC_LINK("binaryen", "_BinaryenSIMDLoadStoreLaneGetVec", export_to_asc::BinaryenSIMDLoadStoreLaneGetVecForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryInitGetDest", export_to_asc::BinaryenMemoryInitGetDestForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryInitGetOffset", export_to_asc::BinaryenMemoryInitGetOffsetForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryInitGetSize", export_to_asc::BinaryenMemoryInitGetSizeForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryCopyGetDest", export_to_asc::BinaryenMemoryCopyGetDestForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryCopyGetSource", export_to_asc::BinaryenMemoryCopyGetSourceForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryCopyGetSize", export_to_asc::BinaryenMemoryCopyGetSizeForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryFillGetDest", export_to_asc::BinaryenMemoryFillGetDestForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryFillGetValue", export_to_asc::BinaryenMemoryFillGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenMemoryFillGetSize", export_to_asc::BinaryenMemoryFillGetSizeForLink),
    STATIC_LINK("binaryen", "_BinaryenRefIsNullGetValue", export_to_asc::BinaryenRefIsNullGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenRefFuncGetFunc", export_to_asc::BinaryenRefFuncGetFuncForLink),
    STATIC_LINK("binaryen", "_BinaryenRefEqGetLeft", export_to_asc::BinaryenRefEqGetLeftForLink),
    STATIC_LINK("binaryen", "_BinaryenRefEqGetRight", export_to_asc::BinaryenRefEqGetRightForLink),
    STATIC_LINK("binaryen", "_BinaryenTryGetBody", export_to_asc::BinaryenTryGetBodyForLink),
    STATIC_LINK("binaryen", "_BinaryenTryGetNumCatchBodies", export_to_asc::BinaryenTryGetNumCatchBodiesForLink),
    STATIC_LINK("binaryen", "_BinaryenTryGetCatchBodyAt", export_to_asc::BinaryenTryGetCatchBodyAtForLink),
    STATIC_LINK("binaryen", "_BinaryenThrowGetTag", export_to_asc::BinaryenThrowGetTagForLink),
    STATIC_LINK("binaryen", "_BinaryenThrowGetNumOperands", export_to_asc::BinaryenThrowGetNumOperandsForLink),
    STATIC_LINK("binaryen", "_BinaryenThrowGetOperandAt", export_to_asc::BinaryenThrowGetOperandAtForLink),
    STATIC_LINK("binaryen", "_BinaryenTupleMakeGetNumOperands", export_to_asc::BinaryenTupleMakeGetNumOperandsForLink),
    STATIC_LINK("binaryen", "_BinaryenTupleMakeGetOperandAt", export_to_asc::BinaryenTupleMakeGetOperandAtForLink),
    STATIC_LINK("binaryen", "_BinaryenTupleExtractGetTuple", export_to_asc::BinaryenTupleExtractGetTupleForLink),
    STATIC_LINK("binaryen", "_BinaryenRefI31GetValue", export_to_asc::BinaryenRefI31GetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenI31GetGetI31", export_to_asc::BinaryenI31GetGetI31ForLink),
    STATIC_LINK("binaryen", "_BinaryenCallRefGetNumOperands", export_to_asc::BinaryenCallRefGetNumOperandsForLink),
    STATIC_LINK("binaryen", "_BinaryenCallRefGetOperandAt", export_to_asc::BinaryenCallRefGetOperandAtForLink),
    STATIC_LINK("binaryen", "_BinaryenCallRefGetTarget", export_to_asc::BinaryenCallRefGetTargetForLink),
    STATIC_LINK("binaryen", "_BinaryenRefTestGetRef", export_to_asc::BinaryenRefTestGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenRefCastGetRef", export_to_asc::BinaryenRefCastGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenBrOnGetName", export_to_asc::BinaryenBrOnGetNameForLink),
    STATIC_LINK("binaryen", "_BinaryenBrOnGetRef", export_to_asc::BinaryenBrOnGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenStructNewGetNumOperands", export_to_asc::BinaryenStructNewGetNumOperandsForLink),
    STATIC_LINK("binaryen", "_BinaryenStructNewGetOperandAt", export_to_asc::BinaryenStructNewGetOperandAtForLink),
    STATIC_LINK("binaryen", "_BinaryenStructGetGetRef", export_to_asc::BinaryenStructGetGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenStructGetGetIndex", export_to_asc::BinaryenStructGetGetIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenStructSetGetRef", export_to_asc::BinaryenStructSetGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenStructSetGetIndex", export_to_asc::BinaryenStructSetGetIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenStructSetGetValue", export_to_asc::BinaryenStructSetGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayNewGetSize", export_to_asc::BinaryenArrayNewGetSizeForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayNewGetInit", export_to_asc::BinaryenArrayNewGetInitForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayNewFixedGetNumValues",
                export_to_asc::BinaryenArrayNewFixedGetNumValuesForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayNewFixedGetValueAt", export_to_asc::BinaryenArrayNewFixedGetValueAtForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayGetGetRef", export_to_asc::BinaryenArrayGetGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayGetGetIndex", export_to_asc::BinaryenArrayGetGetIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenArraySetGetRef", export_to_asc::BinaryenArraySetGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenArraySetGetIndex", export_to_asc::BinaryenArraySetGetIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenArraySetGetValue", export_to_asc::BinaryenArraySetGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayLenGetRef", export_to_asc::BinaryenArrayLenGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayCopyGetDestRef", export_to_asc::BinaryenArrayCopyGetDestRefForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayCopyGetDestIndex", export_to_asc::BinaryenArrayCopyGetDestIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayCopyGetSrcRef", export_to_asc::BinaryenArrayCopyGetSrcRefForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayCopyGetSrcIndex", export_to_asc::BinaryenArrayCopyGetSrcIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenArrayCopyGetLength", export_to_asc::BinaryenArrayCopyGetLengthForLink),
    STATIC_LINK("binaryen", "_BinaryenRefAsGetValue", export_to_asc::BinaryenRefAsGetValueForLink),
    STATIC_LINK("binaryen", "_BinaryenStringNewGetRef", export_to_asc::BinaryenStringNewGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenStringNewGetStart", export_to_asc::BinaryenStringNewGetStartForLink),
    STATIC_LINK("binaryen", "_BinaryenStringNewGetEnd", export_to_asc::BinaryenStringNewGetEndForLink),
    STATIC_LINK("binaryen", "_BinaryenStringMeasureGetRef", export_to_asc::BinaryenStringMeasureGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenStringEncodeGetStr", export_to_asc::BinaryenStringEncodeGetStrForLink),
    STATIC_LINK("binaryen", "_BinaryenStringEncodeGetArray", export_to_asc::BinaryenStringEncodeGetArrayForLink),
    STATIC_LINK("binaryen", "_BinaryenStringEncodeGetStart", export_to_asc::BinaryenStringEncodeGetStartForLink),
    STATIC_LINK("binaryen", "_BinaryenStringConcatGetLeft", export_to_asc::BinaryenStringConcatGetLeftForLink),
    STATIC_LINK("binaryen", "_BinaryenStringConcatGetRight", export_to_asc::BinaryenStringConcatGetRightForLink),
    STATIC_LINK("binaryen", "_BinaryenStringEqGetLeft", export_to_asc::BinaryenStringEqGetLeftForLink),
    STATIC_LINK("binaryen", "_BinaryenStringEqGetRight", export_to_asc::BinaryenStringEqGetRightForLink),
    STATIC_LINK("binaryen", "_BinaryenStringWTF16GetGetRef", export_to_asc::BinaryenStringWTF16GetGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenStringWTF16GetGetPos", export_to_asc::BinaryenStringWTF16GetGetPosForLink),
    STATIC_LINK("binaryen", "_BinaryenStringSliceWTFGetRef", export_to_asc::BinaryenStringSliceWTFGetRefForLink),
    STATIC_LINK("binaryen", "_BinaryenStringSliceWTFGetStart", export_to_asc::BinaryenStringSliceWTFGetStartForLink),
    STATIC_LINK("binaryen", "_BinaryenStringSliceWTFGetEnd", export_to_asc::BinaryenStringSliceWTFGetEndForLink),
    STATIC_LINK("binaryen", "_BinaryenGetNumGlobals", export_to_asc::BinaryenGetNumGlobalsForLink),
    STATIC_LINK("binaryen", "_BinaryenGetGlobalByIndex", export_to_asc::BinaryenGetGlobalByIndexForLink),
    STATIC_LINK("binaryen", "_BinaryenGlobalGetInitExpr", export_to_asc::BinaryenGlobalGetInitExprForLink),
    STATIC_LINK("binaryen", "_BinaryenModuleValidate", export_to_asc::BinaryenModuleValidateForLink),
    STATIC_LINK("binaryen", "_BinaryenStoreGetOffset", export_to_asc::BinaryenStoreGetOffsetForLink),
    STATIC_LINK("binaryen", "_BinaryenStoreGetBytes", export_to_asc::BinaryenStoreGetBytesForLink),
    STATIC_LINK("binaryen", "_BinaryenFunctionGetName", export_to_asc::BinaryenFunctionGetNameForLink),
    STATIC_LINK("binaryen", "_BinaryenStoreSetPtr", export_to_asc::BinaryenStoreSetPtrForLink),
    STATIC_LINK("binaryen", "_BinaryenModuleSetTypeName", export_to_asc::BinaryenModuleSetTypeNameForLink),
};
