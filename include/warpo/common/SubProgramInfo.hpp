// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <cassert>
#include <cstdint>
#include <optional>
#include <string_view>
#include <utility>
#include <vector>

#include "BlockInfo.hpp"
#include "ParameterInfo.hpp"

namespace warpo {

class SubProgramInfo final : public ScopeInfo {
public:
  explicit inline SubProgramInfo(std::string_view const name, std::string_view const sourcePath,
                                 uint32_t const startLine, uint32_t const endLine,
                                 std::optional<std::string_view> const outerFunction = std::nullopt) noexcept
      : ScopeInfo(Kind::SubProgram), name_(name), sourcePath_(sourcePath), startLine_(startLine), endLine_(endLine),
        outerFunction_(outerFunction), heapVariableStorageLocalIndex_{std::nullopt} {}

  inline std::string_view getName() const noexcept { return name_; }
  inline std::string_view getSourcePath() const noexcept { return sourcePath_; }
  inline uint32_t getStartLine() const noexcept { return startLine_; }
  inline uint32_t getEndLine() const noexcept { return endLine_; }
  inline bool hasSourceRange() const noexcept { return !sourcePath_.empty() && (startLine_ != 0U || endLine_ != 0U); }
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
  std::string_view sourcePath_;
  uint32_t startLine_;
  uint32_t endLine_;
  std::optional<std::string_view> outerFunction_;
  std::vector<ParameterInfo> parameters_;
  std::optional<uint32_t> heapVariableStorageLocalIndex_;
};

} // namespace warpo
