// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <fmt/base.h>
#include <memory>

#include "ObjLivenessAnalyzer.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

struct InsertPositionHint {
  wasm::Expression *prologue = nullptr; ///< nullable
  wasm::Expression *epilogue = nullptr; ///< nullable
};

using InsertPositionHints = std::map<wasm::Function *, InsertPositionHint>;

struct ShrinkWrapAnalysis : public wasm::Pass {
  static InsertPositionHints createResults(wasm::Module *m) {
    InsertPositionHints ret{};
    for (std::unique_ptr<wasm::Function> const &f : m->functions) {
      ret.insert_or_assign(f.get(), InsertPositionHint{});
    }
    return ret;
  }
  std::shared_ptr<InsertPositionHints> insertPositionHints_;
  std::shared_ptr<ObjLivenessInfo const> livenessInfo_;
  explicit ShrinkWrapAnalysis(std::shared_ptr<InsertPositionHints> const &insertPositionHints,
                              std::shared_ptr<ObjLivenessInfo const> const &livenessInfo)
      : insertPositionHints_{insertPositionHints}, livenessInfo_{livenessInfo} {
    name = "ShrinkWrapperAnalysis";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override {
    return std::make_unique<ShrinkWrapAnalysis>(insertPositionHints_, livenessInfo_);
  }
  bool modifiesBinaryenIR() override { return false; }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override;

  static std::shared_ptr<InsertPositionHints> addToPass(wasm::PassRunner &runner,
                                                        std::shared_ptr<ObjLivenessInfo const> const &livenessInfo) {
    auto shadowStackPoints = std::make_shared<InsertPositionHints>(createResults(runner.wasm));
    runner.add(std::unique_ptr<wasm::Pass>(new ShrinkWrapAnalysis(shadowStackPoints, livenessInfo)));
    return shadowStackPoints;
  }
  static std::shared_ptr<InsertPositionHints> dummy(wasm::PassRunner &runner) {
    return std::make_shared<InsertPositionHints>(createResults(runner.wasm));
  }
};

} // namespace warpo::passes::gc
