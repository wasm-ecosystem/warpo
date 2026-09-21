// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <deque>
#include <set>
#include <string_view>
#include <vector>

namespace warpo {

class VariableInfo;

class MemoryExposure final {
public:
  using TypeRegistry = std::set<std::string_view>;

  void addType(std::string_view typeName);
  void finalize(VariableInfo const &variableInfo);

  TypeRegistry const &getTypes() const noexcept { return types_; }

private:
  using WorkList = std::deque<std::string_view>;

  void addToWorkList(WorkList &workList, std::string_view typeName);

  TypeRegistry types_;
};

} // namespace warpo