// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <argparse/argparse.hpp>
#include <cassert>
#include <filesystem>
#include <fmt/base.h>
#include <functional>
#include <map>
#include <stdexcept>
#include <string>
#include <vector>

#include "warpo/support/Opt.hpp"

namespace warpo::cli {

namespace {

std::filesystem::path resolveExecutablePath(char const *argv0) {
  std::error_code error;
  std::filesystem::path const executablePath = std::filesystem::canonical(argv0, error);
  if (error)
    throw std::runtime_error{"cannot resolve executable path '" + executablePath.string() + "': " + error.message()};
  return executablePath;
}

std::filesystem::path executablePath;

} // namespace

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

std::filesystem::path warpo::cli::getExecutablePath() {
  if (executablePath.empty())
    throw std::runtime_error{"executable path is unavailable; call warpo::cli::init first"};
  return executablePath;
}

// NOLINTNEXTLINE(modernize-avoid-c-arrays)
void warpo::cli::init(Category cat, argparse::ArgumentParser &program, int argc, char const *argv[]) {
  if (argc <= 0 || argv == nullptr || argv[0] == nullptr)
    throw std::runtime_error{"cannot resolve executable path from argv[0]"};
  executablePath = resolveExecutablePath(argv[0]);

  for (auto const &[optCat, fns] : LazyInitOptCallback::ins().registerCallback_) {
    if ((optCat & cat) == Category::None)
      continue;
    for (auto const &fn : fns)
      fn(program);
  }
  for (auto const &arg : program.parse_known_args(argc, argv))
    fmt::println(stderr, "WARNING: unknown argument ignored: {}", arg);
}
