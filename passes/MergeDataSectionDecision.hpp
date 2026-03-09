// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>

namespace warpo::passes {

enum class MergeDataSectionDecisionReason {
  InvalidOrder,
  Overlap,
  Adjacent,
  CrossGapBenefitPositive,
  CrossGapBenefitNonPositive,
};

struct MergeDataSectionDecisionInput {
  std::uint64_t a0;
  std::uint64_t aSize;
  std::uint64_t b0;
  std::uint64_t bSize;
  std::int64_t estimatedKeepSize;
  std::int64_t estimatedMergeSize;
};

struct MergeDataSectionDecisionResult {
  bool shouldMerge;
  MergeDataSectionDecisionReason reason;
  std::int64_t benefit;
};

MergeDataSectionDecisionResult decideMergeDataSection(MergeDataSectionDecisionInput const &input);

char const *toString(MergeDataSectionDecisionReason reason);

} // namespace warpo::passes
