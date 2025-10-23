///
/// @file AbbrevFactory.hpp
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
#ifndef ABBREV_FACTORY_HPP
#define ABBREV_FACTORY_HPP

#include <cstdint>

#include "llvm/BinaryFormat/Dwarf.h"
#include "llvm/ObjectYAML/DWARFYAML.h"

namespace warpo {

/// @brief Factory for creating DWARF abbreviations with auto-incrementing codes
class AbbrevFactory final {
public:
  inline AbbrevFactory() noexcept : nextCode_(1U) {}
  /// @brief Create a new abbreviation with auto-incrementing code
  /// @param tag The DWARF tag (e.g., DW_TAG_compile_unit, DW_TAG_class_type)
  /// @param children Whether this abbreviation has children (DW_CHILDREN_yes or DW_CHILDREN_no)
  /// @return A new Abbrev object with auto-assigned code
  llvm::DWARFYAML::Abbrev create(llvm::dwarf::Tag tag, llvm::dwarf::Constants children) noexcept;

private:
  uint32_t nextCode_;
};

} // namespace warpo
#endif
