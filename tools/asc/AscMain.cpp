// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <argparse/argparse.hpp>
#include <binaryen/src/binaryen-c.h>
#include <cstdlib>
#include <cstring>
#include <exception>
#include <fmt/base.h>
#include <fmt/format.h>
#include <string>

#include "warpo/driver/Driver.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo {

// NOLINTNEXTLINE(modernize-avoid-c-arrays)
void ascMain(int argc, const char *argv[]) {
  frontend::init();
  passes::init();
  argparse::ArgumentParser program("warpo_asc", "git@" GIT_COMMIT);
  cli::init(cli::Category::Frontend | cli::Category::Transformation | cli::Category::Optimization, program, argc, argv);

  driver::build();
}

} // namespace warpo

int main(int argc, const char *argv[]) {
  try {
    warpo::ascMain(argc, argv);
  } catch (std::exception const &e) {
    fmt::println("ERROR: {}", e.what());
    return 1;
  }
}
