#pragma once

#include <string>

#include "wasm.h"

namespace warpo::passes {

std::string toString(wasm::Expression *expr);
std::string toString(wasm::Function *f);

} // namespace warpo::passes
