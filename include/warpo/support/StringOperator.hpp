// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstddef>
#include <set>
#include <string>

namespace warpo {

std::set<std::string> splitString(const std::string &str, char delimiter);

}
