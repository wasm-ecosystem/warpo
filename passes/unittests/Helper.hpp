#pragma once

#include <gtest/gtest.h>
#include <sstream>

#define EXPECT_MATCHER(matcher, expr) EXPECT_TRUE(::warpo::passes::ut::checkMatcher(matcher, expr))

namespace warpo::passes::ut {

template <class T, class E> testing::AssertionResult checkMatcher(T matcher, E *expr) {
  if (matcher(*expr)) {
    return testing::AssertionSuccess();
  } else {
    std::stringstream ss{};
    ss << *expr;
    return testing::AssertionFailure() << " expr:\n" << ss.str() << "\n";
  }
}

} // namespace warpo::passes::ut
