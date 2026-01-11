// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "warpo/common/ConfigFile.hpp"
#include "warpo/common/DebugLevel.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo::common {

static cli::Opt<bool> debugOption{
    cli::Category::Frontend | cli::Category::Optimization,
    "--debug",
    [](argparse::Argument &arg) -> void { arg.help("Enables debug information in emitted binaries.").flag(); },
};

static bool isDebugInCLIOrConfig() {
  if (debugOption.isSet())
    return debugOption.get();
  std::optional<MergedFileConfig> const &fileConfig = getFileConfig();
  if (fileConfig.has_value() && fileConfig->options.debug.has_value()) {
    return fileConfig->options.debug.value();
  }
  return false;
}

} // namespace warpo::common

bool warpo::common::isEmitDebugName() { return isDebugInCLIOrConfig(); }
bool warpo::common::isEmitDebugLine() { return isDebugInCLIOrConfig(); }
bool warpo::common::isEmitDebugInfo() { return isDebugInCLIOrConfig(); }