// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"
#include "warpo/common/AsModule.hpp"

namespace warpo::passes {

wasm::Pass *createImmutableLoadEliminatingPass(std::shared_ptr<ImmutableDataElementRanges> const &immutableDataRanges);

} // namespace warpo::passes
