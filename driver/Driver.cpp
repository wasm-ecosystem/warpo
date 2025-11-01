// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <filesystem>
#include <fmt/base.h>

#include "BuildScript.hpp"
#include "warpo/driver/Driver.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo::driver {

static cli::Opt<std::filesystem::path> outputPathOption{
    cli::Category::All,
    "-o",
    "--output",
    [](argparse::Argument &arg) -> void { arg.help("output file").required(); },
};

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

void warpo::driver::build() { build(outputPathOption.get()); }
