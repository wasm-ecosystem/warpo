// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <filesystem>
#include <map>
#include <optional>
#include <string>

#include "warpo/frontend/Compiler.hpp"

namespace warpo::frontend {

constexpr const char *const libraryPrefix = "~lib/";
constexpr const char *const extension = ".ts";

struct Dependency final {
  std::optional<std::string> text;
  std::string path;
};

class ModuleResolver {
  std::map<std::string, std::filesystem::path> packageRootMap_;
  Pluggable *plugin_;
  std::vector<std::filesystem::path> packageSearchPaths_;

public:
  explicit ModuleResolver(Pluggable *plugin, std::vector<std::filesystem::path> packageSearchPaths)
      : plugin_(plugin), packageSearchPaths_(std::move(packageSearchPaths)) {}
  std::optional<std::filesystem::path> findPackageRoot(std::filesystem::path const &sourceInternalPath,
                                                       std::string const &packageName);

  Dependency getDependencyForUserCode(std::string const &nextFileInternalPath);
  Dependency getDependencyForNodeModules(std::string const &nextFileInternalPath, std::string const &dependeePath);
};

} // namespace warpo::frontend
