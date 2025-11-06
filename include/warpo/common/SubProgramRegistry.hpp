///
/// @file SubProgramRegistry.hpp
/// @copyright Copyright (C) 2025 wasm-ecosystem
/// SPDX-License-Identifier: Apache-2.0
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
#pragma once

#include <deque>
#include <string>

#include "LocalInfo.hpp"
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
