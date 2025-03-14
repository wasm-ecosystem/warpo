#pragma once

#include "pass.h"

namespace warpo::passes::as_gc {

wasm::Pass *createRemoveDuplicateStoreLocalInGCPass();

} // namespace warpo::passes::as_gc
