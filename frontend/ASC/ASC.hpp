#pragma once

#include <cstddef>
#include <cstdint>
#include <map>
#include <span>
#include <string>

namespace warpo::frontend {

extern const std::span<const uint8_t> embed_asc_wasm;

extern const std::map<std::string, std::string> embed_library_sources;

} // namespace warpo::frontend
