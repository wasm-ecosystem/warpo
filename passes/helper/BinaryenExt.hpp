// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cassert>
#include <unordered_map>
#include <wasm-type.h>

#include "wasm.h"

namespace warpo {
class ScopeInfo;
}

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

///@brief Find the first instruction in an expression subtree, skipping blocks
wasm::Expression *findFirstInstruction(wasm::Expression *expr) noexcept;

///@brief Find the last instruction in an expression subtree, skipping blocks
wasm::Expression *findLastInstruction(wasm::Expression *expr) noexcept;

///@brief Get bytecode range for a scope (first instruction start to last instruction end)
wasm::BinaryLocations::Span
getRangeOfScope(warpo::ScopeInfo const &scopeInfo,
                std::unordered_map<wasm::Expression *, uint32_t> const &exprLocationMap) noexcept;

} // namespace warpo::passes
