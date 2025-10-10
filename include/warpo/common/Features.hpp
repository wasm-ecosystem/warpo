// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstdint>

namespace warpo::common {

class Features {
  enum class FeaturesEnum : uint32_t {
    None = 0,
    MutableGlobals = 1U << 0U,
    SignExtension = 1U << 1U,
    NontrappingF2I = 1U << 2U,
    BulkMemory = 1U << 3U,
    All = static_cast<uint32_t>(-1),
  };

  FeaturesEnum features;

  constexpr explicit Features(FeaturesEnum features) : features(features) {}

public:
  static Features fromCLI();
  constexpr static Features none() { return Features{FeaturesEnum::None}; }
  constexpr static Features all() { return Features{FeaturesEnum::All}; }
  constexpr static Features mutableGlobals() { return Features{FeaturesEnum::MutableGlobals}; }
  constexpr static Features signExtension() { return Features{FeaturesEnum::SignExtension}; }
  constexpr static Features nontrappingF2I() { return Features{FeaturesEnum::NontrappingF2I}; }
  constexpr static Features bulkMemory() { return Features{FeaturesEnum::BulkMemory}; }

  Features operator|(Features other) const {
    return Features{static_cast<FeaturesEnum>(static_cast<uint32_t>(features) | static_cast<uint32_t>(other.features))};
  }
  Features operator&(Features other) const {
    return Features{static_cast<FeaturesEnum>(static_cast<uint32_t>(features) & static_cast<uint32_t>(other.features))};
  }
  Features operator~() const { return Features{static_cast<FeaturesEnum>(~static_cast<uint32_t>(features))}; }
  bool operator==(Features const &other) const { return features == other.features; }
  bool operator!=(Features const &other) const { return features != other.features; }

  bool has(Features feature) const { return (*this & feature) == feature; }

  uint32_t toASFeaturesFlags() const;

  uint32_t toBinaryenFeatureSet() const;
};

} // namespace warpo::common
