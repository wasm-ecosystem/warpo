#include <wasm.h>

namespace warpo::passes {

template <class... Ts> bool isOneOf(wasm::Expression *expr) { return ((expr->is<Ts>()) || ...); }

} // namespace warpo::passes
