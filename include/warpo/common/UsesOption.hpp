// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <map>
#include <string>

namespace warpo::common {

struct UsesOption : std::map<std::string, std::string> {
  UsesOption() = default;
  void merge(std::string const &useStr);
  using std::map<std::string, std::string>::insert_or_assign;
};

} // namespace warpo::common