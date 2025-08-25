#ifndef TESTS_TEST_DATA
#define TESTS_TEST_DATA

#include <cstdint>
#include <map>
#include <string>
#include <vector>

#include "src/core/common/Span.hpp"

namespace vb {
struct TestData {
  std::vector<uint8_t> p_data;
  Span<const uint8_t> m_memObj;
  TestData(const void *data, std::size_t len);
};

using TestDataMapping = std::map<std::string, TestData>;

} // namespace vb

#endif
