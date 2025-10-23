///
/// @file AbbrevFactory.cpp
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
#include "AbbrevFactory.hpp"

namespace warpo {

llvm::DWARFYAML::Abbrev AbbrevFactory::create(llvm::dwarf::Tag tag, llvm::dwarf::Constants children) noexcept {
  llvm::DWARFYAML::Abbrev abbrev;
  abbrev.Code = nextCode_;
  nextCode_++;
  abbrev.Tag = tag;
  abbrev.Children = children;
  abbrev.ListOffset = 0;
  return abbrev;
}

} // namespace warpo
