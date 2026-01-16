// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <binaryen/src/binaryen-c.h>
#include <filesystem>
#include <optional>
#include <string>
#include <vector>

#include "warpo/common/AsModule.hpp"
#include "warpo/common/Features.hpp"
#include "warpo/common/UsesOption.hpp"
#include "warpo/support/Unreachable.hpp"

namespace wasm {
class Module;
};

namespace warpo::frontend {

void init();

// from assemblyscript/std/assembly/shared/runtime.ts
enum class RuntimeKind : uint32_t {
  Radical = 1U,
  Incremental = 2U,
};

namespace RuntimeUtils {
inline std::string toString(RuntimeKind runtime) {
  switch (runtime) {
  case RuntimeKind::Radical:
    return "radical";
  case RuntimeKind::Incremental:
    return "incremental";
  default:
    WARPO_UNREACHABLE;
  }
}

inline RuntimeKind fromString(std::string const &str) {
  if (str == "radical")
    return RuntimeKind::Radical;
  if (str == "incremental")
    return RuntimeKind::Incremental;
  WARPO_UNREACHABLE;
}
} // namespace RuntimeUtils

struct Config {
  common::UsesOption uses;
  std::optional<std::string> ascWasmPath;
  std::optional<std::string> exportStart;
  RuntimeKind runtime = RuntimeKind::Incremental;
  bool exportRuntime = false;
  bool exportTable = false;
  std::optional<uint32_t> initialMemory;
  uint32_t stackSize = 32768U;

  bool useColorfulDiagMessage = false;

  // directly from common
  common::Features features = common::Features::all();
  uint32_t optimizationLevel = 0U;
  uint32_t shrinkLevel = 0U;
  bool emitDebugLine = false;
  bool emitDebugInfo = false;

  static Config getDefault();
};

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
