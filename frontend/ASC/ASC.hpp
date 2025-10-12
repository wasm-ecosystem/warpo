// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstddef>
#include <cstdint>
#include <map>
#include <span>
#include <string>
#include <string_view>

namespace warpo::frontend {

extern const std::span<const uint8_t> embed_asc_wasm;

extern const std::map<std::string, std::string_view> embed_library_sources;

extern const std::map<std::string, std::string_view> embed_extension_library_sources;

} // namespace warpo::frontend
