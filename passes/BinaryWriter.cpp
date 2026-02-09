// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <wasm-binary.h>

#include "BinaryWriter.hpp"
#include "warpo/common/AsModule.hpp"
#include "warpo/passes/DwarfGenerator/DwarfGenerator.hpp"

namespace warpo::passes {

void BinaryWriter::write() {
  if (hasDwarf_) {
    wasm::PassRunner runner{m_.get()};
    runner.add("propagate-debug-locs");
    runner.run();

    for (auto const &[name, subprogram] : m_.variableInfo_.getSubProgramLookupMap()) {
      wasm::Function *const func = m_.get()->getFunctionOrNull(name);
      if (func == nullptr)
        continue;
      if (subprogram.getScopeInfoMap().empty())
        continue;
      // FIXME: it is a hack, binaryen will handle expression locations iff expressionLocations not empty.
      func->expressionLocations.insert_or_assign(func->body, wasm::BinaryLocations::Span{});
    }
  }
  writer_.write();
  if (hasDwarf_) {
    debugSections_ = DwarfGenerator::generateDebugSections(m_.variableInfo_, writer_.getBinaryLocations());
    for (auto const &section : debugSections_) {
      wasm::CustomSection const customSection{
          .name = section.first(),
          .data = std::vector<char>{section.second->getBufferStart(), section.second->getBufferEnd()},
      };
      // wasm support to append custom sections after writing the main module body, so directly write DWARF
      // sections here.
      writer_.writeCustomSection(customSection);
    }
  }
}
std::string BinaryWriter::dumpDwarf() const { return DwarfGenerator::dumpDwarf(debugSections_); }

} // namespace warpo::passes
