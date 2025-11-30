// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"
#include "warpo/common/AsModule.hpp"

namespace warpo::passes {

wasm::Pass *createInlinedDecoratorLower(std::shared_ptr<ForceInlineHints> const &forceInlineHints);

} // namespace warpo::passes
