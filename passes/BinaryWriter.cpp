// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <optional>
#include <string>
#include <string_view>
#include <vector>
#include <wasm-binary.h>

#include "BinaryWriter.hpp"
#include "warpo/common/AsModule.hpp"
#include "warpo/passes/DwarfGenerator/DwarfGenerator.hpp"
#include "warpo/passes/SourceMapResolver.hpp"

namespace warpo::passes {

void BinaryWriter::write() {
  if (emitDwarf_) {
    wasm::PassRunner runner{m_.get()};
    runner.add("propagate-debug-locs");
    runner.run();

    for (auto const &[name, subprogram] : m_.variableInfo_.getSubProgramLookupMap()) {
      wasm::Function *const func = m_.get()->getFunctionOrNull(name);
      if (func == nullptr)
        continue;
      // FIXME: it is a hack, binaryen will handle expression locations iff expressionLocations not empty.
      func->expressionLocations.insert_or_assign(func->body, wasm::BinaryLocations::Span{});
    }
  }
  writer_.write();
  if (emitDwarf_) {
    std::string const sourceMap = sourceMapStream_.str();
    assert(!sourceMap.empty() && "DWARF emission requires source map emission");
    std::vector<uint8_t> const wasmBinary{buffer_.begin(), buffer_.end()};
    size_t offset = 8U;
    uint32_t codeSectionOffset = 0U;
    while (offset < wasmBinary.size()) {
      uint8_t const sectionId = wasmBinary[offset++];
      uint32_t sectionSize = 0U;
      uint32_t shift = 0U;
      uint8_t byte = 0U;
      do {
        byte = wasmBinary[offset++];
        sectionSize |= static_cast<uint32_t>(byte & 0x7FU) << shift;
        shift += 7U;
      } while ((byte & 0x80U) != 0U);
      if (sectionId == 10U) {
        codeSectionOffset = static_cast<uint32_t>(offset);
        break;
      }
      offset += sectionSize;
    }
    SourceMapResolver const sourceMapResolver{sourceMap, static_cast<uint32_t>(buffer_.size()), codeSectionOffset,
                                              writer_.tableOfContents.functionBodies, *m_.get()};
    debugSections_ = DwarfGenerator::generateDebugSections(
        m_.variableInfo_,
        [this](std::string_view const globalName) -> std::optional<uint32_t> {
          wasm::Name const name{globalName};
          if (m_.get()->getGlobalOrNull(name) == nullptr)
            return std::nullopt;
          return writer_.getGlobalIndex(name);
        },
        sourceMapResolver);
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
