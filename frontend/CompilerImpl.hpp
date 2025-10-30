// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <fmt/format.h>
#include <optional>
#include <set>
#include <string>
#include <string_view>
#include <vector>

#include "ModuleResolver.hpp"
#include "warp_runner/WarpRunner.hpp"
#include "warpo/common/AsModule.hpp"
#include "warpo/frontend/Compiler.hpp"

#include "src/WasmModule/WasmModule.hpp"

namespace warpo::frontend {

class FrontendCompiler final {
  enum class IsEntry : uint32_t { NO, YES };

  WarpRunner r;
  ModuleResolver moduleResolver_;
  size_t errorCount_ = 0;
  std::string errorMessage_;

  int32_t allocString(std::string_view str);

  void parseFile(int32_t const program, std::optional<std::string_view> const &code, std::string_view path,
                 IsEntry isEntry);

  std::string getAsString(uint32_t ptr);

  Dependency getDependency(std::string const &nextFileInternalPath, int32_t program, int32_t nextFile);

  std::vector<Dependency> getAllDependencies(int32_t const program);

  /// @return true when has error
  bool checkDiag(int32_t const program, bool useColorfulDiagMessage);

public:
  static void init() { vb::WasmModule::initEnvironment(&malloc, &realloc, &free); }
  static void deinit() { vb::WasmModule::destroyEnvironment(); }

  explicit FrontendCompiler(Config const &config);
  FrontendCompiler(FrontendCompiler const &) = delete;
  FrontendCompiler &operator=(FrontendCompiler const &) = delete;
  FrontendCompiler(FrontendCompiler &&) = delete;
  FrontendCompiler &operator=(FrontendCompiler &&) = delete;
  ~FrontendCompiler();

  CompilationResult compile(std::vector<std::string> const &entryFilePaths, Config const &config);

  std::set<void *> allocedPtrs_;
  AsModule asModule_;
};

} // namespace warpo::frontend
