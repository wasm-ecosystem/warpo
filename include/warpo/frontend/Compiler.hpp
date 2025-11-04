// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <binaryen/src/binaryen-c.h>
#include <filesystem>
#include <map>
#include <optional>
#include <string>
#include <vector>

#include "warpo/common/AsModule.hpp"
#include "warpo/common/Features.hpp"

namespace wasm {
class Module;
};

namespace warpo::frontend {

void init();

struct Config {
  std::map<std::string, std::string> uses;
  std::optional<std::string> ascWasmPath;
  common::Features features;
  std::optional<std::string> exportStart;
  bool exportRuntime;
  bool exportTable;
  std::optional<uint32_t> initialMemory;
  uint32_t optimizationLevel;
  uint32_t shrinkLevel;
  bool emitDebugLine;
  bool emitDebugInfo;
  bool useColorfulDiagMessage;
  bool experimental;
};

Config getDefaultConfig();

class Pluggable {
public:
  virtual ~Pluggable() = default;
  virtual std::optional<std::filesystem::path> getPackageRoot([[maybe_unused]] std::string const &packageName) {
    return std::nullopt;
  }
};

struct CompilationResult {
  AsModule m;
  std::string errorMessage;
};

CompilationResult compile(Pluggable *plugin);
CompilationResult compile(Pluggable *plugin, std::vector<std::string> const &entryFilePaths, Config const &config);

} // namespace warpo::frontend
