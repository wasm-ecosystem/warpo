#include "../helper/Matcher.hpp"
#include "GCInfo.hpp"
#include "SSAObj.hpp"
#include "support/Range.hpp"
#include "wasm-traversal.h"

namespace warpo::passes::gc {

SSAMap SSAMap::create(wasm::Function *func) {
  struct Collector : public wasm::PostWalker<Collector> {
    SSAMap &ssaMap_;
    explicit Collector(SSAMap &ssaMap) : ssaMap_(ssaMap) {}
    void doWalkFunction(wasm::Function *func) {
      for (size_t const localIndex : Range{func->getNumParams()}) {
        if (func->getParams()[localIndex] == wasm::Type::i32) {
          ssaMap_.insert(SSAValue{static_cast<wasm::Index>(localIndex)});
        }
      }
      wasm::PostWalker<Collector>::doWalkFunction(func);
    }
    void visitLocalSet(wasm::LocalSet *expr) {
      using namespace matcher;
      auto M = isCall(call::callee(FnLocalToStack));
      if (M(*expr->value)) {
        ssaMap_.insert(SSAValue{expr});
      }
    }
    void visitCall(wasm::Call *expr) {
      using namespace matcher;
      auto M = isCall(call::callee(FnTmpToStack));
      if (M(*expr)) {
        ssaMap_.insert(SSAValue{expr});
      }
    }
  };
  SSAMap ssaMap{};
  if (func->body != nullptr) {
    Collector collector{ssaMap};
    collector.walkFunction(func);
  }
  return ssaMap;
}

} // namespace warpo::passes::gc
