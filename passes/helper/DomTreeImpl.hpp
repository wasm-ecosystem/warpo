// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

/// @details create dominator tree for the given CFG

#pragma once

#include <cassert>
#include <cstddef>

#include "CFG.hpp"
#include "warpo/support/DomTree.hpp"

namespace warpo::passes::dom_tree_impl {

ImmediateDomTree createDomTree(CFG const &cfg);

ImmediateDomTree createPostDomTree(CFG const &cfg);

} // namespace warpo::passes::dom_tree_impl
