// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <exception>
#include <fmt/base.h>
#include <fmt/format.h>
#include <memory>
#include <regex>
#include <sstream>
#include <string>

#include "AdvancedInlining.hpp"
#include "GC/FastLower.hpp"
#include "GC/OptLower.hpp"
#include "Runner.hpp"
#include "binaryen-c.h"
#include "helper/ToString.hpp"
#include "pass.h"
#include "warpo/common/Features.hpp"
#include "warpo/passes/RunnerForTest.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm-validator.h"
#include "wasm.h"

namespace warpo {

static cli::Opt<bool> EnableGCOptLowerPassForTesting{
    cli::Category::OnlyForTest,
    "--enable-gc-opt-lower-pass-for-testing",
    [](argparse::Argument &arg) { arg.flag().hidden(); },
};
static cli::Opt<bool> EnableGCFastLowerPassForTesting{
    cli::Category::OnlyForTest,
    "--enable-gc-fast-lower-pass-for-testing",
    [](argparse::Argument &arg) { arg.flag().hidden(); },
};
static cli::Opt<bool> EnableAdvancedInliningPassForTesting{
    cli::Category::OnlyForTest,
    "--enable-advanced-inlining-pass-for-testing",
    [](argparse::Argument &arg) { arg.flag().hidden(); },
};

std::string passes::runOnWatForTest(std::string const &input, std::regex const &targetFunctionRegex) {
  std::unique_ptr<wasm::Module> m = passes::loadWat(input);
  wasm::PassRunner passRunner(m.get());
  if ((EnableGCFastLowerPassForTesting.get() && EnableGCOptLowerPassForTesting.get())) {
    fmt::println("Do not allow to enable FastLower and OptLower at the same time");
    std::terminate();
  }
  if (EnableGCOptLowerPassForTesting.get())
    passRunner.add(std::unique_ptr<wasm::Pass>{new passes::gc::OptLower()});
  if (EnableGCFastLowerPassForTesting.get())
    passRunner.add(std::unique_ptr<wasm::Pass>{new passes::gc::FastLower()});
  if (EnableAdvancedInliningPassForTesting.get())
    passRunner.add(std::unique_ptr<wasm::Pass>{passes::createAdvancedInliningPass()});
  passRunner.run();
  if (!wasm::WasmValidator{}.validate(*m))
    throw std::logic_error("validate error");

  std::stringstream ss{};
  for (std::unique_ptr<wasm::Function> &f : m->functions) {
    if (std::regex_match(f->name.toString(), targetFunctionRegex))
      ss << toString(f.get());
  }
  return std::move(ss).str();
}

} // namespace warpo
