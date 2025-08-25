
///
/// @file tricore_cc.cpp
/// @copyright Copyright (C) 2024 BMW Group
///

// coverity[autosar_cpp14_a16_2_2_violation]
#include "src/config.hpp"

#ifdef JIT_TARGET_TRICORE
#include <array>
#include <cassert>
#include <cstdint>

#include "tricore_cc.hpp"

#include "src/core/common/RegPosArr.hpp"
#include "src/core/compiler/backend/tricore/tricore_encoding.hpp"

namespace vb {
namespace tc {

namespace WasmABI {

/// @brief Array holding the position of each register in the dr array
// coverity[autosar_cpp14_a8_5_2_violation]
// coverity[autosar_cpp14_m3_4_1_violation]
static constexpr auto drRegPos = vb::genPosArr<totalNumRegs>(dr);

uint32_t getRegPos(REG const dataReg) VB_NOEXCEPT {
  assert(RegUtil::isDATA(dataReg));
  return static_cast<uint32_t>(drRegPos[static_cast<uint32_t>(dataReg)]);
}

bool isResScratchReg(REG const dataReg) VB_NOEXCEPT {
  assert(RegUtil::isDATA(dataReg));

  uint32_t const regPos{getRegPos(dataReg)};
  return regPos >= scratchRegStart;
}

} // namespace WasmABI

namespace NativeABI {

/// @brief Array holding the position of each register in the paramRegs array
// coverity[autosar_cpp14_a8_5_2_violation]
// coverity[autosar_cpp14_m3_4_1_violation]
static constexpr auto paramsPos = vb::genPosArr<totalNumRegs>(paramRegs);

bool canBeParam(REG const dataReg) VB_NOEXCEPT {
  assert(RegUtil::isDATA(dataReg));
  return paramsPos[static_cast<uint32_t>(dataReg)] != static_cast<uint8_t>(UINT8_MAX);
}

uint32_t getNativeParamPos(REG const reg) VB_NOEXCEPT {
  return static_cast<uint32_t>(paramsPos[static_cast<uint32_t>(reg)]);
}

} // namespace NativeABI

} // namespace tc
} // namespace vb

#endif
