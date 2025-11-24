// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "llvm/ObjectYAML/DWARFYAML.h"
#include "warpo/common/SubProgramInfo.hpp"
#include "warpo/common/VariableInfo.hpp"

namespace warpo::passes {

struct TypeRefFixup final {
  size_t entryIndex;
  size_t valueIndex;
  std::string_view typeName;
};

class DwarfGenerator final {
public:
  static llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> generateDebugSections(VariableInfo const &variableInfo);
  static std::string dumpDwarf(llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> const &debugSections);

private:
  static void addSubProgramWithParameters(SubProgramInfo const &subProgram, llvm::DWARFYAML::Unit &rootUnit,
                                          llvm::DWARFYAML::Abbrev const &subprogramAbbrev,
                                          llvm::DWARFYAML::Abbrev const &formalParameterAbbrev,
                                          std::vector<TypeRefFixup> &typeRefFixups);
};

} // namespace warpo::passes