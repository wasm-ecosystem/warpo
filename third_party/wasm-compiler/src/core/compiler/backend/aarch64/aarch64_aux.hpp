///
/// @file aarch64_aux.hpp
/// @copyright Copyright (C) 2021 BMW Group
///
/// Auxiliary functions for AArch64 encoding
///

#ifndef AARCH64_AUX_HPP
#define AARCH64_AUX_HPP

#include <cstdint>

#include "src/config.hpp"

namespace vb {
namespace aarch64 {

///
/// @brief Determines if an immediate value can be encoded as the immediate operand of a logical instruction for the
/// given register size
///
/// @param imm Immediate value to encode
/// @param is64 Whether the register is a 64-bit register (otherwise a 32-bit register is assumed)
/// @param encoding Sets this lvalue to the encoded value in the form N:immr:imms if encoding is possible
/// @return bool Whether the immediate can be encoded this way
bool processLogicalImmediate(uint64_t imm, bool const is64, uint64_t &encoding) VB_NOEXCEPT;

} // namespace aarch64
} // namespace vb

#endif
