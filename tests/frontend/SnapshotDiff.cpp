#include <algorithm>
#include <fmt/base.h>
#include <sstream>
#include <string>
#include <vector>

#include "SnapshotDiff.hpp"

namespace warpo {
namespace {

std::vector<std::string> splitLines(std::string_view text) {
  std::vector<std::string> lines;
  std::stringstream ss{std::string{text}};
  std::string line;
  while (std::getline(ss, line)) {
    lines.push_back(std::move(line));
  }
  return lines;
}

} // namespace

void printCompactDiff(std::string_view expected, std::string_view actual) {
  std::vector<std::string> const expectedLines = splitLines(expected);
  std::vector<std::string> const actualLines = splitLines(actual);

  size_t constexpr maxPrintedLines = 20;
  size_t const maxLineCount = std::max(expectedLines.size(), actualLines.size());
  size_t firstDiffLineNumber = 0;

  for (size_t i = 0; i < maxLineCount; i++) {
    bool const hasExpected = i < expectedLines.size();
    bool const hasActual = i < actualLines.size();
    bool const same = hasExpected && hasActual && expectedLines[i] == actualLines[i];
    if (same)
      continue;

    if (firstDiffLineNumber == 0)
      firstDiffLineNumber = i + 1;
    break;
  }

  size_t const startIndex = firstDiffLineNumber > 0 ? firstDiffLineNumber - 1 : 0;
  size_t const expectedEnd = std::min(expectedLines.size(), startIndex + maxPrintedLines);
  size_t const actualEnd = std::min(actualLines.size(), startIndex + maxPrintedLines);
  bool const expectedTruncated = expectedEnd < expectedLines.size();
  bool const actualTruncated = actualEnd < actualLines.size();

  fmt::println("snapshot mismatch at line {} (expected lines: {}, actual lines: {})", firstDiffLineNumber,
               expectedLines.size(), actualLines.size());
  fmt::println("--- expected (from line {})", startIndex + 1);
  for (size_t i = startIndex; i < expectedEnd; i++) {
    fmt::println("{:>6} | {}", i + 1, expectedLines[i]);
  }
  if (expectedTruncated)
    fmt::println("... (truncated)");

  fmt::println("+++ actual (from line {})", startIndex + 1);
  for (size_t i = startIndex; i < actualEnd; i++) {
    fmt::println("{:>6} | {}", i + 1, actualLines[i]);
  }
  if (actualTruncated)
    fmt::println("... (truncated)");
}

} // namespace warpo
