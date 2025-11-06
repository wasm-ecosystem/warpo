///
/// @file LocalInfo.hpp
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
#pragma once

#include <cstdint>
#include <string>
#include <string_view>
#include <utility>

#include "TypeNameHelper.hpp"

namespace warpo {

class LocalInfo final {
public:
  inline LocalInfo(std::string name, std::string_view const type, uint32_t const index, uint32_t const start,
                   uint32_t const end, bool const nullable) noexcept
      : name_(std::move(name)), type_(type), index_(index), start_(start), end_(end), nullable_(nullable) {}

  inline std::string_view getName() const noexcept { return name_; }
  inline std::string_view getType() const noexcept { return type_; }
  inline uint32_t getIndex() const noexcept { return index_; }
  inline uint32_t getStart() const noexcept { return start_; }
  inline uint32_t getEnd() const noexcept { return end_; }
  inline bool isNullable() const noexcept { return nullable_; }

private:
  std::string name_;
  std::string_view type_;
  uint32_t index_;
  uint32_t start_;
  uint32_t end_;
  bool nullable_;
};

} // namespace warpo
