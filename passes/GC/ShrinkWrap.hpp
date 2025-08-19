#pragma once

#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <fmt/base.h>
#include <memory>

#include "StackAssigner.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

struct ShadowStackInsertPoint {
  wasm::Expression *prologue = nullptr; ///< nullable
  wasm::Expression *epilogue = nullptr;
};

using ShadowStackInsertPoints = std::map<wasm::Function *, ShadowStackInsertPoint>;

struct ShrinkWrapAnalysis : public wasm::Pass {
  static ShadowStackInsertPoints createResults(wasm::Module *m) {
    ShadowStackInsertPoints ret{};
    for (std::unique_ptr<wasm::Function> const &f : m->functions) {
      ret.insert_or_assign(f.get(), ShadowStackInsertPoint{});
    }
    return ret;
  }
  std::shared_ptr<ShadowStackInsertPoints> shadowStackPoints_;
  std::shared_ptr<StackPositions const> stackPositions_;
  explicit ShrinkWrapAnalysis(std::shared_ptr<ShadowStackInsertPoints> const &shadowStackPoints,
                              std::shared_ptr<StackPositions const> const &stackPositions)
      : shadowStackPoints_{shadowStackPoints}, stackPositions_{stackPositions} {
    name = "ShrinkWrapperAnalysis";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override {
    return std::make_unique<ShrinkWrapAnalysis>(shadowStackPoints_, stackPositions_);
  }
  bool modifiesBinaryenIR() override { return false; }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override;

  static std::shared_ptr<ShadowStackInsertPoints>
  addToPass(wasm::PassRunner &runner, std::shared_ptr<StackPositions const> const &stackPositions) {
    auto shadowStackPoints = std::make_shared<ShadowStackInsertPoints>(createResults(runner.wasm));
    runner.add(std::unique_ptr<wasm::Pass>(new ShrinkWrapAnalysis(shadowStackPoints, stackPositions)));
    return shadowStackPoints;
  }
};

} // namespace warpo::passes::gc
