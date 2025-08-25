#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "src/core/common/TrapCode.hpp"

#if CXX_TARGET == JIT_TARGET

namespace vb {

// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-special-member-functions)
TEST(TestTrapCodeErrorMessages, errorMessagesMatchEnum) {
  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::NONE)], testing::HasSubstr("No trap"));

  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::UNREACHABLE)], testing::HasSubstr("Unreachable instruction executed"));
  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::BUILTIN_TRAP)], testing::HasSubstr("builtin.trap"));

  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::LINMEM_OUTOFBOUNDSACCESS)],
              testing::HasSubstr("Linear memory access out of bounds"));
  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::LINMEM_COULDNOTEXTEND)], testing::HasSubstr("Could not extend linear memory"));

  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::INDIRECTCALL_OUTOFBOUNDS)], testing::HasSubstr("Indirect call out of bounds"));
  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::INDIRECTCALL_WRONGSIG)],
              testing::HasSubstr("Indirect call performed with wrong signature"));

  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::LINKEDMEMORY_NOTLINKED)], testing::HasSubstr("No memory linked"));
  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::LINKEDMEMORY_OUTOFBOUNDS)],
              testing::HasSubstr("Linked memory access out of bounds"));

  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::DIV_ZERO)], testing::HasSubstr("Division by zero"));
  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::DIV_OVERFLOW)], testing::HasSubstr("Integer division overflow"));
  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::TRUNC_OVERFLOW)], testing::HasSubstr("Float to int conversion overflow"));

  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::RUNTIME_INTERRUPT_REQUESTED)],
              testing::HasSubstr("Runtime interrupt externally triggered"));
  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::STACKFENCEBREACHED)], testing::HasSubstr("Stack fence breached"));

  ASSERT_THAT(trapCodeErrorMessages[static_cast<uint32_t>(TrapCode::CALLED_FUNCTION_NOT_LINKED)], testing::HasSubstr("Called function not linked"));
}
} // namespace vb

#endif // CXX_TARGET == JIT_TARGET
