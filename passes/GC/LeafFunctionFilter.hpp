#pragma once

#include "CollectLeafFunction.hpp"
#include "ObjLivenessAnalyzer.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

/// @brief remove item in liveness which does not involve GC non leaf function
struct LeafFunctionFilter : public wasm::Pass {
  std::shared_ptr<LeafFunc const> leaf_;
  std::shared_ptr<ObjLivenessInfo> info_;

  explicit LeafFunctionFilter(std::shared_ptr<LeafFunc const> const &leaf, std::shared_ptr<ObjLivenessInfo> const &info)
      : leaf_(leaf), info_(info) {
    name = "LeafFunctionFilter";
  }
  bool modifiesBinaryenIR() override { return false; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<LeafFunctionFilter>(leaf_, info_); }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override;

  static void addToPass(wasm::PassRunner &runner, std::shared_ptr<LeafFunc> const &leaf,
                        std::shared_ptr<ObjLivenessInfo> const &info) {
    runner.add(std::unique_ptr<wasm::Pass>(new LeafFunctionFilter(leaf, info)));
  }
};

} // namespace warpo::passes::gc
