// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <pass.h>
#include <wasm-traversal.h>

#include "InstrSimplifier.hpp"

struct InstrSimplifier : public wasm::WalkerPass<wasm::PostWalker<InstrSimplifier>> {};

wasm::Pass *warpo::passes::createInstrSimplifier() {}
