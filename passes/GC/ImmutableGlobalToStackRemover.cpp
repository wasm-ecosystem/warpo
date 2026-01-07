// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>

#include "GCInfo.hpp"
#include "ImmutableGlobalToStackRemover.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

#define PASS_NAME "ImmutableGlobalToStackRemover"

namespace warpo::passes::gc {

namespace {

struct CallReplacer : public wasm::PostWalker<CallReplacer> {
  wasm::Module *const module_;
  VariableInfo const *const variableInfo_;

  explicit CallReplacer(wasm::Module *module, VariableInfo const *variableInfo)
      : module_(module), variableInfo_(variableInfo) {}

  void visitCall(wasm::Call *expr) {
    if (expr->target != FnTmpToStack)
      return;
    if (expr->operands.size() != 1)
      return;
    wasm::GlobalGet *const globalGet = expr->operands.front()->dynCast<wasm::GlobalGet>();
    if (globalGet == nullptr)
      return;
    wasm::Name const globalName = globalGet->name;
    VariableInfo::GlobalTypes const &globalTypes = variableInfo_->getGlobalTypes();
    auto it = globalTypes.find(std::string(globalName.str));
    if (it == globalTypes.end() || it->second.isMutable)
      return;
    replaceCurrent(globalGet);
  }
};

} // namespace

void ImmutableGlobalToStackRemover::runOnFunction(wasm::Module *m, wasm::Function *func) {
  if (variableInfo_ == nullptr)
    return;
  CallReplacer replacer(m, variableInfo_);
  replacer.walkFunctionInModule(func, m);
}

} // namespace warpo::passes::gc
