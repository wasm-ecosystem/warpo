#ifndef TESTS_UNIT_TESTS_COMMON_HPP
#define TESTS_UNIT_TESTS_COMMON_HPP

#include "src/core/runtime/Runtime.hpp"
#include "src/utils/ExecutableMemory.hpp"

namespace vb {
namespace test {

Runtime createRuntime(ExecutableMemory const &executableMemory);

} // namespace test
} // namespace vb

#endif // TESTS_UNIT_TESTS_COMMON_HPP
