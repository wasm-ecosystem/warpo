#include <cstdint>
#include <cstdlib>

#include "RunBinaryTestCase.hpp"
#include "tests/SingleCaseTest.hpp"
#include "tests/execute/TestHelper.hpp"
#include "tests/loader/stream_loader.hpp"

extern void const *pTestcase;
extern size_t testcaseSize;

extern "C" {
uint8_t TEST_DONE = 0;
}

int main() {
  vb::TestHelper<void const *, uint32_t> const testHelper(vb::runTest);
  uint32_t const totalFailedTests = testHelper.runAllTests(pTestcase, static_cast<uint32_t>(testcaseSize));
  TEST_DONE = 1;
  return static_cast<int>(totalFailedTests);
}
