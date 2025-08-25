#include <cstddef>

#include "ASC.hpp"

namespace {
#include "assemblyscript.inc"
}

const std::span<const uint8_t> warpo::frontend::embed_asc_wasm{build_as_assemblyscript_debug_wasm,
                                                               build_as_assemblyscript_debug_wasm_len};
