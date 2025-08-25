#include <cstdint>
#include <iostream>

#include "tests/SingleCaseTest.hpp"
#include "tests/loader/stream_loader.hpp"

namespace vb {

vb::TestResult runTest(void const *const data, uint32_t length, bool const enableDebugMode, bool const enableStacktrace,
                       bool const forceHighRegisterPressure) {
  vb::TestResult testResult{};
  void const *testcasePtr = (data);
  while ((static_cast<uint8_t const *>(testcasePtr) - static_cast<uint8_t const *>(data)) != static_cast<std::ptrdiff_t>(length)) {
    vb::stream::StreamTestLoader loader{static_cast<uint8_t const *>(testcasePtr)};
    std::cout << "Executing spectest: " << loader.getTestcaseName() << "\n";
    vb::SingleCaseTest testcase{loader.getTestcaseName()};
    testResult += testcase.testFromStream(&loader, enableDebugMode, enableStacktrace, forceHighRegisterPressure);
    testcasePtr = loader.getNextTestcase();
  }
  return testResult;
}

} // namespace vb
