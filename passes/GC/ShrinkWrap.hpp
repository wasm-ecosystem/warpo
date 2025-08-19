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

struct StackInsertPoint {
  wasm::Expression *prologue = nullptr; ///< nullable
  wasm::Expression *epilogue = nullptr; ///< nullable
};

using StackInsertPoints = std::map<wasm::Function *, StackInsertPoint>;

struct ShrinkWrapAnalysis : public wasm::Pass {
  static StackInsertPoints createResults(wasm::Module *m) {
    StackInsertPoints ret{};
    for (std::unique_ptr<wasm::Function> const &f : m->functions) {
      ret.insert_or_assign(f.get(), StackInsertPoint{});
    }
    return ret;
  }
  std::shared_ptr<StackInsertPoints> shadowStackPoints_;
  std::shared_ptr<ObjLivenessInfo const> livenessInfo_;
  explicit ShrinkWrapAnalysis(std::shared_ptr<StackInsertPoints> const &shadowStackPoints,
                              std::shared_ptr<ObjLivenessInfo const> const &livenessInfo)
      : shadowStackPoints_{shadowStackPoints}, livenessInfo_{livenessInfo} {
    name = "ShrinkWrapperAnalysis";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override {
    return std::make_unique<ShrinkWrapAnalysis>(shadowStackPoints_, livenessInfo_);
  }
  bool modifiesBinaryenIR() override { return false; }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override;

  static std::shared_ptr<StackInsertPoints> addToPass(wasm::PassRunner &runner,
                                                      std::shared_ptr<ObjLivenessInfo const> const &livenessInfo) {
    auto shadowStackPoints = std::make_shared<StackInsertPoints>(createResults(runner.wasm));
    runner.add(std::unique_ptr<wasm::Pass>(new ShrinkWrapAnalysis(shadowStackPoints, livenessInfo)));
    return shadowStackPoints;
  }
};

} // namespace warpo::passes::gc
