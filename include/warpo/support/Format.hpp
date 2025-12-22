// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <format>
#include <string>
#include <string_view>
#include <utility>

namespace warpo::fmt {

namespace detail {

void log(std::string_view msg);

void logWithLn(std::string_view msg);

} // namespace detail

template <class... Args> std::string format(std::format_string<Args...> fmtStr, Args &&...args) {
  return ::std::format(fmtStr, std::forward<Args>(args)...);
}

template <class... Args> void print(std::format_string<Args...> fmtStr, Args &&...args) {
  detail::log(::std::format(fmtStr, std::forward<Args>(args)...));
}

template <class... Args> void println(std::format_string<Args...> fmtStr, Args &&...args) {
  detail::logWithLn(::std::format(fmtStr, std::forward<Args>(args)...));
}

} // namespace warpo::fmt
