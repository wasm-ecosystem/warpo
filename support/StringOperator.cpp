#include <set>
#include <string>

#include "support/StringOperator.hpp"

std::set<std::string> warpo::splitString(const std::string &str, char delimiter) {
  std::set<std::string> result;
  std::size_t start = 0;
  std::size_t end = str.find(delimiter);
  while (end != std::string::npos) {
    if (end != start)
      result.insert(str.substr(start, end - start));
    start = end + 1;
    end = str.find(delimiter, start);
  }
  if (start < str.length())
    result.insert(str.substr(start, std::string::npos));
  return result;
}

#ifdef WARPO_ENABLE_UNIT_TESTS
#include <gtest/gtest.h>
namespace warpo::ut {

TEST(StringOperator, SplitString) {
  std::set<std::string> result = splitString("a,b,c", ',');
  EXPECT_EQ(result.size(), 3);
  EXPECT_TRUE(result.contains("a"));
  EXPECT_TRUE(result.contains("b"));
  EXPECT_TRUE(result.contains("c"));

  result = splitString("a,,c", ',');
  EXPECT_EQ(result.size(), 2);
  EXPECT_TRUE(result.contains("a"));
  EXPECT_TRUE(result.contains("c"));

  result = splitString("", ',');
  EXPECT_TRUE(result.empty());
}

} // namespace warpo::ut

#endif // WARPO_ENABLE_UNIT_TESTS