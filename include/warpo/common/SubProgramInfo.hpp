// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <cassert>
#include <map>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>
#include <vector>

#include "LocalInfo.hpp"
#include "ParameterInfo.hpp"
#include "binaryen-c.h"

namespace warpo {

class BlockInfo {
public:
  inline BlockInfo(uint32_t const startLine, uint32_t const endLine) noexcept
      : startLine_(startLine), endLine_(endLine) {}

  void pushChild(std::unique_ptr<BlockInfo> &&child) noexcept { children_.push_back(std::move(child)); }
  inline void addLocal(LocalInfo local) noexcept { locals_.push_back(std::move(local)); }

  inline uint32_t getStartLine() const noexcept { return startLine_; }
  inline uint32_t getEndLine() const noexcept { return endLine_; }
  inline std::vector<std::unique_ptr<BlockInfo>> const &getChildren() const noexcept { return children_; }
  inline std::vector<LocalInfo> const &getLocals() const noexcept { return locals_; }

private:
  uint32_t startLine_;
  uint32_t endLine_;
  std::vector<std::unique_ptr<BlockInfo>> children_;
  std::vector<LocalInfo> locals_;
};

class SubProgramInfo final {
public:
  explicit inline SubProgramInfo(std::string_view const name,
                                 std::optional<std::string_view> const outerFunction = std::nullopt,
                                 uint32_t const startLine = 0, uint32_t const endLine = 0) noexcept
      : name_(name), outerFunction_(outerFunction), heapVariableStorageLocalIndex_{std::nullopt},
        rootBlockInfo_{nullptr} {
    blockInfoStack_.push_back(std::make_unique<BlockInfo>(startLine, endLine));
  }

  inline std::string_view getName() const noexcept { return name_; }
  inline std::optional<std::string_view> getOuterFunction() const noexcept { return outerFunction_; }

  inline std::vector<ParameterInfo> const &getParameters() const noexcept { return parameters_; }

  inline void addParameter(ParameterInfo parameter) noexcept { parameters_.push_back(std::move(parameter)); }

  void addParameter(std::string variableName, std::string_view const typeName, uint32_t const index,
                    bool const nullable);

  void addLocal(std::string variableName, std::string_view const typeName, uint32_t const index, bool const nullable);

  void addTupleLocal(std::string variableName, std::string_view const typeName, uint32_t const tupleFieldOffset,
                     uint32_t const storageLocalIndex, bool const nullable);

  void addTupleParameter(std::string variableName, std::string_view const typeName, uint32_t const tupleFieldOffset,
                         uint32_t const storageLocalIndex, bool const nullable);

  inline std::optional<uint32_t> getHeapVariableStorageLocalIndex() const noexcept {
    return heapVariableStorageLocalIndex_;
  }
  inline void setHeapVariableStorageLocalIndex(uint32_t index) noexcept { heapVariableStorageLocalIndex_ = index; }

  void enterBlock(uint32_t const startLine, uint32_t const endLine);

  void leaveBlock();

  inline BlockInfo const *getRootBlockInfo() const noexcept {
    // LCOV_EXCL_START
    assert(rootBlockInfo_ != nullptr);
    // LCOV_EXCL_STOP
    return rootBlockInfo_.get();
  }

private:
  std::string_view name_;
  std::optional<std::string_view> outerFunction_;
  std::vector<ParameterInfo> parameters_;
  std::optional<uint32_t> heapVariableStorageLocalIndex_;
  std::unique_ptr<BlockInfo> rootBlockInfo_;
  std::vector<std::unique_ptr<BlockInfo>> blockInfoStack_;
};

} // namespace warpo
