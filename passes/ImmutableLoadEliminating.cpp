// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <bit>
#include <cassert>
#include <cstdint>
#include <fmt/base.h>
#include <fmt/format.h>
#include <limits>
#include <memory>
#include <vector>

#include "ImmutableLoadEliminating.hpp"
#include "literal.h"
#include "pass.h"
#include "warpo/common/AsModule.hpp"
#include "warpo/support/Debug.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "ImmutableLoadEliminating"

namespace warpo::passes {

namespace {

struct ImmutableLoadEliminating : public wasm::WalkerPass<wasm::PostWalker<ImmutableLoadEliminating>> {
  explicit ImmutableLoadEliminating(std::shared_ptr<ImmutableDataElementRanges> const &immutableDataRanges)
      : immutableDataRanges_(immutableDataRanges) {}
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override {
    return std::unique_ptr<Pass>{new ImmutableLoadEliminating(immutableDataRanges_)};
  }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override {
    if (immutableDataRanges_ == nullptr)
      return;
    wasm::WalkerPass<wasm::PostWalker<ImmutableLoadEliminating>>::runOnFunction(m, func);
  }

  void visitLoad(wasm::Load *expr) {
    if (expr->type == wasm::Type::unreachable || expr->type == wasm::Type::v128)
      return;
    wasm::Const const *const ptr = expr->ptr->dynCast<wasm::Const>();
    if (ptr == nullptr)
      return;
    uint64_t const ptrValue = static_cast<uint64_t>(ptr->value.getInteger());
    uint64_t const offsetValue = static_cast<uint64_t>(expr->offset.addr);
    uint64_t const loadSize = static_cast<uint64_t>(expr->bytes);

    uint64_t const start = ptrValue + offsetValue;
    uint64_t const end = start + loadSize;
    // out of u32 max range
    if (start < ptrValue || start > std::numeric_limits<uint32_t>::max())
      return;
    if (end < start || end > std::numeric_limits<uint32_t>::max())
      return;
    if (immutableDataRanges_->contains(static_cast<uint32_t>(start), static_cast<uint32_t>(loadSize))) {
      wasm::Literal const loadResult =
          getLoadResult(static_cast<uint32_t>(start), expr->type, static_cast<uint32_t>(loadSize), expr->signed_);
      std::string_view const functionName = getFunction()->name.str;
      if (support::isDebug(PASS_NAME, functionName)) {
        if (expr->type.isFloat())
          fmt::println("[" PASS_NAME "] fn '{}' replaced load at {} (size {}) with const {}", functionName, start,
                       loadSize, loadResult.getFloat());
        if (expr->type.isInteger())
          fmt::println("[" PASS_NAME "] fn '{}' replaced load at {} (size {}) with const {}", functionName, start,
                       loadSize, loadResult.getInteger());
      }
      replaceCurrent(wasm::Builder(*getModule()).makeConst(loadResult));
    }
  }

private:
  std::shared_ptr<ImmutableDataElementRanges> immutableDataRanges_;

  // TODO: optimized
  uint8_t getValueFromDataSegment(uint32_t const addr) {
    wasm::Module const *const m = getModule();
    for (std::unique_ptr<wasm::DataSegment> const &segment : m->dataSegments) {
      wasm::Const const *const segmentOffset = segment->offset->dynCast<wasm::Const>();
      assert(segmentOffset);
      uint64_t const segmentOffsetValue = static_cast<uint64_t>(segmentOffset->value.getInteger());
      uint64_t const segmentSize = static_cast<uint64_t>(segment->data.size());
      if (segmentOffsetValue <= addr && addr < (segmentOffsetValue + segmentSize)) {
        return static_cast<uint8_t>(segment->data[addr - segmentOffsetValue]);
      }
    }
    return 0U;
  }

