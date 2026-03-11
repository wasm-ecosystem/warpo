// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <cstdint>
#include <fmt/base.h>
#include <limits>
#include <llvm/Support/LEB128.h>
#include <memory>
#include <optional>
#include <vector>

#include "MergeDataSection.hpp"
#include "pass.h"
#include "warpo/support/Debug.hpp"
#include "warpo/support/Unreachable.hpp"
#include "wasm.h"

#define PASS_NAME "MergeDataSection"

namespace warpo::passes {

enum class MergeDataSectionDecisionReason {
  InvalidOrder,
  Overlap,
  Adjacent,
  CrossGapBenefitPositive,
  CrossGapBenefitNonPositive,
};

struct MergeDataSectionDecisionInput {
  uint64_t a0;
  uint64_t aSize;
  uint64_t b0;
  uint64_t bSize;
  uint64_t estimatedKeepSize;
  uint64_t estimatedMergeSize;
};

struct MergeDataSectionDecisionResult {
  bool shouldMerge;
  MergeDataSectionDecisionReason reason;
  int64_t benefit;
};

static char const *toString(MergeDataSectionDecisionReason const reason) {
  switch (reason) {
    case MergeDataSectionDecisionReason::InvalidOrder:
      return "invalid-order";
    case MergeDataSectionDecisionReason::Overlap:
      return "overlap";
    case MergeDataSectionDecisionReason::Adjacent:
      return "adjacent";
    case MergeDataSectionDecisionReason::CrossGapBenefitPositive:
      return "cross-gap-benefit-positive";
    case MergeDataSectionDecisionReason::CrossGapBenefitNonPositive:
      return "cross-gap-benefit-non-positive";
  }
  WARPO_UNREACHABLE;
}

static char const *describeReason(MergeDataSectionDecisionReason const reason) {
  switch (reason) {
    case MergeDataSectionDecisionReason::InvalidOrder:
      return "second block is before first block";
    case MergeDataSectionDecisionReason::Overlap:
      return "blocks overlap in memory, merged payload avoids duplicate active segment encoding";
    case MergeDataSectionDecisionReason::Adjacent:
      return "blocks are contiguous, merged payload keeps layout and removes one segment header";
    case MergeDataSectionDecisionReason::CrossGapBenefitPositive:
      return "cross-gap merge reduces estimated binary size more than keeping two segments";
    case MergeDataSectionDecisionReason::CrossGapBenefitNonPositive:
      return "cross-gap merge does not reduce estimated binary size";
  }
  WARPO_UNREACHABLE;
}

MergeDataSectionDecisionResult decideMergeDataSection(MergeDataSectionDecisionInput const &input) {
  if (input.b0 < input.a0)
    return {.shouldMerge = false, .reason = MergeDataSectionDecisionReason::InvalidOrder, .benefit = 0};

  uint64_t const a1 = input.a0 + input.aSize;

  if (input.b0 < a1)
    return {.shouldMerge = true, .reason = MergeDataSectionDecisionReason::Overlap, .benefit = 0};

  if (input.b0 == a1)
    return {.shouldMerge = true, .reason = MergeDataSectionDecisionReason::Adjacent, .benefit = 0};

  uint64_t const absDiff = input.estimatedKeepSize >= input.estimatedMergeSize
                               ? input.estimatedKeepSize - input.estimatedMergeSize
                               : input.estimatedMergeSize - input.estimatedKeepSize;
  int64_t const boundedDiff = absDiff > static_cast<uint64_t>(std::numeric_limits<int64_t>::max())
                                  ? std::numeric_limits<int64_t>::max()
                                  : static_cast<int64_t>(absDiff);
  int64_t const benefit = input.estimatedKeepSize >= input.estimatedMergeSize ? boundedDiff : -boundedDiff;

  if (benefit > 0)
    return {.shouldMerge = true, .reason = MergeDataSectionDecisionReason::CrossGapBenefitPositive, .benefit = benefit};

  return {
      .shouldMerge = false, .reason = MergeDataSectionDecisionReason::CrossGapBenefitNonPositive, .benefit = benefit};
}

static uint64_t ulebSize(uint64_t value) { return static_cast<uint64_t>(llvm::getULEB128Size(value)); }

static uint64_t slebSize(int64_t value) { return static_cast<uint64_t>(llvm::getSLEB128Size(value)); }

static uint32_t findMemoryIndex(wasm::Module const &m, wasm::Name const &name) {
  for (uint32_t i = 0; i < m.memories.size(); ++i) {
    if (m.memories[i]->name == name)
      return i;
  }
  WARPO_UNREACHABLE;
}

static uint64_t estimateActiveSegmentBinarySize(wasm::Module const &m, wasm::Name const &memory, uint64_t const offset,
                                                uint64_t const payloadSize) {
  uint32_t const memoryIndex = findMemoryIndex(m, memory);
  uint64_t size = 0;

  // Flags: 0 when memory index is 0, 2 when explicit memory index is present.
  size += ulebSize(memoryIndex == 0U ? 0U : 2U);
  if (memoryIndex != 0U)
    size += ulebSize(memoryIndex);

  // Offset expression: i32.const/i64.const opcode + immediate + end opcode.
  size += 1U;
  size += slebSize(static_cast<int64_t>(offset));
  size += 1U;

  size += ulebSize(payloadSize);
  return size + payloadSize;
}

static uint64_t estimateKeepBinarySize(wasm::Module const &m, wasm::DataSegment const &a, uint64_t const a0,
                                       wasm::DataSegment const &b, uint64_t const b0) {
  uint64_t const aSize = estimateActiveSegmentBinarySize(m, a.memory, a0, static_cast<uint64_t>(a.data.size()));
  uint64_t const bSize = estimateActiveSegmentBinarySize(m, b.memory, b0, static_cast<uint64_t>(b.data.size()));

  // when aSize and bSize are both large, we definitely can merge them.
  if (aSize > std::numeric_limits<uint64_t>::max() - bSize)
    return std::numeric_limits<uint64_t>::max();
  return aSize + bSize;
}

static uint64_t estimateMergedBinarySize(wasm::Module const &m, wasm::DataSegment const &a, uint64_t const a0,
                                         uint64_t const mergedPayloadSize) {
  return estimateActiveSegmentBinarySize(m, a.memory, a0, mergedPayloadSize);
}

struct SegmentInfo {
  uint64_t offset;
  uint64_t size;
  uint64_t end;
};

static std::optional<SegmentInfo> getSegmentInfo(wasm::DataSegment const &segment) {
  if (segment.isPassive)
    return std::nullopt;

  wasm::Const const *const offset = segment.offset != nullptr ? segment.offset->dynCast<wasm::Const>() : nullptr;
  if (offset == nullptr || !offset->value.type.isInteger())
    return std::nullopt;

  uint64_t const start = offset->value.getUnsigned();
  uint64_t const dataSize = static_cast<uint64_t>(segment.data.size());
  uint64_t const end = start + dataSize;

  if (start > static_cast<uint64_t>(std::numeric_limits<int64_t>::max()))
    return std::nullopt;

  return SegmentInfo{
      .offset = start,
      .size = dataSize,
      .end = end,
  };
}

static bool tryMergePair(wasm::Module &m, std::unique_ptr<wasm::DataSegment> &first, wasm::DataSegment const &second) {
  if (first->memory != second.memory)
    return false;

  std::optional<SegmentInfo> const a = getSegmentInfo(*first);
  std::optional<SegmentInfo> const b = getSegmentInfo(second);
  if (!a.has_value() || !b.has_value())
    return false;

  if (b->offset < a->offset)
    return false;

  uint64_t const offsetDiff = b->offset - a->offset;

  uint64_t const mergedEnd = std::max(a->end, b->end);
  uint64_t const mergedSize = mergedEnd - a->offset;

  uint64_t const estimatedKeepSize = estimateKeepBinarySize(m, *first, a->offset, second, b->offset);
  uint64_t const estimatedMergeSize = estimateMergedBinarySize(m, *first, a->offset, mergedSize);

  MergeDataSectionDecisionResult const decision = decideMergeDataSection({
      .a0 = a->offset,
      .aSize = a->size,
      .b0 = b->offset,
      .bSize = b->size,
      .estimatedKeepSize = estimatedKeepSize,
      .estimatedMergeSize = estimatedMergeSize,
  });
  if (!decision.shouldMerge)
    return false;

  if (support::isDebug(PASS_NAME)) {
    fmt::println("[" PASS_NAME "] merged data block [{}..{}) + [{}..{}) reason={} because={} "
                 "(keepSize={}, mergeSize={}, benefit={})",
                 a->offset,
                 a->end,
                 b->offset,
                 b->end,
                 toString(decision.reason),
                 describeReason(decision.reason),
                 estimatedKeepSize,
                 estimatedMergeSize,
                 decision.benefit);
  }

  std::vector<char> mergedData(mergedSize, 0);
  std::copy(first->data.begin(), first->data.end(), mergedData.begin());

  auto secondBegin = mergedData.begin() + static_cast<std::ptrdiff_t>(offsetDiff);
  std::copy(second.data.begin(), second.data.end(), secondBegin);

  first->data = std::move(mergedData);
  return true;
}

static bool shouldSkipMergeDataSection(wasm::Module const &m) {
  return m.features.hasMultiMemory() || m.features.hasExtendedConst();
}

class MergeDataSection : public wasm::Pass {
public:
  std::unique_ptr<Pass> create() override { return std::make_unique<MergeDataSection>(); }
  bool modifiesBinaryenIR() override { return true; }

