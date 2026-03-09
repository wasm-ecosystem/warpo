// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "MergeDataSectionDecision.hpp"

warpo::passes::MergeDataSectionDecisionResult
warpo::passes::decideMergeDataSection(warpo::passes::MergeDataSectionDecisionInput const &input) {
  if (input.b0 < input.a0)
    return {.shouldMerge = false, .reason = warpo::passes::MergeDataSectionDecisionReason::InvalidOrder, .benefit = 0};

  std::uint64_t const a1 = input.a0 + input.aSize;

  if (input.b0 < a1)
    return {.shouldMerge = true, .reason = warpo::passes::MergeDataSectionDecisionReason::Overlap, .benefit = 0};

  if (input.b0 == a1)
    return {.shouldMerge = true, .reason = warpo::passes::MergeDataSectionDecisionReason::Adjacent, .benefit = 0};

  std::int64_t const benefit = input.estimatedKeepSize - input.estimatedMergeSize;

  if (benefit > 0)
    return {.shouldMerge = true,
            .reason = warpo::passes::MergeDataSectionDecisionReason::CrossGapBenefitPositive,
            .benefit = benefit};

  return {.shouldMerge = false,
          .reason = warpo::passes::MergeDataSectionDecisionReason::CrossGapBenefitNonPositive,
          .benefit = benefit};
}

char const *warpo::passes::toString(warpo::passes::MergeDataSectionDecisionReason const reason) {
  switch (reason) {
  case warpo::passes::MergeDataSectionDecisionReason::InvalidOrder:
    return "invalid-order";
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

} // namespace warpo::passes::ut

#endif
