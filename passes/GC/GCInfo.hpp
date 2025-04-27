#pragma once

namespace warpo::passes::gc {

constexpr const char *FnLocalToStack = "~lib/rt/__localtostack";
constexpr const char *FnTmpToStack = "~lib/rt/__tmptostack";

constexpr const char *FnNew = "~lib/rt/itcms/__new";
constexpr const char *FnCollect = "~lib/rt/itcms/__collect";

constexpr const char *VarStackPointer = "~lib/memory/__stack_pointer";
constexpr const char *VarDataEnd = "~lib/memory/__data_end";

} // namespace warpo::passes::gc
