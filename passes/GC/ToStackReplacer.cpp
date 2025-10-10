// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <map>
#include <memory>
#include <optional>

#include "GCInfo.hpp"
#include "StackAssigner.hpp"
#include "ToStackReplacer.hpp"
#include "support/index.h"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "ToStackReplacer"

namespace warpo::passes::gc {

void ToStackReplacer::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition const &stackPosition = stackPositions_->at(func);
  replaceToStackCallExpr(m, func, stackPosition);
}

void ToStackReplacer::replaceToStackCallExpr(wasm::Module *m, wasm::Function *func,
                                             StackPosition const &stackPosition) {
  struct CallReplacer : public wasm::PostWalker<CallReplacer> {
    StackPosition const &stackPosition_;
    wasm::Function *func_;
    std::optional<wasm::Index> tempLocalIndex_;
    explicit CallReplacer(StackPosition const &input, wasm::Function *func) : stackPosition_(input), func_(func) {}
    void visitCall(wasm::Call *expr) {
      if (expr->target != FnLocalToStack && expr->target != FnTmpToStack)
        return;
      assert(expr->operands.size() == 1);

      auto it = stackPosition_.find(expr);
      if (it == stackPosition_.end()) {
        // no need to tostack
        replaceCurrent(expr->operands.front());
      } else {
        wasm::Module *const m = getModule();
        uint32_t const offset = it->second;
        wasm::Builder b{*m};
        wasm::Name const memoryName = m->memories.front()->name;
        wasm::Index const tempLocalIndex = ensureTempLocal();
        wasm::Block *const newExpr = b.makeBlock(
            {
                b.makeLocalSet(tempLocalIndex, expr->operands.front()),
                b.makeStore(4, offset, 1, b.makeGlobalGet(VarStackPointer, wasm::Type::i32),
                            b.makeLocalGet(tempLocalIndex, wasm::Type::i32), wasm::Type::i32, memoryName),
                b.makeLocalGet(tempLocalIndex, wasm::Type::i32),
            },
            wasm::Type::i32);
        replaceCurrent(newExpr);
      }
    }
    wasm::Index ensureTempLocal() {
      if (!tempLocalIndex_)
        tempLocalIndex_ = wasm::Builder::addVar(func_, wasm::Type::i32);
      return *tempLocalIndex_;
    }
  };
  CallReplacer callReplacer{stackPosition, func};
  callReplacer.walkFunctionInModule(func, m);
}

} // namespace warpo::passes::gc
