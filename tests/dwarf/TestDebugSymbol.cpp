#include <algorithm>
#include <cstddef>
#include <deque>
#include <filesystem>
#include <gtest/gtest.h>
#include <optional>
#include <sstream>
#include <string>
#include <support/colors.h>
#include <vector>
#include <warpo/support/FileSystem.hpp>

#include "passes/BinaryWriter.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm-binary.h"
#include "wasm.h"

namespace {
warpo::cli::Opt<bool> updateFixturesFlag{
    warpo::cli::Category::All,
    "-u",
    "--update-fixtures",
    [](argparse::Argument &arg) { arg.help("update fixture files instead of comparing").flag(); },
};

class LineReader {
public:
  explicit LineReader(std::istream &input) : input_(input) {}

  bool next(std::string &line) { return static_cast<bool>(std::getline(input_, line)); }

private:
  std::istream &input_;
};

// Filter out subprogram sections with names starting with "~lib" or "start:~lib"
class LibSubprogramSkipper {
public:
  // Returns:
  // - std::nullopt: not handled; caller should continue processing the line.
  // - string: handled; caller may append returned text (can be empty to indicate skip).
  std::optional<std::string> processLine(std::string const &line) {
    if (hasPendingSubprogram_) {
      return handlePendingSubprogramNameLine(line);
    }

    if (skipping_) {
      // Count leading spaces (indentation)
      size_t const currentIndent = line.find_first_not_of(' ');
      size_t const indentLevel = (currentIndent == std::string::npos) ? line.size() : currentIndent;

      // If we're back to the same or lower indentation level, stop skipping
      if (indentLevel <= skipIndent_) {
        skipping_ = false;
      } else {
        // Still inside the subprogram, skip this line
        return std::string{};
      }
    }

    if (line.find("DW_TAG_subprogram") == std::string::npos)
      return std::nullopt;

    pendingSubprogramLine_ = line;
    pendingSubprogramIndent_ = getLineIndent(line);
    hasPendingSubprogram_ = true;
    return std::string{};
  }

  std::optional<std::string> finalize() {
    if (!hasPendingSubprogram_)
      return std::nullopt;

    hasPendingSubprogram_ = false;
    return pendingSubprogramLine_ + "\n";
  }

private:
  static size_t getLineIndent(std::string const &line) {
    size_t const firstNonSpace = line.find_first_not_of(' ');
    return (firstNonSpace == std::string::npos) ? line.size() : firstNonSpace;
  }

  std::optional<std::string> handlePendingSubprogramNameLine(std::string const &nameLine) {
    hasPendingSubprogram_ = false;

    size_t const namePos = nameLine.find("DW_AT_name");
    size_t const libPos = nameLine.find("(\"~lib");
    size_t const startLibPos = nameLine.find("(\"start:~lib");
    if (namePos != std::string::npos && (libPos != std::string::npos || startLibPos != std::string::npos)) {
      skipping_ = true;
      skipIndent_ = pendingSubprogramIndent_;
      return std::string{};
    }

    return pendingSubprogramLine_ + "\n" + nameLine + "\n";
  }

  bool skipping_ = false;
  size_t skipIndent_ = 0;

