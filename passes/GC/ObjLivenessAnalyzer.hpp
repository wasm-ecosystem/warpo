#pragma once

#include <cstddef>

#include "Liveness.hpp"
#include "SSAObj.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

using ObjLivenessInfo = std::map<wasm::Function *, LivenessMap>;
struct ObjLivenessAnalyzer : public wasm::Pass {
  static ObjLivenessInfo createResults(wasm::Module *m) {
    ObjLivenessInfo ret{};
    for (std::unique_ptr<wasm::Function> const &f : m->functions) {
      ret.insert_or_assign(f.get(), LivenessMap{});
    }
    return ret;
  }
  ObjLivenessInfo &info_;
  ModuleLevelSSAMap const &moduleLevelSSAMap_;
  explicit ObjLivenessAnalyzer(ModuleLevelSSAMap const &moduleLevelSSAMap, ObjLivenessInfo &info)
      : moduleLevelSSAMap_(moduleLevelSSAMap), info_(info) {
    name = "ObjLivenessAnalyzer";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<ObjLivenessAnalyzer>(moduleLevelSSAMap_, info_); }
  bool modifiesBinaryenIR() override { return false; }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override;
};

} // namespace warpo::passes::gc
