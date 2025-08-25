#ifndef TESTS_SINGLE_CASE_TEST
#define TESTS_SINGLE_CASE_TEST

#include <cstdint>
#include <ostream>

#include "tests/loader/test_loader.hpp"
#include "tests/testimports.hpp"

#include "src/core/common/TrapCode.hpp"

namespace vb {
struct TestResult {
  uint32_t executedTests = 0;
  uint32_t failedTests = 0;
  uint32_t totalTests = 0;
  TestResult &operator+=(TestResult const &rh) noexcept;
  friend std::ostream &operator<<(std::ostream &outputStream, TestResult const &v);
};

class SingleCaseTest {
public:
  explicit SingleCaseTest(std::string const &_testcaseName);
  SingleCaseTest(SingleCaseTest const &) = default;
  SingleCaseTest(SingleCaseTest &&) = default;
  SingleCaseTest &operator=(SingleCaseTest const &) = delete;
  SingleCaseTest &operator=(SingleCaseTest &&) = delete;
  ~SingleCaseTest() = default;

  TestResult testFromStream(TestLoader *loader, bool const enableDebugMode, bool const enableStacktrace, bool const forceHighRegisterPressure);

private:
  static TrapCode getTrapCodeFromTrapText(std::string const &text);
  static bool isExpectedTrap(TrapCode const trapCode1, TrapCode const trapCode2) noexcept;

  void testFailed(uint32_t line, std::string const &message);

  void testCommand(std::string const &type, uint32_t const line);

  std::string testcaseName;

  TestResult testResult{};
  decltype(spectest::ImportsMaker::makeImports()) spectestImports{spectest::ImportsMaker::makeImports()};
};

} // namespace vb

#endif
