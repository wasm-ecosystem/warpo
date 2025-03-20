#pragma once

#include "pass.h"

namespace warpo::passes::as_gc {

wasm::Pass *createCleanDirectLocalUsesGC();

} // namespace warpo::passes::as_gc
