// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstdint>
#include <string>

#include "src/WasmModule/WasmModule.hpp"

namespace warpo::frontend {

// FIXME: move it to warp_runner
class AsString final {
public:
  static std::string get(uint32_t const ptr, vb::WasmModule const *const ctx);
};

} // namespace warpo::frontend
