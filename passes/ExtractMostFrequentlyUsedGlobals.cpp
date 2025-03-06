#include <algorithm>
#include <atomic>
#include <cassert>
#include <format>
#include <iostream>
#include <map>
#include <memory>

#include "ExtractMostFrequentlyUsedGlobals.hpp"
#include "support/Debug.hpp"
#include "support/index.h"
#include "wasm-traversal.h"
#include "wasm.h"

#define DEBUG_PREFIX "[ExtractMostFrequentlyUsedGlobals] "

namespace warpo::passes {

namespace {

struct Scanner : public wasm::WalkerPass<wasm::PostWalker<Scanner>> {
  Scanner(std::map<wasm::Name, std::atomic<wasm::Index>> &counter) : counter_(counter) {}

  std::unique_ptr<Pass> create() override { return std::make_unique<Scanner>(counter_); }

  bool isFunctionParallel() override { return true; }
  bool modifiesBinaryenIR() override { return false; }

  void visitGlobalGet(wasm::GlobalGet *expr) {
    if (auto it = counter_.find(expr->name); it != counter_.end()) {
      it->second++;
    }
  }
  void visitGlobalSet(wasm::GlobalSet *expr) {
    if (auto it = counter_.find(expr->name); it != counter_.end()) {
      it->second++;
    }
  }

private:
  std::map<wasm::Name, std::atomic<wasm::Index>> &counter_;
};

} // namespace

static wasm::Name findMostFrequentlyUsed(std::map<wasm::Name, std::atomic<wasm::Index>> const &counter) {
  wasm::Name maxGlobalName;
  wasm::Index maxCount = 0;
  for (auto const &[name, count] : counter) {
    if (support::isDebug())
      std::clog << std::format(DEBUG_PREFIX "'{}' used {} times\n", name.str, count.load());
    if (count.load() >= maxCount) {
      maxCount = count.load();
      maxGlobalName = name;
    }
  }
  return maxGlobalName;
}

struct ExtractMostFrequentlyUsedGlobalsAnalyzer : public wasm::Pass {
  void run(wasm::Module *m) override {
    std::map<wasm::Name, std::atomic<wasm::Index>> counter{};
    for (std::unique_ptr<wasm::Global> const &global : m->globals) {
      // if (global->type != wasm::Type::i32)
      //   continue;
      // if (!global->mutable_)
      //   continue;
      // if (global->imported())
      //   continue;
      // if (!global->init->is<wasm::Const>())
      //   continue;
      bool const success = counter.insert_or_assign(global->name, 0U).second;
      assert(success);
    }
    Scanner scanner{counter};
    scanner.run(getPassRunner(), m);
    scanner.runOnModuleCode(getPassRunner(), m);

    wasm::Name maxGlobalName = findMostFrequentlyUsed(counter);
    if (support::isDebug())
      std::clog << std::format(DEBUG_PREFIX "Most frequently used global: {}\n", maxGlobalName.str);

    std::vector<std::unique_ptr<wasm::Global>>::iterator const it =
        std::find_if(m->globals.begin(), m->globals.end(),
                     [&](std::unique_ptr<wasm::Global> &global) -> bool { return maxGlobalName == global->name; });
    assert(it != m->globals.end());
    std::unique_ptr<wasm::Global> mostFrequentlyUsedGlobal = std::move(*it);
    m->globals.erase(it);
    m->globals.insert(m->globals.begin(), std::move(mostFrequentlyUsedGlobal));
    m->updateMaps();
  }
};

wasm::Pass *createExtractMostFrequentlyUsedGlobalsPass() { return new ExtractMostFrequentlyUsedGlobalsAnalyzer(); }

} // namespace warpo::passes
