// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <cassert>
#include <source-map.h>
#include <utility>
#include <wasm.h>

#include "warpo/passes/SourceMapResolver.hpp"

namespace warpo::passes {

namespace {

constexpr uint8_t codeSectionId = 10U;

uint32_t readU32Leb(std::vector<uint8_t> const &buffer, size_t &offset) {
  uint32_t result = 0U;
  uint32_t shift = 0U;
  while (offset < buffer.size()) {
    uint8_t const byte = buffer[offset++];
    result |= static_cast<uint32_t>(byte & 0x7FU) << shift;
    if ((byte & 0x80U) == 0U)
      return result;
    shift += 7U;
  }
  assert(false && "Unexpected end of wasm while reading LEB");
  return 0U;
}

} // namespace

SourceMapResolver::Mapping::Mapping(uint32_t const generatedOffset, std::optional<SourceLocation> sourceLocation)
    : generatedOffset(generatedOffset), sourceLocation(std::move(sourceLocation)) {}

uint32_t SourceMapResolver::getCodeSectionOffset(std::vector<uint8_t> const &wasmBinary) {
  assert(wasmBinary.size() >= 8U);
  size_t offset = 8U;
  while (offset < wasmBinary.size()) {
    uint8_t const sectionId = wasmBinary[offset++];
    uint32_t const sectionSize = readU32Leb(wasmBinary, offset);
    uint32_t const sectionPayloadOffset = static_cast<uint32_t>(offset);
    if (sectionId == codeSectionId)
      return sectionPayloadOffset;
    offset += sectionSize;
  }
  assert(false && "Wasm binary must contain a code section");
  return 0U;
}

SourceMapResolver::SourceMapResolver(std::string const &sourceMap, uint32_t const wasmByteSize,
                                     uint32_t const codeSectionOffset, wasm::BinaryLocations const &binaryLocations) {
  if (!sourceMap.empty()) {
    std::vector<char> sourceMapBuffer{sourceMap.begin(), sourceMap.end()};
    sourceMapBuffer.push_back('\0');
    wasm::Module m;
    wasm::SourceMapReader reader{sourceMapBuffer};
    reader.parse(m);

    std::optional<wasm::Function::DebugLocation> previousLocation;
    bool previousLocationSet = false;
    for (uint32_t generatedOffset = 0U; generatedOffset < wasmByteSize; ++generatedOffset) {
      std::optional<wasm::Function::DebugLocation> const location = reader.readDebugLocationAt(generatedOffset);
      if (previousLocationSet && location == previousLocation)
        continue;
      previousLocationSet = true;
      previousLocation = location;

      std::optional<SourceLocation> sourceLocation = std::nullopt;
      if (location.has_value()) {
        assert(location->fileIndex >= 0);
        size_t const fileIndex = static_cast<size_t>(location->fileIndex);
        assert(fileIndex < m.debugInfoFileNames.size());
        sourceLocation = SourceLocation{
            .sourcePath = m.debugInfoFileNames[fileIndex],
            .line = static_cast<uint32_t>(location->lineNumber),
        };
      }
      mappings_.emplace_back(generatedOffset, std::move(sourceLocation));
    }
  }
  for (auto const &[func, locations] : binaryLocations.functions) {
    std::string const functionName = func->name.toString();
    functionRanges_.emplace(functionName, BytecodeRange{.lowPc = codeSectionOffset + locations.declarations,
                                                        .highPc = codeSectionOffset + locations.end});
  }
}

std::optional<SourceMapResolver::SourceLocation>
SourceMapResolver::resolveGeneratedOffset(uint32_t const generatedOffset, ResolveBias const bias) const {
  std::optional<SourceLocation> result;
  if (bias == ResolveBias::Previous) {
    for (Mapping const &mapping : mappings_) {
      if (mapping.generatedOffset > generatedOffset)
        break;
      result = mapping.sourceLocation;
    }
  } else {
    for (Mapping const &mapping : mappings_) {
      if (mapping.generatedOffset < generatedOffset || !mapping.sourceLocation.has_value())
        continue;
      result = mapping.sourceLocation;
      break;
    }
  }
  return result;
}

std::optional<SourceMapResolver::BytecodeRange>
SourceMapResolver::resolveRange(std::string_view const sourcePath, uint32_t const startLine, uint32_t const endLine,
                                std::string_view const functionName) const {
  assert(!functionName.empty());
  std::optional<uint32_t> lowPc;
  std::optional<uint32_t> highPc;
  auto const it = functionRanges_.find(std::string{functionName});
  if (it == functionRanges_.end())
    return std::nullopt;

  for (Mapping const &mapping : mappings_) {
    if (mapping.generatedOffset < it->second.lowPc)
      continue;
    if (mapping.generatedOffset > it->second.highPc)
      break;
    if (!mapping.sourceLocation.has_value())
      continue;
    SourceLocation const &location = *mapping.sourceLocation;
    if (location.sourcePath != sourcePath)
      continue;
    if (location.line < startLine || location.line > endLine)
      continue;
    lowPc = lowPc.has_value() ? std::min(*lowPc, mapping.generatedOffset) : mapping.generatedOffset;
    highPc = highPc.has_value() ? std::max(*highPc, mapping.generatedOffset) : mapping.generatedOffset;
  }
  if (!lowPc.has_value() || !highPc.has_value())
    return std::nullopt;
  return BytecodeRange{.lowPc = *lowPc, .highPc = *highPc};
}

} // namespace warpo::passes
