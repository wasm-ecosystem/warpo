#pragma once

#include <set>

#include "../BuildCallGraph.hpp"
#include "pass.h"
#include "support/name.h"
#include "wasm.h"

namespace warpo::passes::gc {

struct LeafFunc : public std::set<wasm::Name> {};
struct LeafFunctionCollector : public wasm::Pass {
  CallGraph const &cg_;
  LeafFunc &result_;
  LeafFunctionCollector(CallGraph const &cg, LeafFunc &result) : cg_(cg), result_(result) {
    name = "LeafFunctionCollector";
  }
  bool modifiesBinaryenIR() override { return false; }
  void run(wasm::Module *m) override;
};

} // namespace warpo::passes::gc