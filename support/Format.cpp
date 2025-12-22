// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <iostream>
#include <mutex>

#include "warpo/support/Format.hpp"

namespace warpo::fmt {

std::mutex logMutex_;

void detail::log(std::string_view msg) {
  std::lock_guard<std::mutex> const lock{logMutex_};
  std::cout << msg;
}

void detail::logWithLn(std::string_view msg) {
  std::lock_guard<std::mutex> const lock{logMutex_};
  std::cout << msg << "\n";
}

} // namespace warpo::fmt
