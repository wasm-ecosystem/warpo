// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstddef>
#include <cstdint>
#include <string_view>

#include "ASC.hpp"

namespace {
#include "assemblyscript.inc"
#include "library_sources.inc"
} // namespace

const std::span<const uint8_t> warpo::frontend::embed_asc_wasm{asc_wasm, sizeof(asc_wasm)};
const std::map<std::string, std::string_view> warpo::frontend::embed_library_sources{
#include "library_sources_map.inc"
};
const std::map<std::string, std::string_view> warpo::frontend::embed_extension_library_sources{
#include "extension_library_sources.inc"
};
