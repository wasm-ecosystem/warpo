// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "WarpRunner.hpp"

#include "src/utils/StackTop.hpp"

namespace warpo {

WarpRunner::WarpRunner(void *const ctx)
    : logger(), stackTop(static_cast<uint8_t const *>(vb::getStackTop())), m{logger} {
  m.setStacktraceRecordCount(32U);
  m.setContext(ctx);
}

} // namespace warpo
