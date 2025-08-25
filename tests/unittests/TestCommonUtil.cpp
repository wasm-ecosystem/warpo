#include <gtest/gtest.h>

#include "src/core/common/util.hpp"

namespace vb {

// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-special-member-functions)
TEST(TestCommonUtil, testCLZ) {
  uint64_t constexpr num1 = 0xFFU;
  uint32_t constexpr num2 = 0xFFFU;

  ASSERT_EQ(clzImpl(num1), clzll(num1));
  ASSERT_EQ(clzImpl(num2), clz(num2));
}
} // namespace vb
