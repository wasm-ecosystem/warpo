// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <argparse/argparse.hpp>
#include <cassert>
#include <functional>

namespace warpo::cli {

enum class Category : uint32_t {
  None = 0,
  OnlyForTest = 1U << 1U,
  Frontend = 1U << 2U,
  Optimization = 1U << 3U,
  Transformation = 1U << 4U,
  All = static_cast<uint32_t>(-1),
};

inline Category operator|(Category a, Category b) {
  return static_cast<Category>(static_cast<uint32_t>(a) | static_cast<uint32_t>(b));
}
inline Category operator&(Category a, Category b) {
  return static_cast<Category>(static_cast<uint32_t>(a) & static_cast<uint32_t>(b));
}

namespace detail {
void registerCallback(Category cat, std::function<void(argparse::ArgumentParser &)> &&fn);
}

template <typename T> struct Opt {
  /// @param cat Category of this arg, one of this category is active in program will let this option be visible
  Opt(Category cat, const char *name, std::function<void(argparse::Argument &)> &&fn) {
    detail::registerCallback(cat, [fn = std::move(fn), name, this](argparse::ArgumentParser &argparser) -> void {
      fn(argparser.add_argument(name).store_into(v_));
    });
  }
  /// @param cat Category of this arg, one of this category is active in program will let this option be visible
  Opt(Category cat, const char *shortName, const char *longName, std::function<void(argparse::Argument &)> &&fn) {
    detail::registerCallback(
        cat, [fn = std::move(fn), shortName, longName, this](argparse::ArgumentParser &argparser) -> void {
          fn(argparser.add_argument(shortName, longName).store_into(v_));
        });
  }

  T const &get() const { return v_; }

private:
  T v_{};
};

/// @param cat Category of this program
// NOLINTNEXTLINE(modernize-avoid-c-arrays)
void init(Category cat, argparse::ArgumentParser &program, int argc, char const *argv[]);

} // namespace warpo::cli
