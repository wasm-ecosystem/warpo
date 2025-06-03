#pragma once

#include <map>
#include <memory>
#include <set>

#include "pass.h"
#include "support/name.h"
#include "wasm.h"

namespace warpo::passes {

using CallGraph = std::map<wasm::Name, std::set<wasm::Name>>;
struct CallGraphBuilder : public wasm::WalkerPass<wasm::PostWalker<CallGraphBuilder>> {
  static CallGraph createResults(wasm::Module &m);

  explicit CallGraphBuilder(CallGraph &result) : cg_(result) {}
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<CallGraphBuilder>(cg_); }
  bool modifiesBinaryenIR() override { return false; }

  void visitCall(wasm::Call *expr);
  void visitCallIndirect(wasm::CallIndirect *expr);

  static std::shared_ptr<CallGraph> addToPass(wasm::PassRunner &runner) {
    auto cg = std::make_shared<CallGraph>(createResults(*runner.wasm));
    runner.add(std::unique_ptr<wasm::Pass>(new CallGraphBuilder(*cg)));
    return cg;
  }

private:
  CallGraph &cg_;
};

} // namespace warpo::passes
