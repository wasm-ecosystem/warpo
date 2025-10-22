///
/// @file StringPool.cpp
/// @copyright Copyright (C) 2025 wasm-ecosystem
/// SPDX-License-Identifier: Apache-2.0
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
#include <cstdint>
#include <sstream>
#include <string>

#include "warpo/support/StringPool.hpp"

namespace warpo {

std::string_view StringPool::internString(std::string_view str) {
  PoolType::const_iterator const it = pool_.find(str);
  if (it != pool_.end()) {
    return *it->second;
  }
  std::unique_ptr<std::string> newStr = std::make_unique<std::string>(str);
  std::string_view const result = *newStr;
  pool_[result] = std::move(newStr);
  return result;
}

} // namespace warpo

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

namespace warpo::ut {

TEST(TestStringPool, testAddString) {
  StringPool pool;
  std::string_view const str1 = pool.internString("hello");
  std::string_view const str2 = pool.internString("world");
  std::string_view const str3 = pool.internString("hello");

  EXPECT_EQ(str1, "hello");
  EXPECT_EQ(str2, "world");
  EXPECT_EQ(str1, str3);
  EXPECT_EQ(str1.data(), str3.data()); // same address
  EXPECT_NE(str1.data(), str2.data()); // different address
}

} // namespace warpo::ut

#endif
