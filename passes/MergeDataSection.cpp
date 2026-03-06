// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <cstdint>
#include <limits>
#include <llvm/Support/LEB128.h>
#include <memory>
#include <optional>
#include <vector>

#include "MergeDataSection.hpp"
#include "MergeDataSectionDecision.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes {
namespace {

std::optional<std::uint64_t> checkedAdd(std::uint64_t const lhs, std::uint64_t const rhs) {
  if (std::numeric_limits<std::uint64_t>::max() - lhs < rhs)
    return std::nullopt;
  return lhs + rhs;
}

std::optional<std::uint64_t> checkedSub(std::uint64_t const lhs, std::uint64_t const rhs) {
  if (lhs < rhs)
    return std::nullopt;
  return lhs - rhs;
}

std::optional<std::int64_t> toInt64(std::uint64_t const value) {
  if (value > static_cast<std::uint64_t>(std::numeric_limits<std::int64_t>::max()))
    return std::nullopt;
  return static_cast<std::int64_t>(value);
}

std::uint64_t ulebSize(std::uint64_t value) { return static_cast<std::uint64_t>(llvm::getULEB128Size(value)); }

std::uint64_t slebSize(std::int64_t value) { return static_cast<std::uint64_t>(llvm::getSLEB128Size(value)); }

std::optional<std::uint32_t> findMemoryIndex(wasm::Module const &module, wasm::Name const &name) {
  for (std::size_t i = 0; i < module.memories.size(); ++i) {
    if (module.memories[i]->name == name) {
      if (i > static_cast<std::size_t>(std::numeric_limits<std::uint32_t>::max()))
        return std::nullopt;
      return static_cast<std::uint32_t>(i);
    }
  }
  return std::nullopt;
}

std::optional<std::uint64_t> estimateActiveSegmentBinarySize(wasm::Module const &module, wasm::Name const &memory,
                                                             std::int64_t const offset,
                                                             std::uint64_t const payloadSize) {
  std::optional<std::uint32_t> const memoryIndex = findMemoryIndex(module, memory);
  if (!memoryIndex.has_value())
    return std::nullopt;

  std::uint64_t size = 0;

  // Flags: 0 when memory index is 0, 2 when explicit memory index is present.
  size += ulebSize(*memoryIndex == 0U ? 0U : 2U);
  if (*memoryIndex != 0U)
    size += ulebSize(*memoryIndex);

  // Offset expression: i32.const/i64.const opcode + immediate + end opcode.
  size += 1U;
  size += slebSize(offset);
  size += 1U;

  size += ulebSize(payloadSize);
  std::optional<std::uint64_t> const total = checkedAdd(size, payloadSize);
  if (!total.has_value())
    return std::nullopt;

  return *total;
}

std::optional<std::int64_t> estimateKeepBinarySize(wasm::Module const &module, wasm::DataSegment const &a,
                                                   std::int64_t const a0, wasm::DataSegment const &b,
                                                   std::int64_t const b0) {
  std::optional<std::uint64_t> const aSize =
      estimateActiveSegmentBinarySize(module, a.memory, a0, static_cast<std::uint64_t>(a.data.size()));
  std::optional<std::uint64_t> const bSize =
      estimateActiveSegmentBinarySize(module, b.memory, b0, static_cast<std::uint64_t>(b.data.size()));
  if (!aSize.has_value() || !bSize.has_value())
    return std::nullopt;

  std::optional<std::uint64_t> const total = checkedAdd(*aSize, *bSize);
  if (!total.has_value())
    return std::nullopt;

  return toInt64(*total);
}

std::optional<std::int64_t> estimateMergedBinarySize(wasm::Module const &module, wasm::DataSegment const &a,
                                                     std::int64_t const a0, std::uint64_t const mergedPayloadSize) {
  std::optional<std::uint64_t> const size = estimateActiveSegmentBinarySize(module, a.memory, a0, mergedPayloadSize);
  if (!size.has_value())
    return std::nullopt;
  return toInt64(*size);
}

struct SegmentInfo {
  std::int64_t offset;
  std::uint64_t size;
  std::uint64_t end;
};

std::optional<SegmentInfo> getSegmentInfo(wasm::DataSegment const &segment) {
  if (segment.isPassive)
    return std::nullopt;

  wasm::Const const *const offset = segment.offset != nullptr ? segment.offset->dynCast<wasm::Const>() : nullptr;
  if (offset == nullptr || !offset->value.type.isInteger())
    return std::nullopt;

  std::uint64_t const start = offset->value.getUnsigned();
  std::uint64_t const dataSize = static_cast<std::uint64_t>(segment.data.size());
  std::optional<std::uint64_t> const end = checkedAdd(start, dataSize);
  if (!end.has_value())
    return std::nullopt;

  if (start > static_cast<std::uint64_t>(std::numeric_limits<std::int64_t>::max()))
    return std::nullopt;

  return SegmentInfo{
      .offset = static_cast<std::int64_t>(start),
      .size = dataSize,
      .end = *end,
  };
}

bool tryMergePair(wasm::Module &module, std::unique_ptr<wasm::DataSegment> &first, wasm::DataSegment const &second) {
  if (first->memory != second.memory)
    return false;

  std::optional<SegmentInfo> const a = getSegmentInfo(*first);
  std::optional<SegmentInfo> const b = getSegmentInfo(second);
  if (!a.has_value() || !b.has_value())
    return false;

  if (b->offset < a->offset)
    return false;

  std::optional<std::uint64_t> const offsetDiff =
      checkedSub(static_cast<std::uint64_t>(b->offset), static_cast<std::uint64_t>(a->offset));
  if (!offsetDiff.has_value())
    return false;

  std::uint64_t const mergedEnd = std::max(a->end, b->end);
  std::optional<std::uint64_t> const mergedSize = checkedSub(mergedEnd, static_cast<std::uint64_t>(a->offset));
  if (!mergedSize.has_value())
    return false;

  std::optional<std::int64_t> const estimatedKeepSize =
      estimateKeepBinarySize(module, *first, a->offset, second, b->offset);
  std::optional<std::int64_t> const estimatedMergeSize =
      estimateMergedBinarySize(module, *first, a->offset, *mergedSize);
  if (!estimatedKeepSize.has_value() || !estimatedMergeSize.has_value())
    return false;

  MergeDataSectionDecisionResult const decision = decideMergeDataSection({
      .a0 = static_cast<std::uint64_t>(a->offset),
      .aSize = a->size,
      .b0 = static_cast<std::uint64_t>(b->offset),
      .bSize = b->size,
      .estimatedKeepSize = *estimatedKeepSize,
      .estimatedMergeSize = *estimatedMergeSize,
  });
  if (!decision.shouldMerge)
    return false;

  std::vector<char> mergedData(*mergedSize, 0);
  std::copy(first->data.begin(), first->data.end(), mergedData.begin());

  auto secondBegin = mergedData.begin() + static_cast<std::ptrdiff_t>(*offsetDiff);
  std::copy(second.data.begin(), second.data.end(), secondBegin);

  first->data = std::move(mergedData);
  return true;
}

class MergeDataSection : public wasm::Pass {
public:
  std::unique_ptr<Pass> create() override { return std::make_unique<MergeDataSection>(); }
  bool modifiesBinaryenIR() override { return true; }

  void run(wasm::Module *module) override {
    if (module->dataSegments.size() < 2)
      return;

    bool changed = false;
    for (std::size_t i = 0; i + 1 < module->dataSegments.size();) {
      std::unique_ptr<wasm::DataSegment> &first = module->dataSegments[i];
      std::unique_ptr<wasm::DataSegment> const &second = module->dataSegments[i + 1];
      if (!tryMergePair(*module, first, *second)) {
        i++;
        continue;
      }

      module->dataSegments.erase(module->dataSegments.begin() + static_cast<std::ptrdiff_t>(i + 1));
      changed = true;
    }

    if (changed)
      module->updateDataSegmentsMap();
  }
};

} // namespace

wasm::Pass *createMergeDataSectionPass() { return new MergeDataSection(); }

} // namespace warpo::passes