  bool hasPendingSubprogram_ = false;
  size_t pendingSubprogramIndent_ = 0;
  std::string pendingSubprogramLine_;
};

std::vector<std::string> getFileNamesOnly(std::vector<std::string> const &debugInfoFileNames) {
  std::vector<std::string> fileNamesOnly;
  fileNamesOnly.reserve(debugInfoFileNames.size());
  for (std::string const &fullPath : debugInfoFileNames) {
    fileNamesOnly.push_back(std::filesystem::path(fullPath).filename().string());
  }
  return fileNamesOnly;
}

bool isUnitHeaderLine(std::string const &line) {
  return line.find("Compile Unit:") != std::string::npos || line.find("Type Unit:") != std::string::npos;
}

void normalizeUnitHeaderLine(std::string &line) {
  if (!isUnitHeaderLine(line))
    return;

  size_t const lengthPos = line.find("length = 0x");
  if (lengthPos != std::string::npos) {
    size_t const hexPos = line.find("0x", lengthPos);
    assert(hexPos != std::string::npos);

    size_t const hexEnd = line.find(' ', hexPos);
    if (hexEnd != std::string::npos) {
      // Erase: `length = 0x... ` (so we end up with `Compile Unit: version = ...`).
      line.erase(lengthPos, (hexEnd + 1U) - lengthPos);
    }
  }

  size_t const nextUnitPos = line.find("(next unit at 0x");
  if (nextUnitPos != std::string::npos) {
    size_t const closeParenPos = line.find(')', nextUnitPos);
    assert(closeParenPos != std::string::npos);

    size_t start = nextUnitPos;
    if (start > 0U && line[start - 1U] == ' ')
      start--;
    line.erase(start, (closeParenPos + 1U) - start);
  }
}

std::optional<std::string>
tryReplacePcWithFileLine(std::string const &line,
                         std::deque<std::pair<size_t, const wasm::Function::DebugLocation *>> const &sourceMapLocations,
                         std::vector<std::string> const &fileNamesOnly) {
  // Check for DW_AT_low_pc or DW_AT_high_pc
  size_t const lowPcPos = line.find("DW_AT_low_pc");
  size_t const highPcPos = line.find("DW_AT_high_pc");
  if ((lowPcPos == std::string::npos) && (highPcPos == std::string::npos))
    return std::nullopt;

  // Extract the hex address from the line
  size_t const openParen = line.find('(');
  if (openParen == std::string::npos)
    return std::nullopt;

  size_t const closeParen = line.find(')');
  assert(closeParen != std::string::npos && closeParen > openParen);
  std::string const addressStr = line.substr(openParen + 1U, closeParen - openParen - 1);
  assert(addressStr.find("0x") == 0);

  // Parse the hex address
  uint64_t const address = std::stoull(addressStr, nullptr, 16);

  // Find the corresponding source location using binary search
  auto const it = std::lower_bound(sourceMapLocations.begin(), sourceMapLocations.end(), address,
                                   [](auto const &pair, size_t addr) { return pair.first < addr; });
  assert(it != sourceMapLocations.end() && "Address should be found in source map locations");
  assert(it->first == address && "Address should be found in source map locations");
  wasm::Function::DebugLocation const *const debugLoc = it->second;

  // Replace the address with file:line
  size_t const indentEnd = line.find_first_not_of(' ');
  std::string const indent = (indentEnd != std::string::npos) ? line.substr(0, indentEnd) : "";
  std::string const attrName = (lowPcPos != std::string::npos) ? "scope start" : "scope end";
  std::string const &fileName = fileNamesOnly[debugLoc->fileIndex];

  return indent + attrName + "\t" + fileName + ":" + std::to_string(debugLoc->lineNumber) + "\n";
}

std::string
filterLibSubprograms(std::string const &dump,
                     std::deque<std::pair<size_t, const wasm::Function::DebugLocation *>> const &sourceMapLocations,
                     std::vector<std::string> const &debugInfoFileNames) {
  // Cache filenames without paths
  std::vector<std::string> const fileNamesOnly = getFileNamesOnly(debugInfoFileNames);

  std::istringstream input(dump);
  LineReader reader(input);
  std::ostringstream output;
  std::string line;

  LibSubprogramSkipper libSkipper;

  while (reader.next(line)) {
    normalizeUnitHeaderLine(line);

    if (std::optional<std::string> const handled = libSkipper.processLine(line); handled.has_value()) {
      if (!handled->empty())
        output << *handled;
      continue;
    }

    if (std::optional<std::string> const replacement =
            tryReplacePcWithFileLine(line, sourceMapLocations, fileNamesOnly);
        replacement.has_value()) {
      output << *replacement;
      continue;
    }

    output << line << '\n';
  }

  if (std::optional<std::string> const tail = libSkipper.finalize(); tail.has_value())
    output << *tail;
  return output.str();
}

} // namespace

class TestDebugSymbol_P : public ::testing::TestWithParam<const char *> {
protected:
  void SetUp() override { warpo::frontend::init(); }
};

TEST_P(TestDebugSymbol_P, DebugInfo) {
  warpo::frontend::Config config = warpo::frontend::Config::getDefault();
  config.useColorfulDiagMessage = false;
  config.emitDebugInfo = true;
  config.emitDebugLine = true;
  Colors::setEnabled(false);

  std::string const testCaseName = GetParam();
  std::filesystem::path const testDir = std::filesystem::path(__FILE__).parent_path() / "cases";
  std::filesystem::path const testFilePath = testDir / (testCaseName + ".ts");
  std::vector<std::string> const entries{testFilePath.string()};
  warpo::frontend::CompilationResult const compileResult{warpo::frontend::compile(nullptr, entries, config)};
  if (compileResult.errorMessage.size() > 0U) {
    std::cout << "compile failed due to " << compileResult.errorMessage << std::endl;
    std::terminate();
  }

  // wasm and source map
  warpo::passes::BinaryWriter writer{compileResult.m};
  writer.enableSourceMap("");
  writer.enableDwarf();
  writer.write();

  std::string const rawDump = writer.dumpDwarf();
  std::string const dumpOutput =
      filterLibSubprograms(rawDump, writer.raw().getSourceMapLocations(), compileResult.m.get()->debugInfoFileNames);
  std::string const fixtureName = testCaseName + "Fixture.txt";
  std::filesystem::path const expectedDumpPath = testDir / fixtureName;

  if (updateFixturesFlag.get()) {
    // Update mode: create or overwrite the fixture file
    warpo::writeBinaryFile(expectedDumpPath, dumpOutput);
    std::cout << "Updated fixture file: " << expectedDumpPath << std::endl;
  } else {
    // Test mode: compare with expected output
    std::string const expectedContent = warpo::readBinaryFile(expectedDumpPath);
    ASSERT_EQ(expectedContent, dumpOutput) << "Debug info dump does not match expected fixture!";
  }
}

INSTANTIATE_TEST_SUITE_P(DebugSymbolTests, TestDebugSymbol_P,
                         ::testing::ValuesIn({
                             "TestBaseTypeToString",
                             "TestClassMemberBasic",
                             "TestFunctionAsField",
                             "TestFunctionParameter",
                             "TestGlobal",
                             "TestLambda",
                             "TestTemplateClass",
                             "TestLocalInFor",
                             "TestLocalInForOf",
                             "TestLocalInIf",
                             "TestLocalInWhile",
                             "TestLocalInBlock",
                             "TestLocalInSwitch",
                             "TestIssue328Crash",
                         }));

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);

  argparse::ArgumentParser program("TestVariableInfo");
  warpo::cli::init(warpo::cli::Category::OnlyForTest, program, argc, const_cast<const char **>(argv));

  return RUN_ALL_TESTS();
}