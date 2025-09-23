// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "warpo/common/AsModule.hpp"

namespace warpo {

bool ImmutableDataElementRanges::contains(uint32_t offset, uint32_t size) const {
  for (DataElementRange const &range : *this) {
    if (offset >= range.begin_ && (offset + size) <= range.end_)
      return true;
  }
  return false;
}

} // namespace warpo
