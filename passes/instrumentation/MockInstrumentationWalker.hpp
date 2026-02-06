// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <algorithm>
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <ir/module-utils.h>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>
#include <vector>

#include "binaryen-c.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes::instrumentation {

///
///@brief Mock instrumentation walker class
///
class MockInstrumentationWalker final : public wasm::PostWalker<MockInstrumentationWalker> {
public:
  explicit MockInstrumentationWalker(wasm::Module *const m) noexcept : m(m), b(wasm::Builder(*m)) {
    for (const auto &elemSegment : m->elementSegments) {
      if (elemSegment->type.isFunction()) {
        const auto &data = elemSegment->data;
        const size_t dataSize = data.size();
        for (std::size_t i = 0; i < dataSize; ++i) {
          const wasm::RefFunc *const funcRef = data[i]->cast<wasm::RefFunc>();
          std::string_view functionName = funcRef->func.str;
          const std::string_view nameSuffix = "@varargs";
          if (functionName.size() >= nameSuffix.size() &&
              std::equal(nameSuffix.begin(), nameSuffix.end(), functionName.end() - nameSuffix.size())) {
            functionName.remove_suffix(nameSuffix.size());
          }
          funcRefs[functionName] = std::make_pair(elemSegment->table, static_cast<wasm::Index>(i + 1));
        }
      }
    }
  }

  const std::unordered_map<uint32_t, std::string> &getExpectInfos() const noexcept { return expectInfos; }

  void visitCall(wasm::Call *const curr) noexcept;

  static void doPreVisit(MockInstrumentationWalker *self, wasm::Expression **currp) {
    wasm::Expression *const curr = *currp;
    auto &locs = self->getFunction()->debugLocations;
    auto &expressionStack = self->expressionStack;
    if (locs.find(curr) == locs.end()) {
      // No debug location, see if we should inherit one.
      if (wasm::Expression *const previous = self->getPrevious()) {
        auto it = locs.find(previous);
        if (it != locs.end()) {
          locs[curr] = it->second;
        }
      }
    }
    expressionStack.push_back(curr);
  }

  static void doPostVisit(MockInstrumentationWalker *self, wasm::Expression **currp) {
    auto &exprStack = self->expressionStack;
    while (exprStack.back() != *currp) {
      // pop all the child expressions and keep current expression in stack.
      exprStack.pop_back();
    }
  }

  static void scan(MockInstrumentationWalker *self, wasm::Expression **currp) {
    self->pushTask(MockInstrumentationWalker::doPostVisit, currp);

    PostWalker<MockInstrumentationWalker>::scan(self, currp);

    self->pushTask(MockInstrumentationWalker::doPreVisit, currp);
  }

  wasm::Expression *replaceCurrent(wasm::Expression *expression) {
    PostWalker<MockInstrumentationWalker>::replaceCurrent(expression);
    // also update the stack
    expressionStack.back() = expression;
    return expression;
  }

  wasm::Expression *getPrevious() {
    if (expressionStack.empty()) {
      return nullptr;
    }
    assert(expressionStack.size() >= 1);
    return expressionStack[expressionStack.size() - 1];
  }

  void visitCallIndirect(wasm::CallIndirect *const curr) noexcept;
  void mockWalk() noexcept;

private:
  wasm::Module *const m;     ///< working module
  wasm::Builder b;           ///< module builder
  uint32_t expectIndex = 0U; ///< expectation index, auto increase
  wasm::ExpressionStack expressionStack;
  std::unordered_map<std::string_view, std::pair<wasm::Name, wasm::Index>> funcRefs; ///< cache function references
  std::unordered_map<uint32_t, std::string> expectInfos;                             ///< cache expectation infos
  const std::vector<std::string_view> expectTestFuncNames{
      "#isNull",   "#notNull",         "#equal",   "#notEqual", "#greaterThan", "#greaterThanOrEqual",
      "#lessThan", "#lessThanOrEqual", "#closeTo",
  };
};

} // namespace warpo::passes::instrumentation
