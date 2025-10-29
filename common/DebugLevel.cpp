// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "warpo/common/DebugLevel.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo::common {

static cli::Opt<bool> debugOption{
    cli::Category::Frontend | cli::Category::Optimization,
    "--debug",
    [](argparse::Argument &arg) -> void { arg.help("Enables debug information in emitted binaries.").flag(); },
};

} // namespace warpo::common

bool warpo::common::isEmitDebugLine() { return debugOption.get(); }
bool warpo::common::isEmitDebugInfo() { return debugOption.get(); }
