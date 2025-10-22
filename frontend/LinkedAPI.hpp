// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <vector>

#include "src/core/common/NativeSymbol.hpp"

namespace warpo::frontend {

std::vector<vb::NativeSymbol> createAssemblyscriptAPI();
std::vector<vb::NativeSymbol> createBinaryenLinkedAPI();
std::vector<vb::NativeSymbol> createCppWrapperAPI();
std::vector<vb::NativeSymbol> createOptAPI();
std::vector<vb::NativeSymbol> createVariableInfoAPI();

std::vector<vb::NativeSymbol> const &getLinkedAPI();

} // namespace warpo::frontend
