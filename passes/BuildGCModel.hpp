#pragma once

namespace warpo::passes::as_gc {

constexpr const char *stackPointerName = "~lib/memory/__stack_pointer";
constexpr const char *stackCheckFunctionName = "~stack_check";
constexpr const char *newFunctionName = "~lib/rt/itcms/__new";
constexpr const char *collectFunctionName = "~lib/rt/itcms/__collect";

} // namespace warpo::passes::as_gc
