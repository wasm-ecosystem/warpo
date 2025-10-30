// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <memory>

#include "warp_runner/WarpRunner.hpp"

#pragma once

namespace warpo::driver {

std::unique_ptr<WarpRunner> initProjectConfig();

}
