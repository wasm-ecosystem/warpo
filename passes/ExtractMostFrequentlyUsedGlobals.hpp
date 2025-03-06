#pragma once

#include "pass.h"

namespace warpo::passes {

wasm::Pass *createExtractMostFrequentlyUsedGlobalsPass();

} // namespace warpo::passes
