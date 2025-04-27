#pragma once

#include "ObjLivenessAnalyzer.hpp"
#include "SSAObj.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

/// @brief remove item in liveness which does not involve GC non leaf function
struct MergeSSA : public wasm::Pass {
  ObjLivenessInfo &info_;
  ModuleLevelSSAMap const &moduleLevelSSAMap_;

  explicit MergeSSA(ModuleLevelSSAMap const &moduleLevelSSAMap, ObjLivenessInfo &info)
      : moduleLevelSSAMap_(moduleLevelSSAMap), info_(info) {
    name = "MergeSSA";
  }
  bool modifiesBinaryenIR() override { return false; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<MergeSSA>(moduleLevelSSAMap_, info_); }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override;
};

} // namespace warpo::passes::gc
