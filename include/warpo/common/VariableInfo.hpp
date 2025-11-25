///
/// @file VariableInfo.hpp
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
#include <set>
#include <string>
#include <string_view>
#include <unordered_map>

#include "ClassInfo.hpp"
#include "SubProgramInfo.hpp"
#include "SubProgramRegistry.hpp"

namespace warpo {

class VariableInfo final {
public:
  using BaseTypeRegistry = std::set<std::string_view>;
  using ClassRegistry = std::map<std::string_view, ClassInfo>;
  struct GlobalTypeInfo {
    std::string_view typeName;
    bool nullable;
  };

  struct ScopeInfo final {
    BinaryenExpressionRef startExpr;
    BinaryenExpressionRef endExpr;

    BinaryenExpressionRef getStartExpr() const noexcept { return startExpr; }
    BinaryenExpressionRef getEndExpr() const noexcept { return endExpr; }
  };

  using ScopeInfoMap = std::unordered_map<uint32_t, ScopeInfo>;
  using GlobalTypes = std::map<std::string, GlobalTypeInfo>;

  void createBaseType(std::string_view typeName);
  void createClass(std::string_view className, std::string parentName, uint32_t const rtid);

  void addField(std::string_view const className, std::string fieldName, std::string typeName, uint32_t const offset,
                uint32_t const nullable);

  void addTemplateType(std::string_view const className, std::string_view const templateTypeName);

  void addGlobalType(std::string variableName, std::string_view const typeName, uint32_t const nullable);

  BaseTypeRegistry const &getBaseTypeRegistry() const noexcept { return baseTypeRegistry_; }
  ClassRegistry const &getClassRegistry() const noexcept { return classRegistry_; }

  GlobalTypes const &getGlobalTypes() const noexcept { return globalTypes_; }

  SubProgramRegistry const &getSubProgramRegistry() const noexcept { return subProgramRegistry_; }

  ScopeInfoMap const &getScopeInfoMap() const noexcept { return scopeInfoMap_; }

  void addSubProgram(std::string subProgramName, std::string_view const belongClassName);

  void addParameter(std::string_view const subProgramName, std::string variableName, std::string_view const typeName,
                    uint32_t const index, bool const nullable);

  uint32_t addScope(BinaryenExpressionRef const startExpr, BinaryenExpressionRef const endExpr);

  void addLocal(std::string_view const subProgramName, std::string variableName, std::string_view const typeName,
                uint32_t const index, uint32_t const scopeId, bool const nullable);

private:
  using SubProgramLookupMap = std::unordered_map<std::string_view, SubProgramInfo &>;
  BaseTypeRegistry baseTypeRegistry_;
  ClassRegistry classRegistry_;
  GlobalTypes globalTypes_;
  StringPool stringPool_;
  SubProgramRegistry subProgramRegistry_;
  SubProgramLookupMap subProgramLookupMap_;
  ScopeInfoMap scopeInfoMap_;
  uint32_t nextScopeId_ = 0;
};

} // namespace warpo
