// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "ObjLivenessAnalyzer.hpp"
#include "SSAObj.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

/// @brief remove item in liveness which does not involve GC non leaf function
struct MergeSSA : public wasm::Pass {
  ModuleLevelSSAMap const &moduleLevelSSAMap_;
  std::shared_ptr<ObjLivenessInfo> info_;

  explicit MergeSSA(ModuleLevelSSAMap const &moduleLevelSSAMap, std::shared_ptr<ObjLivenessInfo> const &info)
      : moduleLevelSSAMap_(moduleLevelSSAMap), info_(info) {
    name = "MergeSSA";
  }
  bool modifiesBinaryenIR() override { return false; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<MergeSSA>(moduleLevelSSAMap_, info_); }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override;

  static void addToPass(wasm::PassRunner &runner, ModuleLevelSSAMap const &moduleLevelSSAMap,
                        std::shared_ptr<ObjLivenessInfo> const &info) {
    runner.add(std::unique_ptr<wasm::Pass>(new MergeSSA(moduleLevelSSAMap, info)));
  }
};

} // namespace warpo::passes::gc
