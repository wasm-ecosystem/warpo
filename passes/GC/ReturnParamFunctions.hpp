// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <optional>
#include <unordered_map>

#include "wasm.h"

namespace warpo::passes::gc {

using ReturnParamMap = std::unordered_map<wasm::Name, wasm::Index>;

ReturnParamMap collectReturnParamFunctions(wasm::Module *m);

} // namespace warpo::passes::gc
