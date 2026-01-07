// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <deque>
#include <string>

#include "SubProgramInfo.hpp"
#include "warpo/support/StringPool.hpp"

namespace warpo {

class SubProgramRegistry final {
public:
  SubProgramInfo &addSubProgram(std::string const subProgramName);
  inline std::deque<SubProgramInfo> const &getList() const noexcept { return registry_; }

private:
  std::deque<SubProgramInfo> registry_;
  StringPool stringPool_;
};

} // namespace warpo
