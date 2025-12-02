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
#include <map>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>
#include <vector>

#include "LocalInfo.hpp"
#include "ParameterInfo.hpp"
#include "ScopeInfo.hpp"
#include "TypeNameHelper.hpp"
#include "binaryen-c.h"

namespace warpo {

class SubProgramInfo final {
public:
  using ScopeId = uint32_t;
  using ScopeInfoMap = std::unordered_map<ScopeId, ScopeInfo>;
  using LocalsMap = std::map<ScopeId, std::vector<LocalInfo>>;

  explicit inline SubProgramInfo(std::string_view const name) noexcept : name_(name) {}

  inline std::string_view getName() const noexcept { return name_; }

  inline std::vector<ParameterInfo> const &getParameters() const noexcept { return parameters_; }
  inline LocalsMap const &getLocals() const noexcept { return locals_; }
  inline ScopeInfoMap const &getScopeInfoMap() const noexcept { return scopeInfoMap_; }

  inline void addParameter(ParameterInfo parameter) noexcept { parameters_.push_back(std::move(parameter)); }
  inline void addLocal(LocalInfo local) noexcept {
    ScopeId const scopeId = local.getScopeId();
    locals_[scopeId].push_back(std::move(local));
  }

  void addParameter(std::string variableName, std::string_view const typeName, uint32_t const index,
                    bool const nullable);

  void addLocal(std::string variableName, std::string_view const typeName, uint32_t const index, ScopeId const scopeId,
                bool const nullable);

  uint32_t addScope(BinaryenExpressionRef const startExpr, BinaryenExpressionRef const endExpr);

private:
  std::string_view name_;
  std::vector<ParameterInfo> parameters_;
  LocalsMap locals_;
  ScopeInfoMap scopeInfoMap_;
  ScopeId nextScopeId_ = 0;
};

} // namespace warpo
