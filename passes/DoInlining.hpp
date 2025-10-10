// Copyright 2016 WebAssembly Community Group participants
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "pass.h"
#include "support/name.h"
#include "wasm.h"

namespace warpo::passes {

struct InliningAction final {
  wasm::Expression **callSite;
  wasm::Function *contents;
  bool insideATry;

  // An optional name hint can be provided, which will then be used in the name
  // of the block we put the inlined code in. Using a unique name hint in each
  // inlining can reduce the risk of name overlaps (which cause fixup work in
  // UniqueNameMapper::uniquify).
  wasm::Index nameHint;

  InliningAction(wasm::Expression **callSite, wasm::Function *contents, bool insideATry, wasm::Index nameHint = 0)
      : callSite(callSite), contents(contents), insideATry(insideATry), nameHint(nameHint) {}
};

// A map of function names to the inlining actions we've decided to actually
// perform in them.
using ChosenActions = std::unordered_map<wasm::Name, std::vector<InliningAction>>;

struct DoInlining final : public wasm::Pass {
  bool isFunctionParallel() override { return true; }

  std::unique_ptr<Pass> create() override { return std::make_unique<DoInlining>(chosenActions); }

  explicit DoInlining(const ChosenActions &chosenActions) : chosenActions(chosenActions) {}

  void runOnFunction(wasm::Module *module, wasm::Function *func) override;

private:
  const ChosenActions &chosenActions;
};

} // namespace warpo::passes
