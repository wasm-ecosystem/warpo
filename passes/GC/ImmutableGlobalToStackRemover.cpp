// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>

#include "../helper/Matcher.hpp"
#include "GCInfo.hpp"
#include "ImmutableGlobalToStackRemover.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

#define PASS_NAME "ImmutableGlobalToStackRemover"

namespace warpo::passes::gc {

static bool isGlobalImmutable(VariableInfo const &variableInfo, wasm::Name const &globalName) {
  VariableInfo::GlobalTypes const &globalTypes = variableInfo.getGlobalTypes();
  auto it = globalTypes.find(std::string{globalName.str});
  // when the global variable is not found, consider it mutable
  if (it == globalTypes.end())
    return false;
  return !it->second.isMutable;
}

namespace {

struct CallReplacer : public wasm::PostWalker<CallReplacer> {
  wasm::Module *const module_;
  VariableInfo const &variableInfo_;

  explicit CallReplacer(wasm::Module *module, VariableInfo const &variableInfo)
      : module_(module), variableInfo_(variableInfo) {}

  void visitCall(wasm::Call *expr) {
    using namespace matcher;
    auto match = isCall(call::callee(FnTmpToStack), call::operands(has(1)),
                        call::operands(at(0, isGlobalGet().bind("global.get"))));
    Context ctx{};
    if (!match(*expr, ctx))
      return;
    wasm::GlobalGet const *const globalGet = ctx.getBinding<wasm::GlobalGet>("global.get");
    assert(globalGet != nullptr);
    if (!isGlobalImmutable(variableInfo_, globalGet->name))
      return;
    replaceCurrent(expr->operands[0]);
  }
};

} // namespace

void ImmutableGlobalToStackRemover::runOnFunction(wasm::Module *m, wasm::Function *func) {
  if (variableInfo_ == nullptr)
    return;
  CallReplacer replacer(m, *variableInfo_);
  replacer.walkFunctionInModule(func, m);
}

} // namespace warpo::passes::gc
