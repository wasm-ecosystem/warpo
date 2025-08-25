#ifndef SRC_CORE_COMPILER_BACKEND_BACKENDBASE_HPP
#define SRC_CORE_COMPILER_BACKEND_BACKENDBASE_HPP

#include "src/core/compiler/common/StackElement.hpp"

namespace vb {

/// @brief div rem analysis result
struct DivRemAnalysisResult final {
  bool mustNotBeOverflow; ///< ignore overflow check
  bool mustNotBeDivZero;  ///< ignore division by zero check
};

/// @brief analyze div rem args
DivRemAnalysisResult analyzeDivRem(StackElement const *const arg0Ptr, StackElement const *const arg1Ptr) VB_NOEXCEPT;

} // namespace vb

#endif // SRC_CORE_COMPILER_BACKEND_BACKENDBASE_HPP
