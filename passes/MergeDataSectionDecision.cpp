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

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

namespace warpo::passes::ut {

TEST(MergeDataSectionDecisionTest, OverlapAlwaysMerge) {
  MergeDataSectionDecisionInput const input{
      .a0 = 100,
      .aSize = 10,
      .b0 = 105,
      .bSize = 7,
      .estimatedKeepSize = 0,
      .estimatedMergeSize = 0,
  };

  MergeDataSectionDecisionResult const result = decideMergeDataSection(input);

  EXPECT_TRUE(result.shouldMerge);
  EXPECT_EQ(result.reason, MergeDataSectionDecisionReason::Overlap);
  EXPECT_EQ(result.benefit, 0);
}

TEST(MergeDataSectionDecisionTest, AdjacentAlwaysMerge) {
  MergeDataSectionDecisionInput const input{
      .a0 = 42,
      .aSize = 8,
      .b0 = 50,
      .bSize = 3,
      .estimatedKeepSize = 0,
      .estimatedMergeSize = 0,
  };

  MergeDataSectionDecisionResult const result = decideMergeDataSection(input);

  EXPECT_TRUE(result.shouldMerge);
  EXPECT_EQ(result.reason, MergeDataSectionDecisionReason::Adjacent);
  EXPECT_EQ(result.benefit, 0);
}

TEST(MergeDataSectionDecisionTest, CrossGapPositiveBenefitMerges) {
  MergeDataSectionDecisionInput const input{
      .a0 = 0,
      .aSize = 4,
      .b0 = 9,
      .bSize = 4,
      .estimatedKeepSize = 40,
      .estimatedMergeSize = 30,
  };

  MergeDataSectionDecisionResult const result = decideMergeDataSection(input);

  EXPECT_TRUE(result.shouldMerge);
  EXPECT_EQ(result.reason, MergeDataSectionDecisionReason::CrossGapBenefitPositive);
  EXPECT_EQ(result.benefit, 10);
}

TEST(MergeDataSectionDecisionTest, CrossGapZeroOrNegativeBenefitDoesNotMerge) {
  MergeDataSectionDecisionInput const zeroBenefitInput{
      .a0 = 0,
      .aSize = 4,
      .b0 = 10,
      .bSize = 4,
      .estimatedKeepSize = 25,
      .estimatedMergeSize = 25,
  };
  MergeDataSectionDecisionInput const negativeBenefitInput{
      .a0 = 0,
      .aSize = 4,
      .b0 = 10,
      .bSize = 4,
      .estimatedKeepSize = 20,
      .estimatedMergeSize = 25,
  };

  MergeDataSectionDecisionResult const zeroBenefitResult = decideMergeDataSection(zeroBenefitInput);
  MergeDataSectionDecisionResult const negativeBenefitResult = decideMergeDataSection(negativeBenefitInput);

  EXPECT_FALSE(zeroBenefitResult.shouldMerge);
  EXPECT_EQ(zeroBenefitResult.reason, MergeDataSectionDecisionReason::CrossGapBenefitNonPositive);
  EXPECT_EQ(zeroBenefitResult.benefit, 0);

  EXPECT_FALSE(negativeBenefitResult.shouldMerge);
  EXPECT_EQ(negativeBenefitResult.reason, MergeDataSectionDecisionReason::CrossGapBenefitNonPositive);
  EXPECT_EQ(negativeBenefitResult.benefit, -5);
}

TEST(MergeDataSectionDecisionTest, InvalidOrderingDoesNotMerge) {
  MergeDataSectionDecisionInput const input{
      .a0 = 100,
      .aSize = 5,
      .b0 = 99,
      .bSize = 7,
      .estimatedKeepSize = 0,
      .estimatedMergeSize = 0,
  };

  MergeDataSectionDecisionResult const result = decideMergeDataSection(input);

  EXPECT_FALSE(result.shouldMerge);
  EXPECT_EQ(result.reason, MergeDataSectionDecisionReason::InvalidOrder);
  EXPECT_EQ(result.benefit, 0);
}

TEST(MergeDataSectionDecisionTest, OverflowOrInvalidSizeDoesNotMerge) {
  MergeDataSectionDecisionInput const overflowAInput{
      .a0 = std::numeric_limits<std::uint64_t>::max() - 1,
      .aSize = 2,
      .b0 = std::numeric_limits<std::uint64_t>::max() - 1,
      .bSize = 1,
      .estimatedKeepSize = 0,
      .estimatedMergeSize = 0,
  };
  MergeDataSectionDecisionInput const overflowBInput{
      .a0 = 0,
      .aSize = 1,
      .b0 = std::numeric_limits<std::uint64_t>::max() - 2,
      .bSize = 3,
      .estimatedKeepSize = 0,
      .estimatedMergeSize = 0,
  };

  MergeDataSectionDecisionResult const overflowAResult = decideMergeDataSection(overflowAInput);
  MergeDataSectionDecisionResult const overflowBResult = decideMergeDataSection(overflowBInput);

  EXPECT_FALSE(overflowAResult.shouldMerge);
  EXPECT_EQ(overflowAResult.reason, MergeDataSectionDecisionReason::Overflow);
  EXPECT_EQ(overflowAResult.benefit, 0);

  EXPECT_FALSE(overflowBResult.shouldMerge);
  EXPECT_EQ(overflowBResult.reason, MergeDataSectionDecisionReason::Overflow);
  EXPECT_EQ(overflowBResult.benefit, 0);
}

} // namespace warpo::passes::ut

#endif
