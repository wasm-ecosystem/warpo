#include <cstdint>

#include "BackendBase.hpp"

#include "src/config.hpp"
#include "src/core/common/util.hpp"
#include "src/core/compiler/common/StackElement.hpp"
#include "src/core/compiler/common/StackType.hpp"
#include "src/core/compiler/common/util.hpp"

/// @brief analyze div rem args
vb::DivRemAnalysisResult vb::analyzeDivRem(StackElement const *const arg0Ptr, StackElement const *const arg1Ptr) VB_NOEXCEPT {
  DivRemAnalysisResult result{false, false};
  if (arg0Ptr->type == StackType::CONSTANT_I32) {
    uint32_t const arg0{arg0Ptr->data.constUnion.u32};
    constexpr uint32_t maxBitSet{1_U32 << 31_U32};
    if ((arg0 != maxBitSet)) {
      result.mustNotBeOverflow = true;
    }
  } else if (arg0Ptr->type == StackType::CONSTANT_I64) {
    uint64_t const arg0{arg0Ptr->data.constUnion.u64};
    constexpr uint64_t maxBitSet{1_U64 << 63_U64};
    if ((arg0 != maxBitSet)) {
      result.mustNotBeOverflow = true;
    }
  } else {
    static_cast<void>(0);
  }

  if (arg1Ptr->type == StackType::CONSTANT_I32) {
    uint32_t const arg1{arg1Ptr->data.constUnion.u32};
    if (arg1 != 0_U32) {
      result.mustNotBeDivZero = true;
    }
    if ((arg1 != static_cast<uint32_t>(-1))) {
      result.mustNotBeOverflow = true;
    }
  } else if (arg1Ptr->type == StackType::CONSTANT_I64) {
    uint64_t const arg1{arg1Ptr->data.constUnion.u64};
    if (arg1 != 0_U64) {
      result.mustNotBeDivZero = true;
    }
    if ((arg1 != static_cast<uint64_t>(-1))) {
      result.mustNotBeOverflow = true;
    }
  } else {
    static_cast<void>(0);
  }
  return result;
}
