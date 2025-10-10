// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstddef>
#include <memory>

#include "Liveness.hpp"
#include "SSAObj.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

using ObjLivenessInfo = std::map<wasm::Function *, LivenessMap>;

/// @brief analyze the liveness of SSAified GC objects in a function
struct ObjLivenessAnalyzer : public wasm::Pass {
  static ObjLivenessInfo createResults(wasm::Module *m) {
    ObjLivenessInfo ret{};
    for (std::unique_ptr<wasm::Function> const &f : m->functions) {
      ret.insert_or_assign(f.get(), LivenessMap{});
    }
    return ret;
  }

  ModuleLevelSSAMap const &moduleLevelSSAMap_;
  std::shared_ptr<ObjLivenessInfo> info_;
  explicit ObjLivenessAnalyzer(ModuleLevelSSAMap const &moduleLevelSSAMap, std::shared_ptr<ObjLivenessInfo> const &info)
      : moduleLevelSSAMap_(moduleLevelSSAMap), info_(info) {
    name = "ObjLivenessAnalyzer";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<ObjLivenessAnalyzer>(moduleLevelSSAMap_, info_); }
  bool modifiesBinaryenIR() override { return false; }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override;

  static std::shared_ptr<ObjLivenessInfo> addToPass(wasm::PassRunner &runner,
                                                    ModuleLevelSSAMap const &moduleLevelSSAMap) {
    auto info = std::make_shared<ObjLivenessInfo>(createResults(runner.wasm));
    runner.add(std::unique_ptr<wasm::Pass>(new ObjLivenessAnalyzer(moduleLevelSSAMap, info)));
    return info;
  }
};

} // namespace warpo::passes::gc
