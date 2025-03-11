/// @brief pass to extract the most frequently used global variable as the first global
///
/// @details
/// WARP has inner optimization to put the first i32 mutable global in register
/// It can reduce the jit code size

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

using Counter = std::map<wasm::Name, std::atomic<wasm::Index>>;
struct Scanner : public wasm::WalkerPass<wasm::PostWalker<Scanner>> {
  explicit Scanner(Counter &counter) : counter_(counter) {}

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
  Counter &counter_;
};

} // namespace

static Counter createCounter(std::vector<std::unique_ptr<wasm::Global>> const &globals) {
  Counter counter{};
  for (std::unique_ptr<wasm::Global> const &global : globals) {
    if (global->type != wasm::Type::i32)
      continue;
    if (!global->mutable_)
      continue;
    if (global->imported())
      continue;
    if (!global->init->is<wasm::Const>())
      continue;
    bool const success = counter.insert_or_assign(global->name, 0U).second;
    assert(success);
  }
  return counter;
}

static wasm::Name findMostFrequentlyUsed(Counter const &counter) {
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
    Counter counter = createCounter(m->globals);
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
    if (it != m->globals.begin()) {
      std::unique_ptr<wasm::Global> mostFrequentlyUsedGlobal = std::move(*it);
      m->globals.erase(it);
      m->globals.insert(m->globals.begin(), std::move(mostFrequentlyUsedGlobal));
      m->updateMaps();
    } else {
      if (support::isDebug()) {
        std::clog << std::format(DEBUG_PREFIX "Most frequently used global: {} is already at index 0\n",
                                 maxGlobalName.str);
      }
    }
  }
};

} // namespace warpo::passes

namespace warpo {

wasm::Pass *passes::createExtractMostFrequentlyUsedGlobalsPass() {
  return new ExtractMostFrequentlyUsedGlobalsAnalyzer();
}

} // namespace warpo

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "pass.h"
#include "unittests/Helper.hpp"

namespace warpo::passes::ut {

TEST(ExtractMostFrequentlyUsedGlobalsTest, CreateCounter) {
  auto m = loadWat(R"(
    (module
      (global $g0 (mut i32) (i32.const 0))
      (global $g1 i32 (i32.const 0)) ;; unmutable
      (global $g2 (mut i64) (i64.const 0)) ;; not i32
    )
  )");

  Counter counter = createCounter(m->globals);
  EXPECT_EQ(counter.size(), 1);
  EXPECT_TRUE(counter.contains("g0"));
}

TEST(ExtractMostFrequentlyUsedGlobalsTest, FindMostFrequentlyUsed) {
  Counter counter{};
  counter.insert_or_assign(wasm::Name{"g0"}, 0U);
  counter.insert_or_assign(wasm::Name{"g1"}, 1U);
  counter.insert_or_assign(wasm::Name{"g2"}, 2U);

  wasm::Name const maxGlobalName = findMostFrequentlyUsed(counter);
  EXPECT_EQ(maxGlobalName, wasm::Name{"g2"});
}

TEST(ExtractMostFrequentlyUsedGlobalsTest, ScannerLocalGet) {
  auto m = loadWat(R"(
    (module
      (global $g0 (mut i32) (i32.const 0))
      (global $g1 (mut i32) (i32.const 0))
      (func
        (global.get $g0)
        (global.get $g1)
        (global.get $g1)
        (return)
      )
    )
  )");

  Counter counter{};
  counter.insert_or_assign(wasm::Name{"g0"}, 0U);
  counter.insert_or_assign(wasm::Name{"g1"}, 0U);

  Scanner scanner{counter};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  EXPECT_EQ(counter.at("g0"), 1);
  EXPECT_EQ(counter.at("g1"), 2);
}

TEST(ExtractMostFrequentlyUsedGlobalsTest, ScannerLocalSet) {
  auto m = loadWat(R"(
    (module
      (global $g0 (mut i32) (i32.const 0))
      (global $g1 (mut i32) (i32.const 0))
      (func
        (global.set $g0 (i32.const 0))
        (global.set $g1 (i32.const 0))
        (global.set $g1 (i32.const 0))
      )
    )
  )");

  Counter counter{};
  counter.insert_or_assign(wasm::Name{"g0"}, 0U);
  counter.insert_or_assign(wasm::Name{"g1"}, 0U);

  Scanner scanner{counter};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  EXPECT_EQ(counter.at("g0"), 1);
  EXPECT_EQ(counter.at("g1"), 2);
}

TEST(ExtractMostFrequentlyUsedGlobalsTest, ScannerIgnoreNonExist) {
  auto m = loadWat(R"(
    (module
      (global $g0 (mut i32) (i32.const 0))
      (global $g1 (mut i32) (i32.const 0))
      (func
        (global.get $g0)
        (global.get $g1)
        (global.get $g1)
        (return)
      )
    )
  )");

  Counter counter{};
  counter.insert_or_assign(wasm::Name{"g1"}, 0U);

  Scanner scanner{counter};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  EXPECT_EQ(counter.size(), 1);
}

TEST(ExtractMostFrequentlyUsedGlobalsTest, Pass) {
  auto m = loadWat(R"(
    (module
      (global $g0 (mut i32) (i32.const 0))
      (global $g1 (mut i32) (i32.const 0))
      (func
        (global.get $g0)
        (global.get $g1)
        (global.get $g1)
        (return)
      )
    )
  )");
  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>(createExtractMostFrequentlyUsedGlobalsPass()));
  runner.run();

  EXPECT_EQ(m->globals[0]->name, wasm::Name{"g1"});
}

} // namespace warpo::passes::ut

#endif
