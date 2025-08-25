///
/// @file PlatformAdapter.hpp
/// @copyright Copyright (C) 2021 BMW Group
///

#ifndef PLATFORMADAPTER_HPP
#define PLATFORMADAPTER_HPP

#include "src/config.hpp"

#ifdef JIT_TARGET_AARCH64
#include "aarch64/aarch64_backend.hpp"
#endif
#ifdef JIT_TARGET_TRICORE
#include "tricore/tricore_backend.hpp"
#endif
#ifdef JIT_TARGET_X86_64
#include "x86_64/x86_64_backend.hpp"
#endif

namespace vb {

#ifdef JIT_TARGET_X86_64
using TBackend = x86_64::x86_64_Backend; ///< Backend class (x86_64)
#elif defined JIT_TARGET_AARCH64
using TBackend = aarch64::AArch64_Backend; ///< Backend class (AArch64)
#elif defined JIT_TARGET_TRICORE
using TBackend = tc::Tricore_Backend; ///< Backend class (Tricore)
#else
static_assert(false, "Backend not supported");
#endif

} // namespace vb

#endif
