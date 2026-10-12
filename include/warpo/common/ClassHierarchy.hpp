// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <string_view>
#include <vector>

#include "warpo/common/VariableInfo.hpp"

namespace warpo {

class ClassHierarchy final {
public:
  explicit ClassHierarchy(VariableInfo const &variableInfo) noexcept : variableInfo_{variableInfo} {}

  bool isAncestorOrSelf(std::string_view ancestor, std::string_view descendant) const noexcept;
  bool areRelatedClasses(std::string_view first, std::string_view second) const noexcept;
  std::vector<std::string_view> getAncestors(std::string_view className) const;
  std::vector<std::string_view> getDescendants(std::string_view className) const;

  std::string_view getParentClass(std::string_view className) const noexcept;
  std::vector<std::string_view> getDirectSubclasses(std::string_view className) const;
  std::vector<std::string_view> getImplementedInterfaces(std::string_view className) const;

  std::string_view getParentInterface(std::string_view interfaceName) const noexcept;
  std::vector<std::string_view> getDirectSubinterfaces(std::string_view interfaceName) const;
  std::vector<std::string_view> getDirectImplementers(std::string_view interfaceName) const;

  bool isClass(std::string_view typeName) const noexcept;
  bool isInterface(std::string_view typeName) const noexcept;

private:
  VariableInfo const &variableInfo_;
};

} // namespace warpo
