#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <fmt/base.h>
#include <memory>

#include "../helper/CFG.hpp"
#include "../helper/DomTree.hpp"
#include "ShrinkWrap.hpp"
#include "StackAssigner.hpp"
#include "support/Debug.hpp"
#include "support/DynBitSet.hpp"
#include "wasm.h"

#define PASS_NAME "SHRINK_WRAP"

namespace warpo::passes::gc {

void ShrinkWrapAnalysis::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition const &stackPosition = stackPositions_.at(func);

  // no stack position, nothing to do
  if (stackPosition.empty())
    return;

  // FIXME: design framework to avoid duplicate calculate CFG
  std::shared_ptr<CFG> const cfg = std::make_shared<CFG>(CFG::fromFunction(func));
  DomTree const domTree = DomTree::create(cfg);

  DynBitset validPrologue = ~DynBitset(cfg->size());
  DynBitset validEpilogue = ~DynBitset(cfg->size());

  // collect stack positions' bb
  for (BasicBlock const &bb : *cfg) {
    for (wasm::Expression *expr : bb) {
      if (auto *call = expr->dynCast<wasm::Call>()) {
        if (stackPosition.contains(call)) {
          validPrologue &= domTree.getDominators(&bb);
          validEpilogue &= domTree.getPostDominators(&bb);
        }
      }
    }
  }
  if (support::isDebug(PASS_NAME, func->name.str)) {
    fmt::print("ShrinkWrapperAnalysis: Function {}:\n - validPrologue: {}\n - validEpilogue: {}\n", func->name.str,
               validPrologue.toString(), validEpilogue.toString());
  }
}

} // namespace warpo::passes::gc
