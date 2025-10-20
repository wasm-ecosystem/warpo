// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cassert>

#include "wasm.h"

namespace warpo::passes {

template <class... Ts> bool isOneOf(wasm::Expression *expr) { return ((expr->is<Ts>()) || ...); }

inline void setAsUnImported(wasm::Importable *importable) {
  assert(importable != nullptr);
  importable->module = wasm::Name{};
  importable->base = wasm::Name{};
}

} // namespace warpo::passes
