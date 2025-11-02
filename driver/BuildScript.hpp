// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <filesystem>
#include <memory>
#include <optional>

#include "warpo/frontend/Compiler.hpp"
#include "warpo/warp_runner/WarpRunner.hpp"

#pragma once

namespace warpo::driver {

using OnResolveModuleFn = std::function<std::optional<std::filesystem::path>(std::string const &packageName)>;

class BuildScriptRunner final : public frontend::Pluggable {
  WarpRunner r_;
  std::string createFileDirName_;
  explicit BuildScriptRunner(std::filesystem::path const &buildScriptPath);

  std::optional<OnResolveModuleFn> onModuleResolveCallback_;

public:
  /// @return nullptr when the project configuration file is not found
  static std::unique_ptr<BuildScriptRunner> create();

  std::string const &getCreateFileDirName() const { return createFileDirName_; }

  OnResolveModuleFn::result_type getPackageRoot(std::string const &packageName) override;
  void registerOnModuleResolve(OnResolveModuleFn callback);
};

} // namespace warpo::driver
