// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <cstdint>
#include <string>
#include <string_view>
#include <utility>

namespace warpo {

class ParameterInfo final {
public:
  inline ParameterInfo(std::string name, std::string_view const type, uint32_t const index,
                       bool const nullable) noexcept
      : name_(std::move(name)), type_(type), index_(index), nullable_(nullable) {}

  inline std::string_view getName() const noexcept { return name_; }
  inline std::string_view getType() const noexcept { return type_; }
  inline uint32_t getIndex() const noexcept { return index_; }
  inline bool isNullable() const noexcept { return nullable_; }

private:
  std::string name_;
  std::string_view type_;
  uint32_t index_;
  bool nullable_;
};

} // namespace warpo
