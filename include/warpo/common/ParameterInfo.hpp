// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <cstdint>
#include <string>
#include <string_view>
#include <utility>
#include <variant>

#include "LocalInfo.hpp"

namespace warpo {

class ParameterInfo final {
public:
  inline ParameterInfo(std::string name, std::string_view const type, uint32_t const index,
                       bool const nullable) noexcept
      : name_(std::move(name)), type_(type), location_(LocalIndexLocation{index}), nullable_(nullable) {}

  inline ParameterInfo(std::string name, std::string_view const type, VariableLocation location,
                       bool const nullable) noexcept
      : name_(std::move(name)), type_(type), location_(location), nullable_(nullable) {}

  inline std::string_view getName() const noexcept { return name_; }
  inline std::string_view getType() const noexcept { return type_; }
  inline VariableLocation const &getLocation() const noexcept { return location_; }
  inline bool isNullable() const noexcept { return nullable_; }

private:
  std::string name_;
  std::string_view type_;
  VariableLocation location_;
  bool nullable_;
};

} // namespace warpo
