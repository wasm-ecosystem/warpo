// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>
#include <optional>
#include <string>

namespace warpo::common {

class MaximumMemory final {
public:
  static MaximumMemory parse(std::string const &rawValue);

  explicit MaximumMemory(uint64_t bytes) : bytes_(bytes) {}

  inline uint64_t toBytes() const noexcept { return bytes_; }

  std::optional<uint32_t> toMaximumMemoryOption() const;
  std::optional<uint32_t> toLowMemoryLimitOption() const;

private:
  uint64_t bytes_;
};

} // namespace warpo::common
