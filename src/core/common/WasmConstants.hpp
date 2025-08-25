#ifndef WASMCONSTANTS_HPP
#define WASMCONSTANTS_HPP

#include <cstdint>

#include "src/core/common/util.hpp"
namespace vb {
/// @brief Wasm memory related constants
class WasmConstants final {
public:
  static constexpr uint32_t wasmPageSize{1_U32 << 16_U32};                                           ///< Wasm page size
  static constexpr uint32_t maxWasmPages{1_U32 << 16_U32};                                           ///< Max Wasm pages count
  static constexpr uint64_t maxLinearMemorySize{static_cast<uint64_t>(wasmPageSize) * maxWasmPages}; ///< Max linear memory size
  static constexpr uint64_t maxLinearMemoryOffset{1_U64 << 32_U64}; ///< Max Linear memory offset which can a wasm32 instruction access
};
} // namespace vb

#endif
