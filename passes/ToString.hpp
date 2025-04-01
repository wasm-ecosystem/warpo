#pragma once

#include <string>

#include "wasm.h"

namespace warpo::passes {

inline std::string toString(wasm::Expression *expr) {
  std::stringstream ss{};
  ss << wasm::ShallowExpression{expr, nullptr};
  return ss.str();
}

} // namespace warpo::passes
