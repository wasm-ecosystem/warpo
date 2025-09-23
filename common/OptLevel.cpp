// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <cstdint>

#include "warpo/common/OptLevel.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo::common {

static cli::Opt<uint32_t> optimizeLevelOption{
    cli::Category::Frontend | cli::Category::Optimization,
    "--optimizeLevel",
    [](argparse::Argument &arg) -> void {
      arg.help("How much to focus on optimizing code. [0-3]").nargs(1U).default_value(0U);
    },
};

static cli::Opt<uint32_t> shrinkLevelOption{
    cli::Category::Frontend | cli::Category::Optimization,
    "--shrinkLevel",
    [](argparse::Argument &arg) -> void {
      arg.help("How much to focus on shrinking code. [0-2]").nargs(1U).default_value(0U);
    },
};

} // namespace warpo::common

uint32_t warpo::common::getOptimizationLevel() { return std::min(3U, optimizeLevelOption.get()); }

uint32_t warpo::common::getShrinkLevel() { return std::min(2U, shrinkLevelOption.get()); }