  wasm::Literal getLoadResult(uint32_t start, wasm::Type type, uint32_t loadSize, bool isSigned) {
    switch (type.getBasic()) {
    case wasm::Type::i32: {
      switch (loadSize) {
      case 1: {
        uint32_t value = static_cast<uint32_t>(getValueFromDataSegment(start + 0U));
        if (isSigned) {
          value = static_cast<uint32_t>(static_cast<int32_t>(static_cast<int8_t>(static_cast<uint8_t>(value))));
        }
        return wasm::Literal{value};
      }
      case 2: {
        uint32_t value = static_cast<uint32_t>(getValueFromDataSegment(start + 0U)) << 0U |
                         static_cast<uint32_t>(getValueFromDataSegment(start + 1U)) << 8U;
        if (isSigned) {
          value = static_cast<uint32_t>(static_cast<int32_t>(static_cast<int16_t>(static_cast<uint16_t>(value))));
        }
        return wasm::Literal{value};
      }
      case 4:
        return wasm::Literal{static_cast<uint32_t>(getValueFromDataSegment(start + 0U)) << 0U |
                             static_cast<uint32_t>(getValueFromDataSegment(start + 1U)) << 8U |
                             static_cast<uint32_t>(getValueFromDataSegment(start + 2U)) << 16U |
                             static_cast<uint32_t>(getValueFromDataSegment(start + 3U)) << 24U};
      default:
        __builtin_trap();
      }
    }
    case wasm::Type::i64: {
      switch (loadSize) {
      case 1: {
        uint64_t value = static_cast<uint64_t>(getValueFromDataSegment(start + 0U));
        if (isSigned) {
          value = static_cast<uint64_t>(static_cast<int64_t>(static_cast<int8_t>(static_cast<uint8_t>(value))));
        }
        return wasm::Literal{value};
      }
      case 2: {
        uint64_t value = static_cast<uint64_t>(getValueFromDataSegment(start + 0U)) << 0U |
                         static_cast<uint64_t>(getValueFromDataSegment(start + 1U)) << 8U;
        if (isSigned) {
          value = static_cast<uint64_t>(static_cast<int64_t>(static_cast<int16_t>(static_cast<uint16_t>(value))));
        }
        return wasm::Literal{value};
      }
      case 4: {
        uint64_t value = static_cast<uint64_t>(getValueFromDataSegment(start + 0U)) << 0U |
                         static_cast<uint64_t>(getValueFromDataSegment(start + 1U)) << 8U |
                         static_cast<uint64_t>(getValueFromDataSegment(start + 2U)) << 16U |
                         static_cast<uint64_t>(getValueFromDataSegment(start + 3U)) << 24U;
        if (isSigned) {
          value = static_cast<uint64_t>(static_cast<int64_t>(static_cast<int32_t>(static_cast<uint32_t>(value))));
        }
        return wasm::Literal{value};
      }
      case 8:
        return wasm::Literal{static_cast<uint64_t>(getValueFromDataSegment(start + 0U)) << 0U |
                             static_cast<uint64_t>(getValueFromDataSegment(start + 1U)) << 8U |
                             static_cast<uint64_t>(getValueFromDataSegment(start + 2U)) << 16U |
                             static_cast<uint64_t>(getValueFromDataSegment(start + 3U)) << 24U |
                             static_cast<uint64_t>(getValueFromDataSegment(start + 4U)) << 32U |
                             static_cast<uint64_t>(getValueFromDataSegment(start + 5U)) << 40U |
                             static_cast<uint64_t>(getValueFromDataSegment(start + 6U)) << 48U |
                             static_cast<uint64_t>(getValueFromDataSegment(start + 7U)) << 56U};
      default:
        __builtin_trap();
      }
    }
    case wasm::Type::f32: {
      assert(loadSize == 4);
      return wasm::Literal{static_cast<uint32_t>(getValueFromDataSegment(start + 0U)) << 0U |
                           static_cast<uint32_t>(getValueFromDataSegment(start + 1U)) << 8U |
                           static_cast<uint32_t>(getValueFromDataSegment(start + 2U)) << 16U |
                           static_cast<uint32_t>(getValueFromDataSegment(start + 3U)) << 24U}
          .castToF32();
    }
    case wasm::Type::f64: {
      assert(loadSize == 8);
      return wasm::Literal{static_cast<uint64_t>(getValueFromDataSegment(start + 0U)) << 0U |
                           static_cast<uint64_t>(getValueFromDataSegment(start + 1U)) << 8U |
                           static_cast<uint64_t>(getValueFromDataSegment(start + 2U)) << 16U |
                           static_cast<uint64_t>(getValueFromDataSegment(start + 3U)) << 24U |
                           static_cast<uint64_t>(getValueFromDataSegment(start + 4U)) << 32U |
                           static_cast<uint64_t>(getValueFromDataSegment(start + 5U)) << 40U |
                           static_cast<uint64_t>(getValueFromDataSegment(start + 6U)) << 48U |
                           static_cast<uint64_t>(getValueFromDataSegment(start + 7U)) << 56U}
          .castToF64();
    }
    default: {
      __builtin_trap();
    }
    }
  }
};

} // namespace

wasm::Pass *createImmutableLoadEliminatingPass(std::shared_ptr<ImmutableDataElementRanges> const &immutableDataRanges) {
  return new ImmutableLoadEliminating(immutableDataRanges);
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "helper/Matcher.hpp"
#include "pass.h"

namespace warpo::passes::ut {
namespace {

struct P0 {
  std::vector<DataElementRange> ranges_;
  bool isReplaced_;
};

struct ImmutableDataRangeTest : public ::testing::TestWithParam<P0> {};

TEST_P(ImmutableDataRangeTest, LoadImmutableData) {
  auto m = loadWat(R"(
    (module
      (memory 1)
      (func $load_immutable_data (result i32)
        i32.const 4
        i32.load offset=0
      )
    )
  )");
  wasm::Function *const f = m->getFunction("load_immutable_data");

  std::shared_ptr<ImmutableDataElementRanges> const ranges{new ImmutableDataElementRanges()};
  for (DataElementRange const &r : GetParam().ranges_) {
    ranges->insert(r);
  }
  ImmutableLoadEliminating const pass{ranges};

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createImmutableLoadEliminatingPass(ranges)});
  runner.run();

  if (GetParam().isReplaced_) {
    auto matcher = matcher::isConst(matcher::const_::v(wasm::Literal{0U}));
    EXPECT_TRUE(matcher(*f->body));
  } else {
    EXPECT_TRUE(f->body->is<wasm::Load>());
  }
}

INSTANTIATE_TEST_SUITE_P(ImmutableLoadEliminatingTest, ImmutableDataRangeTest,
                         ::testing::ValuesIn({
                             P0{.ranges_ = {DataElementRange{4U, 8U}}, .isReplaced_ = true},
                             P0{.ranges_ = {DataElementRange{4U, 7U}}, .isReplaced_ = false},
                             P0{.ranges_ = {DataElementRange{5U, 8U}}, .isReplaced_ = false},
                             P0{.ranges_ = {DataElementRange{0U, 4U}}, .isReplaced_ = false},
                             P0{.ranges_ = {DataElementRange{8U, 12U}}, .isReplaced_ = false},
                             // currently, we don't support merging ranges
                             P0{.ranges_ = {DataElementRange{4U, 6U}, DataElementRange{6U, 8U}}, .isReplaced_ = false},
                         }));

TEST(ImmutableLoadEliminatingTest, Offset) {
  auto m = loadWat(R"(
    (module
      (memory 1)
      (func $load_immutable_data (result i32)
        i32.const 0
        i32.load offset=4
      )
    )
  )");
  wasm::Function *const f = m->getFunction("load_immutable_data");

  std::shared_ptr<ImmutableDataElementRanges> const ranges{new ImmutableDataElementRanges()};
  ranges->insert({4, 8});

  ImmutableLoadEliminating const pass{ranges};

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createImmutableLoadEliminatingPass(ranges)});
  runner.run();

