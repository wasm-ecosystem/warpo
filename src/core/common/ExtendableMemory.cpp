///
/// @file ExtendableMemory.cpp
/// @copyright Copyright (C) 2021 BMW Group
///
/// Extendable memory object implementation
///

#include <cstdint>
#include <utility>

#include "ExtendableMemory.hpp"

#include "src/config.hpp"
#include "src/core/common/VbExceptions.hpp"

namespace vb {

ExtendableMemory::ExtendableMemory() VB_NOEXCEPT : ExtendableMemory(nullptr, nullptr, 0U) {
}
ExtendableMemory::ExtendableMemory(ReallocFnc const extensionRequestPtr, uint8_t *const data, uint32_t const size, void *const ctx) VB_NOEXCEPT
    : data_(data),
      size_(size),
      extensionRequestPtr_(extensionRequestPtr),
      ctx_(ctx) {
}
ExtendableMemory::ExtendableMemory(ExtendableMemory &&other) VB_NOEXCEPT : data_(other.data_),
                                                                           size_(other.size_),
                                                                           extensionRequestPtr_(other.extensionRequestPtr_),
                                                                           ctx_(other.ctx_) {
  other.extensionRequestPtr_ = nullptr;
}

ExtendableMemory::~ExtendableMemory() VB_NOEXCEPT {
  this->freeExtendableMemory();
}

ExtendableMemory &ExtendableMemory::operator=(ExtendableMemory &&original) & VB_NOEXCEPT {
  swap(*this, std::move(original));
  return *this;
}

void ExtendableMemory::resize(uint32_t const size) {
  if (size_ >= size) {
    return;
  }

  if (extensionRequestPtr_ != nullptr) {
    extensionRequest(size);
    if ((data_ != nullptr) && (size_ >= size)) {
      return;
    }
  }

  throw RuntimeError(ErrorCode::Could_not_extend_memory);
}

// coverity[autosar_cpp14_m9_3_3_violation]
void ExtendableMemory::freeExtendableMemory() VB_NOEXCEPT {
  if (extensionRequestPtr_ != nullptr) {
    extensionRequestPtr_(*this, 0U, ctx_);
  }
}

} // namespace vb
