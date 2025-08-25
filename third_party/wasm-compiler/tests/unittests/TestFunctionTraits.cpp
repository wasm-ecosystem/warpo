#include <cstdint>
#include <gtest/gtest.h>

#include "src/core/common/function_traits.hpp"

namespace vb {

enum class EM1 : uint32_t { AA };
enum class EM2 : uint64_t { AA };

uint32_t foo(EM1, EM2, void *);

// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-special-member-functions)
TEST(TestFunctionTraits, testEnumType) {
  const char *const typeStr = vb::function_traits<vb::remove_noexcept_t<decltype(foo)>>::getSignature();
  ASSERT_STREQ(typeStr, "(iI)i");
}
} // namespace vb
