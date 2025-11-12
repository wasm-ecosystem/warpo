// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cassert>
#include <wasm-type.h>

#include "wasm.h"

namespace warpo::passes {

template <class... Ts> bool isOneOf(wasm::Expression *expr) { return ((expr->is<Ts>()) || ...); }
template <class... Ts> bool isOneOf(wasm::Expression const *expr) { return ((expr->is<Ts>()) || ...); }

inline void setAsUnImported(wasm::Function *function) {
  assert(function != nullptr);
  function->module = wasm::Name{};
  function->base = wasm::Name{};
  // define function must be exact type, see https://github.com/WebAssembly/binaryen/pull/7993
  function->type = function->type.with(wasm::Exactness::Exact);
}

} // namespace warpo::passes
