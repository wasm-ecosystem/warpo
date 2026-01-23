#pragma once

#include "pass.h"

namespace warpo::passes {

// Combine Switch (br_table) targets when their case bodies are identical.
wasm::Pass *createCombineSwitchTargetsPass();

} // namespace warpo::passes
