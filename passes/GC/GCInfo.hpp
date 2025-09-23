// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstddef>

namespace warpo::passes::gc {

constexpr const char *FnLocalToStack = "~lib/rt/__localtostack";
constexpr const char *FnTmpToStack = "~lib/rt/__tmptostack";

constexpr const char *FnNew = "~lib/rt/itcms/__new";
constexpr const char *FnCollect = "~lib/rt/itcms/__collect";

constexpr const char *VarStackPointer = "~lib/memory/__stack_pointer";
constexpr const char *VarDataEnd = "~lib/memory/__data_end";

constexpr size_t ShadowStackElementSize = 4U;

constexpr const char *FnDecreaseSP = "~lib/rt/__decrease_sp";
constexpr const char *FnIncreaseSP = "~lib/rt/__increase_sp";

} // namespace warpo::passes::gc
