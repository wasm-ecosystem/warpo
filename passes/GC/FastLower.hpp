// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

/// @brief fast lower tostack function
struct FastLower : public wasm::Pass {
  explicit FastLower() { name = "gc::FastLower"; }
  void run(wasm::Module *m) override;
};

} // namespace warpo::passes::gc
