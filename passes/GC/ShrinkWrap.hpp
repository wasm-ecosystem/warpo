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

struct ShrinkWrapAnalysis : public wasm::Pass {
  StackPositions const &stackPositions_;
  explicit ShrinkWrapAnalysis(StackPositions const &stackPositions) : stackPositions_{stackPositions} {
    name = "ShrinkWrapperAnalysis";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<ShrinkWrapAnalysis>(stackPositions_); }
  bool modifiesBinaryenIR() override { return false; }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override;
};

} // namespace warpo::passes::gc
