// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <memory>

#include "pass.h"
#include "warpo/common/VariableInfo.hpp"
#include "wasm.h"

namespace warpo::passes::gc {

// Remove tostack operations for non-mutable globals
// Replaces: (call $tmp_to_stack (global.get $non_mutable_global)) -> (global.get $non_mutable_global)
struct ImmutableGlobalToStackRemover : public wasm::Pass {
  VariableInfo const *variableInfo_;
  explicit ImmutableGlobalToStackRemover(VariableInfo const *variableInfo) : variableInfo_(variableInfo) {
    name = "ImmutableGlobalToStackRemover";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<ImmutableGlobalToStackRemover>(variableInfo_); }
  bool modifiesBinaryenIR() override { return true; }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override;
};

} // namespace warpo::passes::gc
