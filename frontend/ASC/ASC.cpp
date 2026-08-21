// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstddef>
#include <cstdint>

#include "ASC.hpp"

namespace {
#include "assemblyscript.inc"
} // namespace

const std::span<const uint8_t> warpo::frontend::embed_asc_wasm{asc_wasm, sizeof(asc_wasm)};
