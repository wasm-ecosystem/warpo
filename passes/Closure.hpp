// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"
#include "warpo/common/VariableInfo.hpp"
namespace warpo::passes {

/// @brief lowering tostack function
struct ClosureLower final : public wasm::Pass {
  VariableInfo const *variableInfo_;
  explicit ClosureLower(VariableInfo const *variableInfo) : variableInfo_(variableInfo) { name = "gc::ClosureLower"; }
  void run(wasm::Module *m) override;
};

} // namespace warpo::passes
