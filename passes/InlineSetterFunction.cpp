/// @brief pass to inline AS default setter function
///
/// @details
/// most default setter functions are just store the parameter to memory pointed by another parameter
/// this pass will inline these functions
/// local.get $0
/// local.get $1
/// i32.store offset=x

#include <cassert>
#include <format>
#include <iostream>
#include <map>
#include <memory>

#include "InlineSetterFunction.hpp"
#include "Matcher.hpp"
#include "pass.h"
#include "support/Debug.hpp"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

#define DEBUG_PREFIX "[InlineSetterFunction] "

namespace warpo::passes {

namespace {

using InlinableFunctionMap = std::map<wasm::Name, wasm::Function *>;
struct Scanner : public wasm::WalkerPass<wasm::PostWalker<Scanner>> {
  explicit Scanner(InlinableFunctionMap &setterFunction)
      : wasm::WalkerPass<wasm::PostWalker<Scanner>>{}, setterFunction_(setterFunction) {}
  bool modifiesBinaryenIR() override { return false; }
  void visitFunction(wasm::Function *func);

private:
  InlinableFunctionMap &setterFunction_;
};

void Scanner::visitFunction(wasm::Function *curr) {
  if (curr->body == nullptr)
    return;
  using namespace matcher;
  auto const matcher = isStore(hasPtr(isLocalGet(hasIndex(0))), hasValue(isLocalGet(hasIndex(1))));
  if (!matcher(*curr->body))
    return;
  bool success = setterFunction_.insert_or_assign(curr->name, curr).second;
  assert(success);
  if (support::isDebug())
    std::clog << std::format(DEBUG_PREFIX " function '{}' can be inlined\n", curr->name.str);
}

struct Replacer : wasm::WalkerPass<wasm::PostWalker<Replacer>> {
  explicit Replacer(InlinableFunctionMap const &inlinableFunction)
      : wasm::WalkerPass<wasm::PostWalker<Replacer>>{}, inlinableFunction_(inlinableFunction) {}

  bool modifiesBinaryenIR() override { return true; }
  bool isFunctionParallel() override { return false; }
  std::unique_ptr<Pass> create() override { return std::make_unique<Replacer>(inlinableFunction_); }

  void visitCall(wasm::Call *curr) {
    if (curr->target) {
    }
    InlinableFunctionMap::const_iterator it = inlinableFunction_.find(curr->target);
    if (it == inlinableFunction_.end()) {
      return;
    }

    wasm::Builder builder(*getModule());
    wasm::Store const *store = it->second->body->cast<wasm::Store>();
    assert(curr->operands.size() == 2);
    wasm::Expression *ptr = curr->operands[0];
    wasm::Expression *value = curr->operands[1];
    wasm::Store *replace =
        builder.makeStore(store->bytes, store->offset, store->align, ptr, value, store->valueType, store->memory);
    if (support::isDebug()) {
      std::clog << std::format(DEBUG_PREFIX " replace 'call {}' with '{}.store offset={}'\n", curr->target.str,
                               replace->valueType.toString(), replace->offset.addr);
    }
    replaceCurrent(replace);
  }

private:
  InlinableFunctionMap const &inlinableFunction_;
};

void clean(wasm::Module *m, InlinableFunctionMap const &inlinableFunction) {
  m->removeFunctions([&inlinableFunction](wasm::Function *f) -> bool { return inlinableFunction.contains(f->name); });
}

} // namespace

struct InlineSetterFunction : public wasm::Pass {
  void run(wasm::Module *m) override;
};

void InlineSetterFunction::run(wasm::Module *m) {
  InlinableFunctionMap inlinableFunction{};
  Scanner scanner{inlinableFunction};
  scanner.run(getPassRunner(), m);
  if (support::isDebug())
    std::clog << std::format(DEBUG_PREFIX "{} functions can be inlined\n", inlinableFunction.size());
  Replacer replacer{inlinableFunction};
  replacer.run(getPassRunner(), m);
  clean(m, inlinableFunction);
}

} // namespace warpo::passes

namespace warpo {

wasm::Pass *passes::createInlineSetterFunctionPass() { return new passes::InlineSetterFunction(); }

} // namespace warpo
