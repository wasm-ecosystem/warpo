#pragma once

#include "pass.h"

namespace warpo::passes::as_gc {

wasm::Pass *createCleanLeafFunctionGC();

} // namespace warpo::passes::as_gc
