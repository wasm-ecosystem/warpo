///
/// @file RegAdapter.hpp
/// @copyright Copyright (C) 2021 BMW Group
///

#ifndef REGADAPTER_HPP
#define REGADAPTER_HPP

#include "src/config.hpp"

#if defined(JIT_TARGET_X86_64)
#include "x86_64/x86_64_cc.hpp"
#include "x86_64/x86_64_encoding.hpp"
namespace vb {
using TReg = x86_64::REG; ///< Register type (x86_64)
namespace NBackend = x86_64;
} // namespace vb
#elif defined(JIT_TARGET_AARCH64)
#include "aarch64/aarch64_cc.hpp"
#include "aarch64/aarch64_encoding.hpp"
namespace vb {
using TReg = aarch64::REG; ///< Register type (AArch64)
namespace NBackend = aarch64;
} // namespace vb
#elif defined(JIT_TARGET_TRICORE)
#include "tricore/tricore_cc.hpp"
#include "tricore/tricore_encoding.hpp"
namespace vb {
using TReg = tc::REG; ///< Register type (Tricore)
namespace NBackend = tc;
} // namespace vb
#else
static_assert(false, "Backend not supported");
#endif

#endif
