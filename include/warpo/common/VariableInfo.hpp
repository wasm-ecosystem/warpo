// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

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
    bool isMutable;
  };

  using GlobalTypes = std::map<std::string, GlobalTypeInfo>;

  void createBaseType(std::string_view typeName);
  void createClass(std::string_view className, uint32_t const rtid);
  void createClass(std::string_view className);
  void addBaseClass(std::string_view const className, std::string const parentName);

  void addField(std::string_view const className, std::string fieldName, std::string typeName, uint32_t const offset,
                uint32_t const nullable);

  void addTemplateType(std::string_view const className, std::string_view const templateTypeName);

  void addGlobalType(std::string variableName, std::string_view const typeName, bool const nullable, bool isMutable);

  BaseTypeRegistry const &getBaseTypeRegistry() const noexcept { return baseTypeRegistry_; }
  ClassRegistry const &getClassRegistry() const noexcept { return classRegistry_; }

  GlobalTypes const &getGlobalTypes() const noexcept { return globalTypes_; }

  SubProgramRegistry const &getSubProgramRegistry() const noexcept { return subProgramRegistry_; }

  void addSubProgram(std::string subProgramName, std::string_view const belongClassName);

  void addParameter(std::string_view const subProgramName, std::string variableName, std::string_view const typeName,
                    uint32_t const index, bool const nullable);

  uint32_t addScope(std::string_view const subProgramName, BinaryenExpressionRef const startExpr,
                    BinaryenExpressionRef const endExpr);

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
};

} // namespace warpo
