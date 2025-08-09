#pragma once

#include <memory>
#include <set>

#include "../helper/BuildCallGraph.hpp"
#include "pass.h"
#include "support/name.h"
#include "wasm.h"

namespace warpo::passes::gc {

struct LeafFunc : public std::set<wasm::Name> {};
/// @brief collect GC leaf functions, i.e., functions that do not call __new / __collect function.
struct LeafFunctionCollector : public wasm::Pass {
  std::shared_ptr<CallGraph const> const cg_;
  std::shared_ptr<LeafFunc> const result_;
  LeafFunctionCollector(std::shared_ptr<CallGraph const> const &cg, std::shared_ptr<LeafFunc> const &result)
      : cg_(cg), result_(result) {
    name = "LeafFunctionCollector";
  }
  bool modifiesBinaryenIR() override { return false; }
  void run(wasm::Module *m) override;

  static std::shared_ptr<LeafFunc> addToPass(wasm::PassRunner &runner, std::shared_ptr<CallGraph const> const &cg) {
    auto result = std::make_shared<LeafFunc>();
    runner.add(std::unique_ptr<wasm::Pass>(new LeafFunctionCollector(cg, result)));
    return result;
  }
};

} // namespace warpo::passes::gc