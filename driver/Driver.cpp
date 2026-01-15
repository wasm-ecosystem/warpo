// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <filesystem>
#include <fmt/base.h>
#include <warpo/common/ConfigProvider.hpp>

#include "BuildScript.hpp"
#include "warpo/driver/Driver.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/Runner.hpp"

namespace warpo::driver {

static std::filesystem::path getOutputPath() {
  std::optional<std::filesystem::path> const outputPath = common::ConfigProvider::instance().outputPath();
  if (outputPath.has_value())
    return outputPath.value();
  throw std::runtime_error{"Output path not specified. Use -o or --output to specify the output file."};
}

} // namespace warpo::driver

void warpo::driver::build(std::filesystem::path const &outputPath) {
  std::unique_ptr<BuildScriptRunner> const runner = BuildScriptRunner::create();
  frontend::CompilationResult const result = frontend::compile(runner.get());
  if (result.m.invalid()) {
    fmt::println("compilation failed");
    fmt::println("{}", result.errorMessage);
    throw std::runtime_error("compilation failed");
  }
  passes::runAndEmit(result.m, outputPath);
}

void warpo::driver::build() { build(getOutputPath()); }
