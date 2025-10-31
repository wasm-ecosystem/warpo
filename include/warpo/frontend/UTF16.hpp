// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <string>

namespace warpo::frontend::utf16 {

std::u16string fromUTF8(std::string_view utf8Str);
std::string toUTF8(std::u16string_view utf16Str);

} // namespace warpo::frontend::utf16
