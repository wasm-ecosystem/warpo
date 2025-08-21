#include "ConditionalReturn.hpp"
#include "fmt/format.h"
#include "helper/Matcher.hpp"
#include "pass.h"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "CONDITION_RETURN"

namespace warpo::passes {
namespace {

struct ConditionalReturn : public wasm::WalkerPass<wasm::PostWalker<ConditionalReturn>> {
  std::unique_ptr<Pass> create() override { return std::make_unique<ConditionalReturn>(); }
  bool isFunctionParallel() override { return true; }
  bool modifiesBinaryenIR() override { return true; }

  void visitIf(wasm::If *expr) {
    using namespace matcher;
    M matcher = isIf(!_if::hasFalse(), _if::ifTrue(isReturn()));
    if (matcher(*expr)) {
      wasm::Builder b{*getModule()};
      replaceCurrent(b.makeBreak(getTargetBlockName(), nullptr, expr->condition));
    }
  }

  void doWalkFunction(wasm::Function *func) {
    if (func->getResults() == wasm::Type::none)
      return;
    Super::doWalkFunction(func);
  }

private:
  wasm::Name getTargetBlockName() {
    wasm::Function *func = getFunction();
    if (auto *const block = func->body->dynCast<wasm::Block>()) {
      if (block->name.isNull())
        setValidBlockName(block);
      return block->name;
    }
    wasm::Builder b{*getModule()};
    func->body = b.makeBlock(func->body);
    setValidBlockName(func->body->cast<wasm::Block>());
    return func->body->dynCast<wasm::Block>()->name;
  }
  static void setValidBlockName(wasm::Block *block) {
    size_t id = 0;
    while (true) {
      wasm::Name name = fmt::format(PASS_NAME "#{}", id);
      if (verifyBlockName(block, name)) {
        block->name = name;
        return;
      }
      id++;
    }
  }

  static bool verifyBlockName(wasm::Block *block, wasm::Name const &name) {
    struct Visitor : public wasm::PostWalker<Visitor> {
      wasm::Name name;
      bool found = false;
      Visitor(wasm::Name const &name) : name(name) {}
      void visitBlock(wasm::Block *expr) {
        if (expr->name == name) {
          found = true;
        }
      }
      void visitLoop(wasm::Loop *expr) {
        if (expr->name == name) {
          found = true;
        }
      }
    };
    Visitor visitor(name);
    visitor.visit(block);
    return !visitor.found;
  }
};

} // namespace
} // namespace warpo::passes

wasm::Pass *warpo::passes::createConditionalReturnPass() { return new ConditionalReturn(); }
