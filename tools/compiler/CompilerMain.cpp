// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <argparse/argparse.hpp>
#include <binaryen/src/binaryen-c.h>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fstream>

#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo {

static cli::Opt<std::filesystem::path> outputPath{
    cli::Category::All,
    "-t",
    "--text",
    [](argparse::Argument &arg) -> void { arg.help("output text file").required(); },
};
// NOLINTNEXTLINE(modernize-avoid-c-arrays)
void compilerMain(int argc, const char *argv[]) {
  frontend::init();
  argparse::ArgumentParser program("warpo_compiler", "git@" GIT_COMMIT);
  cli::init(cli::Category::Frontend, program, argc, argv);

  frontend::CompilationResult const result = frontend::compile(nullptr);
  if (result.m.invalid()) {
    fmt::println("compilation failed");
    fmt::println("{}", result.errorMessage);
    throw std::runtime_error("compilation failed");
  }
  char *const wasmText = BinaryenModuleAllocateAndWriteText(result.m.get());
  std::ofstream watOf = openOFStream(outputPath.get(), std::ios::out | std::ios::binary | std::ios::trunc);
  watOf << wasmText;
  std::free(wasmText);
}

} // namespace warpo

int main(int argc, const char *argv[]) {
  try {
    warpo::compilerMain(argc, argv);
  } catch (std::exception const &e) {
    fmt::println("ERROR: {}", e.what());
    return 1;
  }
}
