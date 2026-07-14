// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>

namespace wasm {
struct BinaryLocations;
} // namespace wasm

namespace warpo::passes {

class SourceMapResolver final {
public:
  struct SourceLocation final {
    std::string sourcePath;
    uint32_t line;
  };

  struct BytecodeRange final {
    uint32_t lowPc;
    uint32_t highPc;
  };

  enum class ResolveBias { Previous, Next };

  explicit SourceMapResolver(std::string const &sourceMap, uint32_t wasmByteSize, uint32_t codeSectionOffset,
                             wasm::BinaryLocations const &binaryLocations);

  static uint32_t getCodeSectionOffset(std::vector<uint8_t> const &wasmBinary);

  std::optional<SourceLocation> resolveGeneratedOffset(uint32_t generatedOffset,
                                                       ResolveBias bias = ResolveBias::Previous) const;
  std::optional<BytecodeRange> resolveRange(std::string_view sourcePath, uint32_t startLine, uint32_t endLine,
                                            std::string_view functionName) const;

private:
  struct Mapping final {
    Mapping(uint32_t generatedOffset, std::optional<SourceLocation> sourceLocation);

    uint32_t generatedOffset;
    std::optional<SourceLocation> sourceLocation;
  };

  std::vector<Mapping> mappings_;
  std::unordered_map<std::string, BytecodeRange> functionRanges_;
  uint32_t codeSectionOffset_;
};

} // namespace warpo::passes