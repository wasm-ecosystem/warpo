///
/// @file DwarfGenerator.hpp
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
#include "llvm/ObjectYAML/DWARFEmitter.h"
#include "warpo/common/VariableInfo.hpp"
namespace warpo::passes {
class DwarfGenerator final {
public:
  static llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> generateDebugSections(VariableInfo const &variableInfo);
  static std::string dumpDwarf(llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> const &debugSections);
};

} // namespace warpo::passes