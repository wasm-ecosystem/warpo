
#ifndef RUN_BINARY_TEST_CASE_HPP
#define RUN_BINARY_TEST_CASE_HPP
#include <cstdint>

#include "tests/SingleCaseTest.hpp"

namespace vb {

vb::TestResult runTest(void const *const data, uint32_t length, bool const enableDebugMode, bool const enableStacktrace,
                       bool const forceHighRegisterPressure);

}

#endif
