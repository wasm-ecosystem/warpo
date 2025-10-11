// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "warpo/common/Features.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm-features.h"

namespace warpo::common {

static cli::Opt<std::vector<std::string>> disableFeatureOptions{
    cli::Category::Frontend | cli::Category::Optimization,
    "--disable-feature",
    [](argparse::Argument &arg) -> void {
      arg.help("disable mutable-globals, sign-extension, nontrapping-f2i, bulk-memory")
          .nargs(argparse::nargs_pattern::at_least_one)
          .append();
    },
};

Features Features::fromCLI() {
  Features res = Features::all();
  std::vector<std::string> const &disableFeatures = disableFeatureOptions.get();
  for (std::string const &disableFeature : disableFeatures) {
    if (disableFeature == "sign-extension") {
      res = res & ~Features::signExtension();
    } else if (disableFeature == "mutable-globals") {
      res = res & ~Features::mutableGlobals();
    } else if (disableFeature == "nontrapping-f2i") {
      res = res & ~Features::nontrappingF2I();
    } else if (disableFeature == "bulk-memory") {
      res = res & ~Features::bulkMemory();
    } else {
      throw std::runtime_error("unknown feature: " + disableFeature);
    }
  }
  return res;
}

namespace {
// sync from assemblyscript/std/assembly/shared/feature.ts
enum class ASFeatures : uint32_t {
  None = 0,
  SignExtension = 1U << 0U,  // see: https://github.com/WebAssembly/sign-extension-ops
  MutableGlobals = 1U << 1U, // see: https://github.com/WebAssembly/mutable-global
  NontrappingF2I = 1U << 2U, // see: https://github.com/WebAssembly/nontrapping-float-to-int-conversions
  BulkMemory = 1U << 3U,     // see: https://github.com/WebAssembly/bulk-memory-operations
  All = (1U << 15U) - 1U
};
} // namespace

uint32_t Features::toASFeaturesFlags() const {
  uint32_t flags = 0U;
  if (has(Features::signExtension()))
    flags |= static_cast<uint32_t>(ASFeatures::SignExtension);
  if (has(Features::mutableGlobals()))
    flags |= static_cast<uint32_t>(ASFeatures::MutableGlobals);
  if (has(Features::nontrappingF2I()))
    flags |= static_cast<uint32_t>(ASFeatures::NontrappingF2I);
  if (has(Features::bulkMemory()))
    flags |= static_cast<uint32_t>(ASFeatures::BulkMemory);
  return flags;
}

uint32_t Features::toBinaryenFeatureSet() const {
  wasm::FeatureSet features = wasm::FeatureSet::None;
  if (has(Features::signExtension()))
    features |= wasm::FeatureSet::SignExt;
  if (has(Features::mutableGlobals()))
    features |= wasm::FeatureSet::MutableGlobals;
  if (has(Features::nontrappingF2I()))
    features |= wasm::FeatureSet::TruncSat;
  if (has(Features::bulkMemory()))
    features |= wasm::FeatureSet::BulkMemoryOpt;
  return features.features;
}

} // namespace warpo::common
