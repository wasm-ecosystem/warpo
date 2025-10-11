// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <argparse/argparse.hpp>
#include <cstddef>
#include <filesystem>
#include <fmt/format.h>

#include "fmt/base.h"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo {
static cli::Opt<std::string> inputPath{
    cli::Category::All,
    "-i",
    "--input",
    [](argparse::Argument &arg) -> void { arg.help("input file").required(); },
};

static cli::Opt<std::filesystem::path> outputPath{
    cli::Category::All,
    "-o",
    "--output",
    [](argparse::Argument &arg) -> void { arg.help("output file").required(); },
};

// NOLINTNEXTLINE(modernize-avoid-c-arrays)
void optMain(int argc, char const *argv[]) {
  passes::init();
  argparse::ArgumentParser program("warpo", "git@" GIT_COMMIT);
  cli::init(cli::Category::Optimization, program, argc, argv);
  passes::runAndEmit(inputPath.get(), outputPath.get());
}
} // namespace warpo

int main(int argc, const char *argv[]) {
  try {
    warpo::optMain(argc, argv);
  } catch (std::exception const &e) {
    fmt::println("ERROR: {}", e.what());
    return 1;
  }
}
