// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"
#include "warpo/common/VariableInfo.hpp"
#include "wasm.h"

namespace warpo::passes::gc {

/// @brief lowering tostack function
struct OptLower : public wasm::Pass {
  VariableInfo const *variableInfo_;
  explicit OptLower(VariableInfo const *variableInfo) : variableInfo_(variableInfo) { name = "gc::OptLower"; }
  void run(wasm::Module *m) override;

  // preprocess pass for testing
  static void preprocess(wasm::PassRunner &runner);
};

} // namespace warpo::passes::gc
