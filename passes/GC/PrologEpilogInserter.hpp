// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cassert>
#include <fmt/base.h>
#include <fmt/format.h>
#include <map>
#include <memory>
#include <optional>

#include "ShrinkWrap.hpp"
#include "StackAssigner.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

struct IMaxShadowStackOffsets {
  virtual ~IMaxShadowStackOffsets() = default;
  virtual uint32_t at(wasm::Function *func) const = 0;
};

class MaxShadowStackOffsetsFromStackPositions : public IMaxShadowStackOffsets {
  std::shared_ptr<StackPositions const> stackPositions_;
  uint32_t at(wasm::Function *func) const override;
  explicit MaxShadowStackOffsetsFromStackPositions(std::shared_ptr<StackPositions const> stackPositions)
      : stackPositions_(std::move(stackPositions)) {}

public:
  static std::shared_ptr<MaxShadowStackOffsetsFromStackPositions>
  create(std::shared_ptr<StackPositions const> const &stackPositions) {
    return std::shared_ptr<MaxShadowStackOffsetsFromStackPositions>{
        new MaxShadowStackOffsetsFromStackPositions(stackPositions)};
  }
};

class MaxShadowStackOffsets : public IMaxShadowStackOffsets, std::map<wasm::Function *, uint32_t> {
  uint32_t at(wasm::Function *func) const override { return std::map<wasm::Function *, uint32_t>::at(func); }

public:
  using std::map<wasm::Function *, uint32_t>::operator[];
};

class PrologEpilogInserter : public wasm::Pass {
  std::shared_ptr<InsertPositionHints const> insertPositionHints_;
  std::shared_ptr<IMaxShadowStackOffsets const> maxShadowStackOffsets_;

  void replaceReturnExprWithEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                     std::optional<wasm::Index> const &scratchReturnValueLocalIndex);
  bool tryInsertPrologueAndEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                    std::optional<wasm::Index> const &scratchReturnValueLocalIndex,
                                    wasm::Expression *prologue, wasm::Expression *epilogue);
  bool tryInsertPrologue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                         std::optional<wasm::Index> const &scratchReturnValueLocalIndex, wasm::Expression *prologue);
  void insertDefaultPrologueAndEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                        std::optional<wasm::Index> const &scratchReturnValueLocalIndex);
  void insertDefaultEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                             std::optional<wasm::Index> const &scratchReturnValueLocalIndex);

public:
  explicit PrologEpilogInserter(std::shared_ptr<gc::InsertPositionHints const> insertPositionHints,
                                std::shared_ptr<IMaxShadowStackOffsets const> maxShadowStackOffsets)
      : insertPositionHints_(insertPositionHints), maxShadowStackOffsets_(maxShadowStackOffsets) {
    assert(maxShadowStackOffsets_ != nullptr);
    name = "PrologEpilogInserter";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override {
    return std::unique_ptr<Pass>{new PrologEpilogInserter(insertPositionHints_, maxShadowStackOffsets_)};
  }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override;
};

} // namespace warpo::passes::gc
