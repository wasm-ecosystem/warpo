#pragma once

#include "CollectLeafFunction.hpp"
#include "ObjLivenessAnalyzer.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

/// @brief remove item in liveness which does not involve GC non leaf function
struct LeafFunctionFilter : public wasm::Pass {
  LeafFunc const &leaf_;
  ObjLivenessInfo &info_;

  explicit LeafFunctionFilter(LeafFunc const &leaf, ObjLivenessInfo &info) : leaf_(leaf), info_(info) {
    name = "LeafFunctionFilter";
  }
  bool modifiesBinaryenIR() override { return false; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<LeafFunctionFilter>(leaf_, info_); }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override;
};

} // namespace warpo::passes::gc
