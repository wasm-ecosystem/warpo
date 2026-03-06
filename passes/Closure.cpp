#include <array>
#include <atomic>
#include <string>

#include "Closure.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"
namespace warpo::passes {

static constexpr const char *const kGetClosureEnv = "~lib/closure/getClosureEnv";
static constexpr const char *const kSetClosureEnv = "~lib/closure/setClosureEnv";
static constexpr const char *const kGetClosureEnvByLevel = "~lib/closure/getClosureEnvByLevel";

static std::array<const char *const, 3> kClosureImportBases = {
    kGetClosureEnv,
    kSetClosureEnv,
    kGetClosureEnvByLevel,
};

namespace {

class ClosureCallScanner : public wasm::WalkerPass<wasm::PostWalker<ClosureCallScanner>> {
public:
  ClosureCallScanner(std::atomic<bool> &hasGet, std::atomic<bool> &hasSet) : hasGet(hasGet), hasSet(hasSet) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<ClosureCallScanner>(hasGet, hasSet); }

  void visitCall(wasm::Call *curr) {
    if ((curr->target == kGetClosureEnv) || (curr->target == kGetClosureEnvByLevel))
      hasGet.store(true, std::memory_order_relaxed);
    else if (curr->target == kSetClosureEnv)
      hasSet.store(true, std::memory_order_relaxed);
  }

private:
  std::atomic<bool> &hasGet;
  std::atomic<bool> &hasSet;
};

class SetClosureEnvRemover : public wasm::WalkerPass<wasm::PostWalker<SetClosureEnvRemover>> {
public:
  explicit SetClosureEnvRemover(wasm::Name setClosureEnvName) : setClosureEnvName(std::move(setClosureEnvName)) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<SetClosureEnvRemover>(setClosureEnvName); }

  void visitCall(wasm::Call *const curr) {
    if (curr->target == setClosureEnvName) {
      wasm::Builder b{*getModule()};
      replaceCurrent(b.makeNop());
    }
  }

private:
  wasm::Name setClosureEnvName;
};

} // namespace

void ClosureLower::run(wasm::Module *m) {
  // Phase 1: Scan which closure functions are actually called
  std::atomic<bool> hasGet{false};
  std::atomic<bool> hasSet{false};
  {
    wasm::PassRunner runner{getPassRunner()};
    runner.add(std::make_unique<ClosureCallScanner>(hasGet, hasSet));
    runner.run();
  }

  // Phase 2: If setClosureEnv is used but no get functions are, remove setClosureEnv call sites
  if (!hasGet && hasSet) {
    wasm::PassRunner runner{getPassRunner()};
    runner.add(std::make_unique<SetClosureEnvRemover>(kSetClosureEnv));
    runner.run();
  }

  // Always remove the 3 import functions
  for (auto const &name : kClosureImportBases)
    m->removeFunction(name);
}

} // namespace warpo::passes