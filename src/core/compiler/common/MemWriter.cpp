///
/// @file MemWriter.cpp
/// @copyright Copyright (C) 2021 BMW Group
///

#include <cassert>
#include <cstddef>
#include <cstdint>
#include <memory>

#include "MemWriter.hpp"

#include "src/core/common/ExtendableMemory.hpp"
#include "src/core/common/VbExceptions.hpp"
#include "src/core/common/util.hpp"

namespace vb {

void MemWriter::resize(uint32_t const size) {
  size_ = size;
  if (size_ > memory_.size()) {
    memory_.resize(size_);
  }
}

uint32_t MemWriter::alignTop(uint32_t const bytes) {
  void *newPtr{ptr()};
  std::size_t space{static_cast<size_t>(capacity()) - static_cast<size_t>(size())};
  newPtr = std::align(static_cast<size_t>(bytes), 0U, newPtr, space);
  if (newPtr == nullptr) {                                                 // Not enough space
    requestExtension(memory_.size() + bytes);                              // extend
    newPtr = ptr();                                                        // Update pointer
    space = static_cast<size_t>(capacity()) - static_cast<size_t>(size()); // Get new space
    newPtr = std::align(static_cast<size_t>(bytes), 0U, newPtr, space);    // Try again
    assert(newPtr && "Undefined error during memory alignment");
  }
  uint64_t const newLength{static_cast<uint64_t>(pSubAddr(newPtr, base()))};
  if (newLength > UINT32_MAX) {
    throw RuntimeError(ErrorCode::Maximum_number_of_bytes_written);
  }
  resize(static_cast<uint32_t>(newLength));
  assert((pToNum(ptr()) % bytes) == 0U && "Pointer not properly aligned");
  return static_cast<uint32_t>(newLength);
}

void MemWriter::step(uint32_t const bytes) {
  uint64_t const newLength{static_cast<uint64_t>(size_) + bytes};
  if (newLength > UINT32_MAX) {
    throw RuntimeError(ErrorCode::Maximum_number_of_bytes_written);
  }
  resize(static_cast<uint32_t>(newLength));
}

void MemWriter::writeByte(uint8_t const data) {
  write<uint8_t>(data);
}
void MemWriter::writeBytesLE(uint64_t const data, uint8_t const numBytes) {
  for (uint8_t i{0U}; i < numBytes; i++) {
    writeByte(static_cast<uint8_t>((data >> (static_cast<uint64_t>(i) * 8_U64)) & 0xFF_U64));
  }
}

} // namespace vb
