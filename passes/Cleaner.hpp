#include <functional>
#include <utility>

#include "pass.h"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {

struct Cleaner : public wasm::WalkerPass<wasm::PostWalker<Cleaner, wasm::UnifiedExpressionVisitor<Cleaner>>> {
  std::function<bool(wasm::Expression &expr)> fn_;
  explicit Cleaner(std::function<bool(wasm::Expression &expr)> fn) : fn_(std::move(fn)) {}
  void visitExpression(wasm::Expression *expr);
};

} // namespace warpo::passes