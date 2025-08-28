#include <cstddef>

#include "ASC.hpp"

namespace {
#include "assemblyscript.inc"
}

const std::span<const uint8_t> warpo::frontend::embed_asc_wasm{asc_wasm, asc_wasm_len};

const std::map<std::string, std::string> warpo::frontend::embed_library_sources{
#include "library_sources.inc"
};
