// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <vector>

#include "src/core/common/NativeSymbol.hpp"

namespace warpo::driver {

std::vector<vb::NativeSymbol> const &getLinkedAPI();

}
