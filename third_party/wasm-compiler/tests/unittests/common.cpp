#include "common.hpp"

#if !LINEAR_MEMORY_BOUNDS_CHECKS
#include "src/utils/LinearMemoryAllocator.hpp"
#endif

namespace vb {
namespace test {

Runtime createRuntime(ExecutableMemory const &executableMemory) {
#if LINEAR_MEMORY_BOUNDS_CHECKS
  return Runtime{executableMemory,
                 [](vb::ExtendableMemory &currentObject, uint32_t minimumLength, void *const ctx) {
                   static_cast<void>(ctx);
                   if (minimumLength == 0) {
                     free(currentObject.data());
                   } else {
                     minimumLength = std::max(minimumLength, static_cast<uint32_t>(1000U)) * 2U;
                     currentObject.reset(vb::pCast<uint8_t *>(realloc(currentObject.data(), minimumLength)), minimumLength);
                   }
                 },
                 nullptr};
#else
  static LinearMemoryAllocator linearMemoryAllocator;
  return Runtime{executableMemory, linearMemoryAllocator, nullptr};
#endif
}

} // namespace test
} // namespace vb
