#pragma once

#include <map>
#include <set>

#include "ir/module-utils.h"
#include "pass.h"
#include "support/name.h"
#include "wasm.h"

namespace warpo::passes::as_gc {

using CallGraph = std::map<wasm::Name, std::set<wasm::Name>>;
struct CallCollector : public wasm::WalkerPass<wasm::PostWalker<CallCollector>> {
  static CallGraph createCallGraph(wasm::Module &m) {
    CallGraph ret{};
    wasm::ModuleUtils::iterDefinedFunctions(
        m, [&ret](wasm::Function *curr) { ret.insert_or_assign(curr->name, std::set<wasm::Name>{}); });
    return ret;
  }

  explicit CallCollector(CallGraph &target) : cg_(target) {}
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<CallCollector>(cg_); }
  bool modifiesBinaryenIR() override { return false; }

  void visitCall(wasm::Call *expr);
  void visitCallIndirect(wasm::CallIndirect *expr);

private:
  CallGraph &cg_;
};

struct LeafFunctionCollector : public wasm::Pass {
  CallGraph const &cg_;
  std::set<wasm::Name> const &taint_;
  std::set<wasm::Name> &results_;
  LeafFunctionCollector(CallGraph &cg, std::set<wasm::Name> const &taint, std::set<wasm::Name> &results)
      : cg_(cg), taint_(taint), results_(results) {}
  bool modifiesBinaryenIR() override { return false; }
  void run(wasm::Module *m) override;
};

} // namespace warpo::passes::as_gc