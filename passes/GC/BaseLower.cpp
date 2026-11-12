// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "BaseLower.hpp"
#include "GCInfo.hpp"
#include "literal.h"
#include "wasm-builder.h"
#include "wasm-type.h"
#include "wasm.h"

void warpo::passes::gc::addStackStackOperationFunction(wasm::Module *m) {
  wasm::Builder b{*m};
  wasm::Type const i32 = wasm::Type::i32;

  wasm::Expression *const clearStack = b.makeCall(
      FnMemoryFill,
      {b.makeGlobalGet(VarStackPointer, i32), b.makeConst(wasm::Literal::makeZero(i32)), b.makeLocalGet(0, i32)},
      wasm::Type::none);

  m->addFunction(wasm::Builder::makeFunction(
      FnDecreaseSP, wasm::Signature(i32, wasm::Type::none), {},
      b.makeBlock({
          b.makeGlobalSet(VarStackPointer, b.makeBinary(wasm::BinaryOp::SubInt32, b.makeGlobalGet(VarStackPointer, i32),
                                                        b.makeLocalGet(0, i32))),
          clearStack,
          b.makeIf(b.makeBinary(wasm::BinaryOp::LtSInt32, b.makeGlobalGet(VarStackPointer, i32),
                                b.makeGlobalGet(VarDataEnd, i32)),
                   b.makeUnreachable()),

      })));
  m->addFunction(wasm::Builder::makeFunction(
      FnIncreaseSP, wasm::Signature(i32, wasm::Type::none), {},
      b.makeBlock({
          b.makeGlobalSet(VarStackPointer, b.makeBinary(wasm::BinaryOp::AddInt32, b.makeGlobalGet(VarStackPointer, i32),
                                                        b.makeLocalGet(0, i32))),

      })));
}

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "../Runner.hpp"
#include "pass.h"
#include "wasm-validator.h"

namespace warpo::passes::gc::ut {

TEST(BaseLowerTest, StackClearingCallsFrontendMemoryFill) {
  for (bool const bulkMemory : {false, true}) {
    SCOPED_TRACE(bulkMemory);
    auto m = loadWat(R"(
            (module
                (memory 1)
                (global $~lib/memory/__stack_pointer (mut i32) (i32.const 1024))
                (global $~lib/memory/__data_end i32 (i32.const 16))
                (func $~lib/memory/memory.fill (param i32 i32 i32))
            )
        )");
    m->features.setBulkMemoryOpt(bulkMemory);
    addStackStackOperationFunction(m.get());

    auto *const body = m->getFunction(FnDecreaseSP)->body->cast<wasm::Block>();
    auto *const call = body->list[1]->cast<wasm::Call>();
    EXPECT_EQ(call->target, FnMemoryFill);
    ASSERT_EQ(call->operands.size(), 3U);
    EXPECT_EQ(call->operands[0]->cast<wasm::GlobalGet>()->name, VarStackPointer);
    EXPECT_EQ(call->operands[1]->cast<wasm::Const>()->value.geti32(), 0);
    EXPECT_EQ(call->operands[2]->cast<wasm::LocalGet>()->index, 0U);
    ASSERT_TRUE(wasm::WasmValidator{}.validate(*m));
    wasm::PassRunner runner{m.get()};
    runner.add("optimize-instructions");
    runner.run();
    EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
    EXPECT_EQ(m->features.hasBulkMemoryOpt(), bulkMemory);
  }
}

} // namespace warpo::passes::gc::ut

#endif