  void run(wasm::Module *m) override {
    if (shouldSkipMergeDataSection(*m))
      return;

    if (m->dataSegments.size() < 2)
      return;

    bool changed = false;
    for (std::size_t i = 0; i + 1 < m->dataSegments.size();) {
      std::unique_ptr<wasm::DataSegment> &first = m->dataSegments[i];
      std::unique_ptr<wasm::DataSegment> const &second = m->dataSegments[i + 1];
      if (!tryMergePair(*m, first, *second)) {
        i++;
        continue;
      }

      m->dataSegments.erase(m->dataSegments.begin() + static_cast<std::ptrdiff_t>(i + 1));
      changed = true;
    }

    if (changed)
      m->updateDataSegmentsMap();
  }
};

wasm::Pass *createMergeDataSectionPass() { return new MergeDataSection(); }

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"

namespace warpo::passes::ut {

static void runMergeDataSection(wasm::Module *const m) {
  std::unique_ptr<wasm::Pass> const pass{createMergeDataSectionPass()};
  pass->run(m);
}

static uint64_t getConstOffset(wasm::DataSegment const &segment) {
  wasm::Const const *const offset = segment.offset != nullptr ? segment.offset->dynCast<wasm::Const>() : nullptr;
  EXPECT_NE(offset, nullptr);
  if (offset == nullptr)
    return 0U;
  return offset->value.getUnsigned();
}

static std::string payload(wasm::DataSegment const &segment) { return {segment.data.begin(), segment.data.end()}; }

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

TEST(MergeDataSectionPassTest, AdjacentMerge) {
  auto m = loadWat(R"(
    (module
      (memory $m0 1)
      (data (i32.const 0) "AB")
      (data (i32.const 2) "CD")
    )
  )");

  runMergeDataSection(m.get());

  ASSERT_EQ(m->dataSegments.size(), 1U);
  EXPECT_EQ(getConstOffset(*m->dataSegments[0]), 0U);
  EXPECT_EQ(payload(*m->dataSegments[0]), "ABCD");
}

TEST(MergeDataSectionPassTest, OverlapMergeOverwritesLaterBytes) {
  auto m = loadWat(R"(
    (module
      (memory $m0 1)
      (data (i32.const 0) "AB_CD")
      (data (i32.const 3) "XY")
    )
  )");

  runMergeDataSection(m.get());

  ASSERT_EQ(m->dataSegments.size(), 1U);
  EXPECT_EQ(getConstOffset(*m->dataSegments[0]), 0U);
  EXPECT_EQ(payload(*m->dataSegments[0]), "AB_XY");
}

TEST(MergeDataSectionPassTest, CrossGapPositiveBenefitMergesAndFillsZeros) {
  auto m = loadWat(R"(
    (module
      (memory $m0 1)
      (data (i32.const 0) "AB")
      (data (i32.const 3) "Z")
    )
  )");

  runMergeDataSection(m.get());

  ASSERT_EQ(m->dataSegments.size(), 1U);
  EXPECT_EQ(getConstOffset(*m->dataSegments[0]), 0U);
  std::string const expected{"AB\0Z", 4U};
  EXPECT_EQ(payload(*m->dataSegments[0]), expected);
}

TEST(MergeDataSectionPassTest, CrossGapNonPositiveBenefitDoesNotMerge) {
  auto m = loadWat(R"(
    (module
      (memory $m0 1)
      (data (i32.const 0) "AB")
      (data (i32.const 40) "Z")
    )
  )");

  runMergeDataSection(m.get());

  ASSERT_EQ(m->dataSegments.size(), 2U);
  EXPECT_EQ(getConstOffset(*m->dataSegments[0]), 0U);
  EXPECT_EQ(payload(*m->dataSegments[0]), "AB");
  EXPECT_EQ(getConstOffset(*m->dataSegments[1]), 40U);
  EXPECT_EQ(payload(*m->dataSegments[1]), "Z");
}

} // namespace warpo::passes::ut

#endif // WARPO_ENABLE_UNIT_TESTS
