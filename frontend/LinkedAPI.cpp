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
  int64_t const v = (static_cast<int64_t>(y) << 32) | (static_cast<uint32_t>(x));
  *reinterpret_cast<BinaryenLiteral *>(ptr) = BinaryenLiteralInt64(v);
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

} // namespace

namespace {

uint32_t loadU8(uint64_t ptr, [[maybe_unused]] void *ctx) { return reinterpret_cast<uint8_t *>(ptr)[0]; }

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
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTypeFromHeapType", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenTypeFromHeapType)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTypeGetHeapType", "(I)I",
                     reinterpret_cast<void *>(&BinaryenTypeGetHeapType)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderCreate", "(i)I",
                     reinterpret_cast<void *>(&TypeBuilderCreate)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderGetSize", "(I)i",
                     reinterpret_cast<void *>(&TypeBuilderGetSize)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderGrow", "(Ii)",
                     reinterpret_cast<void *>(&TypeBuilderGrow)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderGetTempHeapType", "(Ii)I",
                     reinterpret_cast<void *>(&TypeBuilderGetTempHeapType)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderGetTempRefType", "(IIi)I",
                     reinterpret_cast<void *>(&TypeBuilderGetTempRefType)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderSetStructType", "(IiIIIi)",
                     reinterpret_cast<void *>(&TypeBuilderSetStructType)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderSetSubType", "(IiI)",
                     reinterpret_cast<void *>(&TypeBuilderSetSubType)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderGetTempTupleType", "(IIi)I",
                     reinterpret_cast<void *>(&TypeBuilderGetTempTupleType)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderSetSignatureType", "(IiII)",
                     reinterpret_cast<void *>(&TypeBuilderSetSignatureType)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_TypeBuilderBuildAndDispose", "(IIII)i",
                     reinterpret_cast<void *>(&TypeBuilderBuildAndDispose)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "__i32_load", "(I)i",
                     reinterpret_cast<void *>(&BinaryenModuleSetTypeName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStructTypeGetNumFields", "(I)i",
                     reinterpret_cast<void *>(&BinaryenStructTypeGetNumFields)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenModuleSetFieldName", "(IIiI)",
                     reinterpret_cast<void *>(&BinaryenModuleSetFieldName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenLocalGet", "(IiI)I",
                     reinterpret_cast<void *>(&BinaryenLocalGet)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddFunction", "(IIIIIiI)I",
                     reinterpret_cast<void *>(&BinaryenAddFunction)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenLocalTee", "(IiII)I",
                     reinterpret_cast<void *>(&BinaryenLocalTee)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddGlobalImport", "(IIIIIi)",
                     reinterpret_cast<void *>(&BinaryenAddGlobalImport)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGetGlobal", "(II)I",
                     reinterpret_cast<void *>(&BinaryenGetGlobal)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGlobalIsMutable", "(I)i",
                     reinterpret_cast<void *>(&BinaryenGlobalIsMutable)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenLiteralFloat64", "(IF)",
                     reinterpret_cast<void *>(&BinaryenLiteralFloat64)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenLiteralFloat32", "(If)",
                     reinterpret_cast<void *>(&BinaryenLiteralFloat32)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenLiteralVec128", "(II)",
                     reinterpret_cast<void *>(&BinaryenLiteralVec128)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefNull", "(II)I",
                     reinterpret_cast<void *>(&BinaryenRefNull)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefI31", "(II)I",
                     reinterpret_cast<void *>(&BinaryenRefI31)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddGlobal", "(IIIiI)I",
                     reinterpret_cast<void *>(&BinaryenAddGlobal)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGlobalSet", "(III)I",
                     reinterpret_cast<void *>(&BinaryenGlobalSet)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGlobalGet", "(III)I",
                     reinterpret_cast<void *>(&BinaryenGlobalGet)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSwitch", "(IIiIII)I",
                     reinterpret_cast<void *>(&BinaryenSwitch)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenConstGetValueV128", "(II)",
                     reinterpret_cast<void *>(&BinaryenConstGetValueV128)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTypeCreate", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenTypeCreate)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenFunctionSetDebugLocation", "(IIiii)",
                     reinterpret_cast<void *>(&BinaryenFunctionSetDebugLocation)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenFunctionSetLocalName", "(IiI)",
                     reinterpret_cast<void *>(&BinaryenFunctionSetLocalName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenExpressionGetSideEffects", "(II)i",
                     reinterpret_cast<void *>(&BinaryenExpressionGetSideEffects)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefEq", "(III)I",
                     reinterpret_cast<void *>(&BinaryenRefEq)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringEq", "(IiII)I",
                     reinterpret_cast<void *>(&BinaryenStringEq)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenModuleAddDebugInfoFileName", "(II)i",
                     reinterpret_cast<void *>(&BinaryenModuleAddDebugInfoFileName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddFunctionImport", "(IIIIII)",
                     reinterpret_cast<void *>(&BinaryenAddFunctionImport)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGetFunction", "(II)I",
                     reinterpret_cast<void *>(&BinaryenGetFunction)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenLoad", "(IiiiiIII)I",
                     reinterpret_cast<void *>(&BinaryenLoad)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStore", "(IiiiIIII)I",
                     reinterpret_cast<void *>(&BinaryenStore)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTypeIsNullable", "(I)i",
                     reinterpret_cast<void *>(&BinaryenTypeIsNullable)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefAs", "(IiI)I",
                     reinterpret_cast<void *>(&BinaryenRefAs)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSelect", "(IIII)I",
                     reinterpret_cast<void *>(&BinaryenSelect)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenExpressionCopy", "(II)I",
                     reinterpret_cast<void *>(&BinaryenExpressionCopy)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenReturnCallIndirect", "(IIIIiII)I",
                     reinterpret_cast<void *>(&BinaryenReturnCallIndirect)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenCallIndirect", "(IIIIiII)I",
                     reinterpret_cast<void *>(&BinaryenCallIndirect)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefFunc", "(III)I",
                     reinterpret_cast<void *>(&BinaryenRefFunc)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicLoad", "(IiiIII)I",
                     reinterpret_cast<void *>(&BinaryenAtomicLoad)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicStore", "(IiiIIII)I",
                     reinterpret_cast<void *>(&BinaryenAtomicStore)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicRMW", "(IiiiIIII)I",
                     reinterpret_cast<void *>(&BinaryenAtomicRMW)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicCmpxchg", "(IiiIIIII)I",
                     reinterpret_cast<void *>(&BinaryenAtomicCmpxchg)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicWait", "(IIIIII)I",
                     reinterpret_cast<void *>(&BinaryenAtomicWait)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicNotify", "(IIII)I",
                     reinterpret_cast<void *>(&BinaryenAtomicNotify)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicFence", "(II)I",
                     reinterpret_cast<void *>(&BinaryenAtomicFence)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemorySize", "(IIi)I",
                     reinterpret_cast<void *>(&BinaryenMemorySize)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryGrow", "(IIIi)I",
                     reinterpret_cast<void *>(&BinaryenMemoryGrow)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryCopy", "(IIIIII)I",
                     reinterpret_cast<void *>(&BinaryenMemoryCopy)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryFill", "(IIIII)I",
                     reinterpret_cast<void *>(&BinaryenMemoryFill)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenI31Get", "(IIi)I",
                     reinterpret_cast<void *>(&BinaryenI31Get)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDReplace", "(IiIiI)I",
                     reinterpret_cast<void *>(&BinaryenSIMDReplace)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDExtract", "(IiIi)I",
                     reinterpret_cast<void *>(&BinaryenSIMDExtract)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDShuffle", "(IIII)I",
                     reinterpret_cast<void *>(&BinaryenSIMDShuffle)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDLoad", "(IiiiII)I",
                     reinterpret_cast<void *>(&BinaryenSIMDLoad)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDLoadStoreLane", "(IiiiiIII)I",
                     reinterpret_cast<void *>(&BinaryenSIMDLoadStoreLane)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDShift", "(IiII)I",
                     reinterpret_cast<void *>(&BinaryenSIMDShift)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDTernary", "(IiIII)I",
                     reinterpret_cast<void *>(&BinaryenSIMDTernary)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenModuleCreate", "()I",
                     reinterpret_cast<void *>(&BinaryenModuleCreate)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSetLowMemoryUnused", "(i)",
                     reinterpret_cast<void *>(&BinaryenSetLowMemoryUnused)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenModuleSetFeatures", "(Ii)",
                     reinterpret_cast<void *>(&BinaryenModuleSetFeatures)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSetClosedWorld", "(i)",
                     reinterpret_cast<void *>(&BinaryenSetClosedWorld)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGetExport", "(II)I",
                     reinterpret_cast<void *>(&BinaryenGetExport)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddFunctionExport", "(III)I",
                     reinterpret_cast<void *>(&BinaryenAddFunctionExport)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddGlobalExport", "(III)I",
                     reinterpret_cast<void *>(&BinaryenAddGlobalExport)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRemoveFunction", "(II)",
                     reinterpret_cast<void *>(&BinaryenRemoveFunction)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRemoveGlobal", "(II)",
                     reinterpret_cast<void *>(&BinaryenRemoveGlobal)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddMemoryImport", "(IIIIi)",
                     reinterpret_cast<void *>(&BinaryenAddMemoryImport)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddTableImport", "(IIII)",
                     reinterpret_cast<void *>(&BinaryenAddTableImport)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddTableExport", "(III)I",
                     reinterpret_cast<void *>(&BinaryenAddTableExport)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSetPassArgument", "(II)",
                     reinterpret_cast<void *>(&BinaryenSetPassArgument)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGetTable", "(II)I",
                     reinterpret_cast<void *>(&BinaryenGetTable)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddTable", "(IIiiI)I",
                     reinterpret_cast<void *>(&BinaryenAddTable)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTableSetInitial", "(Ii)",
                     reinterpret_cast<void *>(&BinaryenTableSetInitial)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTableSetMax", "(Ii)",
                     reinterpret_cast<void *>(&BinaryenTableSetMax)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAddActiveElementSegment", "(IIIIiI)I",
                     reinterpret_cast<void *>(&BinaryenAddActiveElementSegment)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSetStart", "(II)",
                     reinterpret_cast<void *>(&BinaryenSetStart)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGetNumFunctions", "(I)i",
                     reinterpret_cast<void *>(&BinaryenGetNumFunctions)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGetFunctionByIndex", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenGetFunctionByIndex)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenFunctionGetBody", "(I)I",
                     reinterpret_cast<void *>(&BinaryenFunctionGetBody)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenLoopGetName", "(I)I",
                     reinterpret_cast<void *>(&BinaryenLoopGetName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenLoopGetBody", "(I)I",
                     reinterpret_cast<void *>(&BinaryenLoopGetBody)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenBreakGetName", "(I)I",
                     reinterpret_cast<void *>(&BinaryenBreakGetName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenBreakGetCondition", "(I)I",
                     reinterpret_cast<void *>(&BinaryenBreakGetCondition)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenBreakGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenBreakGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSwitchGetDefaultName", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSwitchGetDefaultName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSwitchGetNumNames", "(I)i",
                     reinterpret_cast<void *>(&BinaryenSwitchGetNumNames)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSwitchGetNameAt", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenSwitchGetNameAt)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSwitchGetCondition", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSwitchGetCondition)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSwitchGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSwitchGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenCallIndirectGetTarget", "(I)I",
                     reinterpret_cast<void *>(&BinaryenCallIndirectGetTarget)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenCallIndirectGetNumOperands", "(I)i",
                     reinterpret_cast<void *>(&BinaryenCallIndirectGetNumOperands)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenCallIndirectGetOperandAt", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenCallIndirectGetOperandAt)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGlobalSetGetName", "(I)I",
                     reinterpret_cast<void *>(&BinaryenGlobalSetGetName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGlobalSetGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenGlobalSetGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenLoadGetPtr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenLoadGetPtr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStoreGetPtr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStoreGetPtr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStoreGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStoreGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSelectGetCondition", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSelectGetCondition)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenDropGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenDropGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenReturnGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenReturnGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryGrowGetDelta", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryGrowGetDelta)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicRMWGetPtr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicRMWGetPtr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicRMWGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicRMWGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicCmpxchgGetPtr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicCmpxchgGetPtr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicCmpxchgGetExpected", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicCmpxchgGetExpected)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicCmpxchgGetReplacement", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicCmpxchgGetReplacement)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicWaitGetPtr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicWaitGetPtr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicWaitGetExpected", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicWaitGetExpected)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicWaitGetTimeout", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicWaitGetTimeout)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicNotifyGetPtr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicNotifyGetPtr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenAtomicNotifyGetNotifyCount", "(I)I",
                     reinterpret_cast<void *>(&BinaryenAtomicNotifyGetNotifyCount)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDExtractGetVec", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDExtractGetVec)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDReplaceGetVec", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDReplaceGetVec)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDReplaceGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDReplaceGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDShuffleGetLeft", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDShuffleGetLeft)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDShuffleGetRight", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDShuffleGetRight)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDTernaryGetA", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDTernaryGetA)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDTernaryGetB", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDTernaryGetB)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDTernaryGetC", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDTernaryGetC)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDShiftGetVec", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDShiftGetVec)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDShiftGetShift", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDShiftGetShift)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDLoadGetPtr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDLoadGetPtr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDLoadStoreLaneGetPtr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDLoadStoreLaneGetPtr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenSIMDLoadStoreLaneGetVec", "(I)I",
                     reinterpret_cast<void *>(&BinaryenSIMDLoadStoreLaneGetVec)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryInitGetDest", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryInitGetDest)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryInitGetOffset", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryInitGetOffset)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryInitGetSize", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryInitGetSize)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryCopyGetDest", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryCopyGetDest)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryCopyGetSource", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryCopyGetSource)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryCopyGetSize", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryCopyGetSize)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryFillGetDest", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryFillGetDest)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryFillGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryFillGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenMemoryFillGetSize", "(I)I",
                     reinterpret_cast<void *>(&BinaryenMemoryFillGetSize)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefIsNullGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenRefIsNullGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefFuncGetFunc", "(I)I",
                     reinterpret_cast<void *>(&BinaryenRefFuncGetFunc)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefEqGetLeft", "(I)I",
                     reinterpret_cast<void *>(&BinaryenRefEqGetLeft)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefEqGetRight", "(I)I",
                     reinterpret_cast<void *>(&BinaryenRefEqGetRight)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTryGetBody", "(I)I",
                     reinterpret_cast<void *>(&BinaryenTryGetBody)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTryGetNumCatchBodies", "(I)i",
                     reinterpret_cast<void *>(&BinaryenTryGetNumCatchBodies)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTryGetCatchBodyAt", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenTryGetCatchBodyAt)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenThrowGetTag", "(I)I",
                     reinterpret_cast<void *>(&BinaryenThrowGetTag)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenThrowGetNumOperands", "(I)i",
                     reinterpret_cast<void *>(&BinaryenThrowGetNumOperands)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenThrowGetOperandAt", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenThrowGetOperandAt)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTupleMakeGetNumOperands", "(I)i",
                     reinterpret_cast<void *>(&BinaryenTupleMakeGetNumOperands)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTupleMakeGetOperandAt", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenTupleMakeGetOperandAt)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenTupleExtractGetTuple", "(I)I",
                     reinterpret_cast<void *>(&BinaryenTupleExtractGetTuple)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefI31GetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenRefI31GetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenI31GetGetI31", "(I)I",
                     reinterpret_cast<void *>(&BinaryenI31GetGetI31)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenCallRefGetNumOperands", "(I)i",
                     reinterpret_cast<void *>(&BinaryenCallRefGetNumOperands)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenCallRefGetOperandAt", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenCallRefGetOperandAt)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenCallRefGetTarget", "(I)I",
                     reinterpret_cast<void *>(&BinaryenCallRefGetTarget)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefTestGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenRefTestGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefCastGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenRefCastGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenBrOnGetName", "(I)I",
                     reinterpret_cast<void *>(&BinaryenBrOnGetName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenBrOnGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenBrOnGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStructNewGetNumOperands", "(I)i",
                     reinterpret_cast<void *>(&BinaryenStructNewGetNumOperands)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStructNewGetOperandAt", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenStructNewGetOperandAt)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStructGetGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStructGetGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStructGetGetIndex", "(I)i",
                     reinterpret_cast<void *>(&BinaryenStructGetGetIndex)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStructSetGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStructSetGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStructSetGetIndex", "(I)i",
                     reinterpret_cast<void *>(&BinaryenStructSetGetIndex)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStructSetGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStructSetGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayNewGetSize", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayNewGetSize)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayNewGetInit", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayNewGetInit)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayNewFixedGetNumValues", "(I)i",
                     reinterpret_cast<void *>(&BinaryenArrayNewFixedGetNumValues)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayNewFixedGetValueAt", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenArrayNewFixedGetValueAt)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayGetGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayGetGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayGetGetIndex", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayGetGetIndex)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArraySetGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArraySetGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArraySetGetIndex", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArraySetGetIndex)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArraySetGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArraySetGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayLenGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayLenGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayCopyGetDestRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayCopyGetDestRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayCopyGetDestIndex", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayCopyGetDestIndex)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayCopyGetSrcRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayCopyGetSrcRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayCopyGetSrcIndex", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayCopyGetSrcIndex)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenArrayCopyGetLength", "(I)I",
                     reinterpret_cast<void *>(&BinaryenArrayCopyGetLength)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenRefAsGetValue", "(I)I",
                     reinterpret_cast<void *>(&BinaryenRefAsGetValue)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringNewGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringNewGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringNewGetStart", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringNewGetStart)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringNewGetEnd", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringNewGetEnd)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringMeasureGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringMeasureGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringEncodeGetStr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringEncodeGetStr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringEncodeGetArray", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringEncodeGetArray)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringEncodeGetStart", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringEncodeGetStart)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringConcatGetLeft", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringConcatGetLeft)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringConcatGetRight", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringConcatGetRight)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringEqGetLeft", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringEqGetLeft)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringEqGetRight", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringEqGetRight)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringWTF16GetGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringWTF16GetGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringWTF16GetGetPos", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringWTF16GetGetPos)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringSliceWTFGetRef", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringSliceWTFGetRef)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringSliceWTFGetStart", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringSliceWTFGetStart)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStringSliceWTFGetEnd", "(I)I",
                     reinterpret_cast<void *>(&BinaryenStringSliceWTFGetEnd)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGetNumGlobals", "(I)i",
                     reinterpret_cast<void *>(&BinaryenGetNumGlobals)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGetGlobalByIndex", "(Ii)I",
                     reinterpret_cast<void *>(&BinaryenGetGlobalByIndex)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenGlobalGetInitExpr", "(I)I",
                     reinterpret_cast<void *>(&BinaryenGlobalGetInitExpr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenModuleValidate", "(I)i",
                     reinterpret_cast<void *>(&BinaryenModuleValidate)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStoreGetOffset", "(I)i",
                     reinterpret_cast<void *>(&BinaryenStoreGetOffset)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStoreGetBytes", "(I)i",
                     reinterpret_cast<void *>(&BinaryenStoreGetBytes)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenFunctionGetName", "(I)I",
                     reinterpret_cast<void *>(&BinaryenFunctionGetName)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenStoreSetPtr", "(II)",
                     reinterpret_cast<void *>(&BinaryenStoreSetPtr)},
    vb::NativeSymbol{vb::NativeSymbol::Linkage::STATIC, "binaryen", "_BinaryenModuleSetTypeName", "(III)",
                     reinterpret_cast<void *>(&BinaryenModuleSetTypeName)},
};
