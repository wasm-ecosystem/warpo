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
  }
  writer_.write();
  if (hasDwarf_) {
    std::unordered_map<wasm::Expression *, size_t *> const &expressionOffsets = writer_.getExpressionOffsets();
    debugSections_ = DwarfGenerator::generateDebugSections(m_.variableInfo_, expressionOffsets);
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
