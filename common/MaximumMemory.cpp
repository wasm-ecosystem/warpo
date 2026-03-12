// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cctype>
#include <fmt/format.h>
#include <limits>
#include <stdexcept>

#include "warpo/common/MaximumMemory.hpp"

namespace warpo::common {

namespace {

uint64_t parseMaximumMemoryAsBytes(std::string const &rawValue) {
  auto const begin = rawValue.find_first_not_of(" \t\n\r");
  if (begin == std::string::npos)
    throw std::runtime_error{"maximumMemory cannot be empty"};

  auto const end = rawValue.find_last_not_of(" \t\n\r");
  std::string const value = rawValue.substr(begin, end - begin + 1);

  size_t numberEnd = 0;
  while (numberEnd < value.size() && std::isdigit(static_cast<unsigned char>(value[numberEnd])) != 0)
    ++numberEnd;
  if (numberEnd == 0)
    throw std::runtime_error{fmt::format("Invalid maximumMemory value: {}", rawValue)};

  uint64_t amount = 0;
  try {
    amount = std::stoull(value.substr(0, numberEnd));
  } catch (std::exception const &) {
    throw std::runtime_error{fmt::format("Invalid maximumMemory value: {}", rawValue)};
  }

  std::string unit;
  unit.reserve(value.size() - numberEnd);
  for (size_t i = numberEnd; i < value.size(); ++i) {
    char const c = value[i];
    if (std::isspace(static_cast<unsigned char>(c)) != 0)
      continue;
    unit.push_back(static_cast<char>(std::tolower(static_cast<unsigned char>(c))));
  }

  auto multiply = [amount, rawValue](uint64_t factor) -> uint64_t {
    if (amount > std::numeric_limits<uint64_t>::max() / factor)
      throw std::runtime_error{fmt::format("maximumMemory is too large: {}", rawValue)};
    return amount * factor;
  };

  if (unit.empty() || unit == "b" || unit == "byte" || unit == "bytes")
    return amount;
  if (unit == "k" || unit == "kb" || unit == "kib")
    return multiply(1024ULL);
  if (unit == "m" || unit == "mb" || unit == "mib")
    return multiply(1024ULL * 1024ULL);
  if (unit == "g" || unit == "gb" || unit == "gib")
    return multiply(1024ULL * 1024ULL * 1024ULL);
  if (unit == "p" || unit == "page" || unit == "pages")
    return multiply(65536ULL);

  throw std::runtime_error{fmt::format("Unsupported maximumMemory unit: {}", rawValue)};
}

} // namespace

MaximumMemory MaximumMemory::parse(std::string const &rawValue) {
  return MaximumMemory{parseMaximumMemoryAsBytes(rawValue)};
}

std::optional<uint32_t> MaximumMemory::toMaximumMemoryOption() const {
  constexpr uint64_t wasmPageSize = 65536ULL;
  if (bytes_ < wasmPageSize)
    return std::nullopt;

  if (bytes_ % wasmPageSize != 0)
    throw std::runtime_error{"maximumMemory must be a multiple of WebAssembly page size"};

  uint64_t const pages = bytes_ / wasmPageSize;
  if (pages > std::numeric_limits<uint32_t>::max())
    throw std::runtime_error{"maximumMemory is out of range"};
  return static_cast<uint32_t>(pages);
}

std::optional<uint32_t> MaximumMemory::toLowMemoryLimitOption() const {
  constexpr uint64_t wasmPageSize = 65536ULL;
  if (bytes_ >= wasmPageSize)
    return std::nullopt;
  if (bytes_ > std::numeric_limits<uint32_t>::max())
    throw std::runtime_error{"maximumMemory is out of range"};
  return static_cast<uint32_t>(bytes_);
}

} // namespace warpo::common

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

namespace warpo::common::ut {

TEST(MaximumMemoryTest, ParseAsBytesAndLowMemoryLimit) {
  MaximumMemory const parsed = MaximumMemory::parse("65535");
  ASSERT_TRUE(parsed.toLowMemoryLimitOption().has_value());
  EXPECT_EQ(parsed.toLowMemoryLimitOption().value(), 65535U);
  EXPECT_FALSE(parsed.toMaximumMemoryOption().has_value());
}

TEST(MaximumMemoryTest, ParseAsPages) {
  MaximumMemory const parsed = MaximumMemory::parse("2pages");
  ASSERT_TRUE(parsed.toMaximumMemoryOption().has_value());
  EXPECT_EQ(parsed.toMaximumMemoryOption().value(), 2U);
  EXPECT_FALSE(parsed.toLowMemoryLimitOption().has_value());
}

TEST(MaximumMemoryTest, ParseWithUnifiedUnits) {
  MaximumMemory const kb = MaximumMemory::parse("64kb");
  MaximumMemory const kib = MaximumMemory::parse("64kib");
  ASSERT_TRUE(kb.toMaximumMemoryOption().has_value());
  ASSERT_TRUE(kib.toMaximumMemoryOption().has_value());
  EXPECT_EQ(kb.toMaximumMemoryOption().value(), kib.toMaximumMemoryOption().value());
}

TEST(MaximumMemoryTest, ParseInvalidValueThrows) {
  EXPECT_THROW((void)MaximumMemory::parse("abc"), std::runtime_error);
  EXPECT_THROW((void)MaximumMemory::parse("12xyz"), std::runtime_error);
}

TEST(MaximumMemoryTest, ParseMaximumMemoryRequiresFullPageMultiple) {
  MaximumMemory const parsed = MaximumMemory::parse("65537");
  EXPECT_THROW((void)parsed.toMaximumMemoryOption(), std::runtime_error);
}

} // namespace warpo::common::ut

#endif
