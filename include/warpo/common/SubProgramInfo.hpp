// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <cassert>
#include <optional>
#include <string_view>
#include <utility>
#include <vector>

#include "BlockInfo.hpp"
#include "ParameterInfo.hpp"

namespace warpo {

class SubProgramInfo final : public ScopeInfo {
public:
  explicit inline SubProgramInfo(std::string_view const name,
                                 std::optional<std::string_view> const outerFunction = std::nullopt) noexcept
      : ScopeInfo(Kind::SubProgram), name_(name), outerFunction_(outerFunction),
        heapVariableStorageLocalIndex_{std::nullopt} {}

  inline std::string_view getName() const noexcept { return name_; }
  inline std::optional<std::string_view> getOuterFunction() const noexcept { return outerFunction_; }

  inline std::vector<ParameterInfo> const &getParameters() const noexcept { return parameters_; }

  inline void addParameter(ParameterInfo parameter) noexcept { parameters_.push_back(std::move(parameter)); }

  void addParameter(std::string variableName, std::string_view const typeName, uint32_t const index,
                    bool const nullable);

  void addTupleParameter(std::string variableName, std::string_view const typeName, uint32_t const tupleFieldOffset,
                         uint32_t const storageLocalIndex, bool const nullable);

  inline std::optional<uint32_t> getHeapVariableStorageLocalIndex() const noexcept {
    return heapVariableStorageLocalIndex_;
  }
  inline void setHeapVariableStorageLocalIndex(uint32_t index) noexcept { heapVariableStorageLocalIndex_ = index; }

  static bool classof(ScopeInfo const *s) noexcept { return s->getKind() == Kind::SubProgram; }

private:
  std::string_view name_;
  std::optional<std::string_view> outerFunction_;
  std::vector<ParameterInfo> parameters_;
  std::optional<uint32_t> heapVariableStorageLocalIndex_;
};

} // namespace warpo
