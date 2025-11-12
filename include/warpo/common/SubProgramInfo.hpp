///
/// @file SubProgramInfo.hpp
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
#include <vector>

#include "LocalInfo.hpp"
#include "TypeNameHelper.hpp"

namespace warpo {

class SubProgramInfo final {
public:
  explicit inline SubProgramInfo(std::string_view const name) noexcept : name_(name) {}

  inline std::string_view getName() const noexcept { return name_; }

  inline std::vector<LocalInfo> const &getParameters() const noexcept { return parameters_; }
  inline std::vector<LocalInfo> const &getLocals() const noexcept { return locals_; }

  inline void addParameter(LocalInfo parameter) noexcept { parameters_.push_back(std::move(parameter)); }
  inline void addLocal(LocalInfo local) noexcept { locals_.push_back(std::move(local)); }

  void addParameter(std::string variableName, std::string_view const typeName, uint32_t const index,
                    bool const nullable);

  void addLocal(std::string variableName, std::string_view const typeName, uint32_t const index, uint32_t const start,
                uint32_t const end, bool const nullable);

private:
  std::string_view name_;
  std::vector<LocalInfo> parameters_;
  std::vector<LocalInfo> locals_;
};

} // namespace warpo
