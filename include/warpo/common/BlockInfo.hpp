// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <cstdint>

#include "ScopeInfo.hpp"

namespace warpo {

class BlockInfo final : public ScopeInfo {
public:
  inline BlockInfo(uint32_t const startLine, uint32_t const endLine) noexcept
      : ScopeInfo(Kind::Block), startLine_(startLine), endLine_(endLine) {}

  inline uint32_t getStartLine() const noexcept { return startLine_; }
  inline uint32_t getEndLine() const noexcept { return endLine_; }

  static bool classof(ScopeInfo const *s) noexcept { return s->getKind() == Kind::Block; }

private:
  uint32_t startLine_;
  uint32_t endLine_;
};

} // namespace warpo
