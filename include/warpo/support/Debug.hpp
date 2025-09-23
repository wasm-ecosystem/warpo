// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <string_view>

namespace warpo::support {

bool isDebug(const char *passName);
bool isDebug(const char *passName, std::string_view functionName);

bool forceEnable(bool newValue);

struct ForceEnableRAII {
  bool oldValue;
  ForceEnableRAII(bool newValue) { oldValue = forceEnable(newValue); }
  ~ForceEnableRAII() { forceEnable(oldValue); }
};

} // namespace warpo::support
