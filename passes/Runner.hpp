#pragma once

#include "wasm-features.h"
#include "wasm.h"

namespace warpo::passes {

inline constexpr uint32_t features = wasm::FeatureSet::BulkMemoryOpt | wasm::FeatureSet::SignExt |
                                     wasm::FeatureSet::MutableGlobals | wasm::FeatureSet::TruncSat;

std::unique_ptr<wasm::Module> loadWasm(const std::vector<char> &input);

std::unique_ptr<wasm::Module> loadWat(std::string_view wat);

} // namespace warpo::passes