  auto matcher = matcher::isConst(matcher::const_::v(wasm::Literal{0U}));
  EXPECT_TRUE(matcher(*f->body));
}

struct P1 {
  std::string loadInstruction_;
  wasm::Literal value_;
};

struct LoadKindTest : public ::testing::TestWithParam<P1> {};

TEST_P(LoadKindTest, LoadImmutableData) {
  auto m = loadWat(fmt::format(R"(
    (module
      (memory 1)
      (data (i32.const 0) "\F1\F2\F3\F4\F5\F6\F7\F8")
      (func $load_immutable_data
        i32.const 0
        {} offset=0
        drop
      )
    )
  )",
                               GetParam().loadInstruction_));
  wasm::Function *const f = m->getFunction("load_immutable_data");

  std::shared_ptr<ImmutableDataElementRanges> const ranges{new ImmutableDataElementRanges()};
  ranges->insert({0, 8});
  ImmutableLoadEliminating const pass{ranges};

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createImmutableLoadEliminatingPass(ranges)});
  runner.run();

  using namespace matcher;

  auto matcher = isDrop(drop::v(isConst(const_::v(GetParam().value_))));

  EXPECT_TRUE(matcher(*f->body));
}

INSTANTIATE_TEST_SUITE_P(
    ImmutableLoadEliminatingTest, LoadKindTest,
    ::testing::ValuesIn({
        P1{.loadInstruction_ = "i32.load", .value_ = wasm::Literal{static_cast<uint32_t>(0xF4F3F2F1)}},
        P1{.loadInstruction_ = "i32.load8_u", .value_ = wasm::Literal{static_cast<uint32_t>(0xF1)}},
        P1{.loadInstruction_ = "i32.load8_s", .value_ = wasm::Literal{static_cast<int32_t>(static_cast<int8_t>(0xF1))}},
        P1{.loadInstruction_ = "i32.load16_u", .value_ = wasm::Literal{static_cast<uint32_t>(0xF2F1)}},
        P1{.loadInstruction_ = "i32.load16_s",
           .value_ = wasm::Literal{static_cast<int32_t>(static_cast<int16_t>(0xF2F1))}},

        P1{.loadInstruction_ = "i64.load", .value_ = wasm::Literal{static_cast<uint64_t>(0xF8F7F6F5F4F3F2F1)}},
        P1{.loadInstruction_ = "i64.load8_u", .value_ = wasm::Literal{static_cast<uint64_t>(0xF1)}},
        P1{.loadInstruction_ = "i64.load8_s", .value_ = wasm::Literal{static_cast<int64_t>(static_cast<int8_t>(0xF1))}},
        P1{.loadInstruction_ = "i64.load16_u", .value_ = wasm::Literal{static_cast<uint64_t>(0xF2F1)}},
        P1{.loadInstruction_ = "i64.load16_s",
           .value_ = wasm::Literal{static_cast<int64_t>(static_cast<int16_t>(0xF2F1))}},
        P1{.loadInstruction_ = "i64.load32_u", .value_ = wasm::Literal{static_cast<uint64_t>(0xF4F3F2F1)}},
        P1{.loadInstruction_ = "i64.load32_s",
           .value_ = wasm::Literal{static_cast<int64_t>(static_cast<int32_t>(0xF4F3F2F1))}},

        P1{.loadInstruction_ = "f32.load",
           .value_ = wasm::Literal{std::bit_cast<float>(static_cast<uint32_t>(0xF4F3F2F1))}},
        P1{.loadInstruction_ = "f64.load",
           .value_ = wasm::Literal{std::bit_cast<double>(static_cast<uint64_t>(0xF8F7F6F5F4F3F2F1))}},
    }));

} // namespace
} // namespace warpo::passes::ut

#endif