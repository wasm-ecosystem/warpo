// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <set>
#include <string_view>

namespace warpo {

class VariableInfo;

class MemoryExposure final {
public:
  using TypeRegistry = std::set<std::string_view>;

  void addType(std::string_view typeName);
  void finalize(VariableInfo const &variableInfo);

  TypeRegistry const &getTypes() const noexcept { return types_; }

private:
  TypeRegistry seedTypes_;
  TypeRegistry types_;
};

} // namespace warpo