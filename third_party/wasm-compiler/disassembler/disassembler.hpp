///
/// @file disassembler.hpp
/// @copyright Copyright (C) 2022 BMW Group
///
/// A disassembler for the compiled binaries produced wasm-compiler
///

#ifndef DISASSEMBLER_HPP
#define DISASSEMBLER_HPP

#include <cstddef>
#include <cstdint>
#include <string>
#include <vector>

namespace vb {
namespace disassembler {

std::string getConfiguration();

std::string disassemble(uint8_t const *const binaryData, size_t const binarySize, std::vector<uint32_t> const &instructionAddresses);
template <typename Binary> static std::string disassemble(Binary const &binary, std::vector<uint32_t> const &instructionAddresses) {
  return disassemble(binary.data(), binary.size(), instructionAddresses);
}

std::string disassembleDebugMap(uint8_t const *const binaryData, size_t const binarySize);
template <typename Binary> static std::string disassembleDebugMap(Binary const &binary) {
  return disassembleDebugMap(binary.data(), binary.size());
}

} // namespace disassembler
} // namespace vb

#endif
