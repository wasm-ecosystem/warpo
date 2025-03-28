#pragma once

#include "Matcher.hpp"
#include "wasm.h"

namespace warpo::passes::as_gc {

constexpr const char *stackPointerName = "~lib/memory/__stack_pointer";
constexpr const char *stackCheckFunctionName = "~stack_check";
constexpr const char *newFunctionName = "~lib/rt/itcms/__new";
constexpr const char *collectFunctionName = "~lib/rt/itcms/__collect";

} // namespace warpo::passes::as_gc

namespace warpo::passes::matcher {

M<wasm::Expression> const getSP = isGlobalGet(global_get::name(as_gc::stackPointerName));

M<wasm::Expression> const isGCStore = isStore(store::ptr(getSP.bind("sp")));
M<wasm::Expression> const isGCFill =
    isMemoryFill(memory_fill::dest(getSP.bind("sp")), memory_fill::v(isConst(const_::v(wasm::Literal{0}))),
                 memory_fill::size(isConst()));
M<wasm::Expression> const isGCUpdate =
    isGlobalSet(global_set::name(as_gc::stackPointerName),
                global_set::v(isBinary(binary::op({wasm::BinaryOp::AddInt32, wasm::BinaryOp::SubInt32}),
                                       binary::each(getSP.bind("sp"), isConst()))));
M<wasm::Expression> const isCallStackCheck = isCall(call::callee(as_gc::stackCheckFunctionName));

} // namespace warpo::passes::matcher
