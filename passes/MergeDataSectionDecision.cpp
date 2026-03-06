// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <limits>
#include <optional>

#include "MergeDataSectionDecision.hpp"

namespace {

std::optional<std::uint64_t> checkedAdd(std::uint64_t const lhs, std::uint64_t const rhs) {
  if (std::numeric_limits<std::uint64_t>::max() - lhs < rhs)
    return std::nullopt;
  return lhs + rhs;
}

std::optional<std::int64_t> checkedSub(std::int64_t const lhs, std::int64_t const rhs) {
  __int128 const diff = static_cast<__int128>(lhs) - static_cast<__int128>(rhs);
  if (diff < std::numeric_limits<std::int64_t>::min() || diff > std::numeric_limits<std::int64_t>::max())
    return std::nullopt;
  return static_cast<std::int64_t>(diff);
}

} // namespace

warpo::passes::MergeDataSectionDecisionResult
warpo::passes::decideMergeDataSection(warpo::passes::MergeDataSectionDecisionInput const &input) {
  if (input.b0 < input.a0)
    return {.shouldMerge = false, .reason = warpo::passes::MergeDataSectionDecisionReason::InvalidOrder, .benefit = 0};

  std::optional<std::uint64_t> const a1 = checkedAdd(input.a0, input.aSize);
  std::optional<std::uint64_t> const b1 = checkedAdd(input.b0, input.bSize);
  if (!a1.has_value() || !b1.has_value())
    return {.shouldMerge = false, .reason = warpo::passes::MergeDataSectionDecisionReason::Overflow, .benefit = 0};

  if (input.b0 < *a1)
    return {.shouldMerge = true, .reason = warpo::passes::MergeDataSectionDecisionReason::Overlap, .benefit = 0};

  if (input.b0 == *a1)
    return {.shouldMerge = true, .reason = warpo::passes::MergeDataSectionDecisionReason::Adjacent, .benefit = 0};

  std::optional<std::int64_t> const benefit = checkedSub(input.estimatedKeepSize, input.estimatedMergeSize);
  if (!benefit.has_value())
    return {.shouldMerge = false, .reason = warpo::passes::MergeDataSectionDecisionReason::Overflow, .benefit = 0};

  if (*benefit > 0)
    return {.shouldMerge = true,
            .reason = warpo::passes::MergeDataSectionDecisionReason::CrossGapBenefitPositive,
            .benefit = *benefit};

  return {.shouldMerge = false,
          .reason = warpo::passes::MergeDataSectionDecisionReason::CrossGapBenefitNonPositive,
          .benefit = *benefit};
}

char const *warpo::passes::toString(warpo::passes::MergeDataSectionDecisionReason const reason) {
  switch (reason) {
  case warpo::passes::MergeDataSectionDecisionReason::InvalidOrder:
    return "invalid-order";
  case warpo::passes::MergeDataSectionDecisionReason::Overflow:
    return "overflow";
  case warpo::passes::MergeDataSectionDecisionReason::Overlap:
    return "overlap";
  case warpo::passes::MergeDataSectionDecisionReason::Adjacent:
    return "adjacent";
  case warpo::passes::MergeDataSectionDecisionReason::CrossGapBenefitPositive:
    return "cross-gap-benefit-positive";
  case warpo::passes::MergeDataSectionDecisionReason::CrossGapBenefitNonPositive:
    return "cross-gap-benefit-non-positive";
  }
  return "unknown";
}
