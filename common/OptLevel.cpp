// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstdint>

#include "warpo/common/ConfigProvider.hpp"
#include "warpo/common/OptLevel.hpp"

/// @brief merge optimization level from CLI and config file
uint32_t warpo::common::getOptimizationLevel() { return ConfigProvider::instance().optimizationLevel(); }

/// @brief merge shrink level from CLI and config file
uint32_t warpo::common::getShrinkLevel() { return ConfigProvider::instance().shrinkLevel(); }
