// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <cstdint>
#include <string>
#include <string_view>
#include <utility>

namespace warpo {

class FieldInfo final {
public:
  inline FieldInfo(std::string name, std::string_view const type, uint32_t const offsetInClass, bool const nullable,
                   bool const redeclared) noexcept
      : name_(std::move(name)), type_(type), offsetInClass_(offsetInClass), nullable_(nullable),
        redeclared_(redeclared) {}

  inline std::string_view getName() const noexcept { return name_; }
  inline std::string_view getType() const noexcept { return type_; }
  inline uint32_t getOffsetInClass() const noexcept { return offsetInClass_; }
  inline bool isNullable() const noexcept { return nullable_; }
  inline bool isRedeclared() const noexcept { return redeclared_; }

private:
  std::string name_;
  std::string_view type_;
  uint32_t offsetInClass_;
  bool nullable_;
  bool redeclared_;
};

} // namespace warpo
