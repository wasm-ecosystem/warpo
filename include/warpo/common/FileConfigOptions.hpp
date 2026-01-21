// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <filesystem>
#include <optional>
#include <string>

#include "warpo/common/Features.hpp"
#include "warpo/common/UsesOption.hpp"

namespace warpo::common {

/// Options sourced from `asconfig.json` (via `--config` / `--target`) with optional cli overrides.
///
/// Mapping is implemented in:
/// - config file parsing: `common/ConfigFile.cpp`
/// - cli parsing/merge: `common/ConfigProvider.cpp`
struct FileConfigOptions {
  /// Project path.
  /// - config: `options.project` / `targets.<name>.project`
  /// - cli: `-p` / `--project`
  std::optional<std::filesystem::path> project = std::nullopt;

  /// Output path for the final emitted module.
  /// - config: `options.outFile` / `targets.<name>.outFile`
  /// - cli: `-o` / `--output`
  std::optional<std::filesystem::path> outFile = std::nullopt;

  /// Start function export name (export instead of implicit invocation).
  /// - config: `options.exportStart` / `targets.<name>.exportStart`
  /// - cli: `--exportStart <name>`
  std::optional<std::string> exportStart = std::nullopt;

  /// Export runtime helpers like `__new`, `__collect`, `__pin`.
  /// - config: `options.exportRuntime` / `targets.<name>.exportRuntime`
  /// - cli: `--exportRuntime`
  std::optional<bool> exportRuntime = std::nullopt;

  /// Export the function table as `table`.
  /// - config: `options.exportTable` / `targets.<name>.exportTable`
  /// - cli: `--exportTable`
  std::optional<bool> exportTable = std::nullopt;

  /// Initial memory size in WebAssembly pages.
  /// - config: `options.initialMemory` / `targets.<name>.initialMemory`
  /// - cli: `--initialMemory <pages>`
  std::optional<uint32_t> initialMemory = std::nullopt;

  /// Stack size in bytes.
  /// - config: `options.stackSize` / `targets.<name>.stackSize`
  /// - cli: `--stackSize <bytes>`
  std::optional<uint32_t> stackSize = std::nullopt;

  /// Runtime selection.
  /// - config: `options.runtime` / `targets.<name>.runtime`
  /// - cli: `--runtime incremental|radical`
  std::optional<std::string> runtime = std::nullopt;

  /// Optimization level (clamped to max 3).
  /// - config: `options.optimizeLevel` / `targets.<name>.optimizeLevel`
  /// - cli: `--optimizeLevel <0..3>`
  std::optional<uint32_t> optimizeLevel = std::nullopt;

  /// Shrink level (clamped to max 2).
  /// - config: `options.shrinkLevel` / `targets.<name>.shrinkLevel`
  /// - cli: `--shrinkLevel <0..2>`
  std::optional<uint32_t> shrinkLevel = std::nullopt;

  /// Debug mode (controls debug info/lines emission).
  /// - config: `options.debug` / `targets.<name>.debug`
  /// - cli: `--debug`
  std::optional<bool> debug = std::nullopt;

  /// Source map enablement.
  /// - config: `options.sourceMap` / `targets.<name>.sourceMap`
  /// - cli: (no flag currently)
  /// Note: currently not wired into emission; debug output is gated by `debug`.
  std::optional<bool> sourceMap = std::nullopt;

  /// "use" key/value pairs (AssemblyScript `--use <name>=<value>`).
  /// - config: `options.use` / `targets.<name>.use` (object or ["name=value", ...])
  /// - cli: `-u` / `--use <name>=<value>` (repeatable; merged)
  std::optional<UsesOption> use = std::nullopt;

  /// Enabled WebAssembly features.
  /// - config: derived from `disable` (list of features to disable)
  /// - cli: derived from `--disable-feature <feature...>`
  std::optional<Features> features = std::nullopt;
};
} // namespace warpo::common