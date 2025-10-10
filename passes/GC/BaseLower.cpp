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
  wasm::Name const memoryName = m->memories.front()->name;
  wasm::Type const i32 = wasm::Type::i32;

  m->addFunction(wasm::Builder::makeFunction(
      FnDecreaseSP, wasm::Signature(i32, wasm::Type::none), {},
      b.makeBlock({
          b.makeGlobalSet(VarStackPointer, b.makeBinary(wasm::BinaryOp::SubInt32, b.makeGlobalGet(VarStackPointer, i32),
                                                        b.makeLocalGet(0, i32))),
          b.makeMemoryFill(b.makeGlobalGet(VarStackPointer, i32), b.makeConst(wasm::Literal::makeZero(i32)),
                           b.makeLocalGet(0, i32), memoryName),
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
