// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <argparse/argparse.hpp>
#include <cassert>
#include <functional>
#include <map>
#include <vector>

#include "warpo/support/Opt.hpp"

namespace warpo::cli {

struct LazyInitOptCallback {
  static LazyInitOptCallback &ins() {
    static LazyInitOptCallback instance{};
    return instance;
  }
  std::map<Category, std::vector<std::function<void(argparse::ArgumentParser &)>>> registerCallback_;
};

void detail::registerCallback(Category cat, std::function<void(argparse::ArgumentParser &)> &&fn) {
  LazyInitOptCallback::ins().registerCallback_[cat].push_back(std::move(fn));
}

} // namespace warpo::cli
// NOLINTNEXTLINE(modernize-avoid-c-arrays)
void warpo::cli::init(Category cat, argparse::ArgumentParser &program, int argc, char const *argv[]) {
  for (auto const &[optCat, fns] : LazyInitOptCallback::ins().registerCallback_) {
    if ((optCat & cat) == Category::None)
      continue;
    for (auto const &fn : fns)
      fn(program);
  }
  program.parse_args(argc, argv);
}
