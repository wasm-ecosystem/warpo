// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"
#include "warpo/common/VariableInfo.hpp"
namespace warpo::passes::closure {

struct FastLower final : public wasm::Pass {
  VariableInfo const *variableInfo_;
  explicit FastLower(VariableInfo const *variableInfo) : variableInfo_(variableInfo) { name = "closure::FastLower"; }
  void run(wasm::Module *m) override;
};

struct LevelDef final {
  int32_t level;
  wasm::Index localIndex;
};

struct CacheLevelInLocalAction final {
  LevelDef fromLevel;
  LevelDef toLevel;
};

struct OptLower final : public wasm::Pass {
  VariableInfo const *variableInfo_;
  explicit OptLower(VariableInfo const *variableInfo) : variableInfo_(variableInfo) { name = "closure::OptLower"; }
  void run(wasm::Module *m) override;
};

} // namespace warpo::passes::closure
