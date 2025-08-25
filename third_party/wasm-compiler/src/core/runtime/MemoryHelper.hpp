
#ifndef MEMORYHELPER_HPP
#define MEMORYHELPER_HPP

#include "src/core/compiler/common/util.hpp"

namespace vb {

///
/// @brief Helper class a WebAssembly module can use to request more memory at runtime
///
/// This is a class so it can be a friend for Runtime
///
// coverity[autosar_cpp14_m3_4_1_violation]
class MemoryHelper {
public:
#if LINEAR_MEMORY_BOUNDS_CHECKS
  ///
  /// @brief Requests extension of the job memory
  ///
  /// @param minLinMemLengthNeeded Minimum memory size needed
  /// @param basedataLength Size in bytes of the WebAssembly module's basedata
  /// @param originalLinMemBase Original base of the linear memory (points to the spot right after the basedata)
  /// @return uint8_t* Pointer to the base/start of the job memory (not linear memory!); can return nullptr if
  /// extension/reallocation failed
  static uint8_t *extensionRequest(uint64_t const minLinMemLengthNeeded, uint32_t const basedataLength,
                                   uint8_t *const originalLinMemBase) VB_NOEXCEPT;
#else
  ///
  /// @brief Notify the linear memory allocator that the formal linear memory size was grown
  ///
  /// @param originalLinMemBase Original base of the linear memory (points to the spot right after the basedata)
  /// @param newLinMemSizeInPages New linear memory size in WebAssembly pages (multiples of 64kB)
  /// @return bool Whether the extension/commit was successful
  static bool notifyOfMemoryGrowth(uint8_t *const originalLinMemBase, uint32_t const newLinMemSizeInPages) VB_NOEXCEPT;
#endif
};

} // namespace vb

#endif /* MEMORYHELPER_HPP */
