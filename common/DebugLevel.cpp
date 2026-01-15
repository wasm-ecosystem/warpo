// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "warpo/common/ConfigProvider.hpp"
#include "warpo/common/DebugLevel.hpp"

bool warpo::common::isEmitDebugName() { return ConfigProvider::instance().isDebugEnabled(); }
bool warpo::common::isEmitDebugLine() { return ConfigProvider::instance().isDebugEnabled(); }
bool warpo::common::isEmitDebugInfo() { return ConfigProvider::instance().isDebugEnabled(); }
