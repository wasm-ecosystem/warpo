#pragma once

#include <gtest/gtest.h>
#include <memory>
#include <sstream>
#include <string_view>

#include "wasm.h"

namespace warpo::passes::ut {

std::unique_ptr<wasm::Module> loadWat(std::string_view wat);

template <class T, class E> testing::AssertionResult checkMatcher(T matcher, E *expr) {
  if (matcher(*expr)) {
    return testing::AssertionSuccess();
  } else {
    std::stringstream ss{};
    ss << *expr;
    return testing::AssertionFailure() << " expr:\n" << ss.str() << "\n";
  }
}

#define EXPECT_MATCHER(matcher, expr) EXPECT_TRUE(::warpo::passes::ut::checkMatcher(matcher, expr))

} // namespace warpo::passes::ut
