#pragma once

#include "pass.h"

namespace warpo::passes {

wasm::Pass *createInlineSetterFunctionPass();

} // namespace warpo::passes
