#include <algorithm>
#include <cstddef>
#include <filesystem>
#include <gtest/gtest.h>
#include <sstream>
#include <string>
#include <support/colors.h>
#include <vector>
#include <warpo/support/FileSystem.hpp>

#include "llvm/DebugInfo/DWARF/DWARFContext.h"
#include "llvm/Support/MemoryBuffer.h"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/DwarfGenerator/DwarfGenerator.hpp"
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

// Filter out subprogram sections with names starting with "~lib" or "start:~lib"
std::string
filterLibSubprograms(std::string const &dump,
                     std::deque<std::pair<size_t, const wasm::Function::DebugLocation *>> const &sourceMapLocations,
                     std::vector<std::string> const &debugInfoFileNames) {
  // Cache filenames without paths
  std::vector<std::string> fileNamesOnly;
  fileNamesOnly.reserve(debugInfoFileNames.size());
  for (std::string const &fullPath : debugInfoFileNames) {
    fileNamesOnly.push_back(std::filesystem::path(fullPath).filename().string());
  }

  std::istringstream input(dump);
  std::ostringstream output;
  std::string line;

  bool skipping = false;
  size_t skipIndent = 0;

  while (std::getline(input, line)) {
    if (skipping) {
      // Count leading spaces (indentation)
      size_t const currentIndent = line.find_first_not_of(' ');
      size_t const indentLevel = (currentIndent == std::string::npos) ? line.size() : currentIndent;

      // If we're back to the same or lower indentation level, stop skipping
      if (indentLevel <= skipIndent) {
        skipping = false;
        // Fall through to process this line normally
      } else {
        // Still inside the subprogram, skip this line
        continue;
      }
    }

    // Check for DW_AT_low_pc or DW_AT_high_pc
    size_t const lowPcPos = line.find("DW_AT_low_pc");
    size_t const highPcPos = line.find("DW_AT_high_pc");
    if ((lowPcPos != std::string::npos) || (highPcPos != std::string::npos)) {
      // Extract the hex address from the line
      size_t const openParen = line.find('(');
      if (openParen != std::string::npos) {
        size_t const closeParen = line.find(')');
        assert(closeParen != std::string::npos && closeParen > openParen);
        std::string const addressStr = line.substr(openParen + 1U, closeParen - openParen - 1);
        assert(addressStr.find("0x") == 0);
        // Parse the hex address
        uint64_t const address = std::stoull(addressStr, nullptr, 16);

        // Find the corresponding source location using binary search
        auto const it = std::lower_bound(sourceMapLocations.begin(), sourceMapLocations.end(), address,
                                         [](auto const &pair, size_t addr) { return pair.first < addr; });
        assert(it != sourceMapLocations.end() && it->first == address &&
               "Address should be found in source map locations");
        wasm::Function::DebugLocation const *const debugLoc = it->second;

        // Replace the address with file:line
        size_t const indentEnd = line.find_first_not_of(' ');
        std::string const indent = (indentEnd != std::string::npos) ? line.substr(0, indentEnd) : "";
        std::string const attrName = (lowPcPos != std::string::npos) ? "scope start" : "scope end";
        std::string const &fileName = fileNamesOnly[debugLoc->fileIndex];
        output << indent << attrName << "\t" << fileName << ":" << debugLoc->lineNumber << "\n";
        continue;
      }
    }

    // Check for DW_TAG_subprogram
    size_t const subprogramPos = line.find("DW_TAG_subprogram");
    if (subprogramPos != std::string::npos) {
      // Count indentation of this subprogram
      size_t const firstNonSpace = line.find_first_not_of(' ');
      size_t const subprogramIndent = (firstNonSpace == std::string::npos) ? line.size() : firstNonSpace;

      // Read next line to check the name
      std::string nameLine;
      if (std::getline(input, nameLine)) {
        size_t const namePos = nameLine.find("DW_AT_name");
        size_t const libPos = nameLine.find("(\"~lib");
        size_t const startLibPos = nameLine.find("(\"start:~lib");
        if (namePos != std::string::npos && (libPos != std::string::npos || startLibPos != std::string::npos)) {
          // This is a ~lib subprogram, start skipping
          skipping = true;
          skipIndent = subprogramIndent;
          continue; // Skip both the subprogram line and name line
        } else {
          // Not a ~lib subprogram, output both lines
          output << line << '\n' << nameLine << '\n';
          continue;
        }
      } else {
        // No next line, just output this line
        output << line << '\n';
        break;
      }
    }

    output << line << '\n';
  }

  return output.str();
}

} // namespace

class TestDebugSymbol_P : public ::testing::TestWithParam<const char *> {
protected:
  void SetUp() override { warpo::frontend::init(); }
};

TEST_P(TestDebugSymbol_P, DebugInfo) {
  warpo::frontend::Config config = warpo::frontend::getDefaultConfig();
  config.useColorfulDiagMessage = false;
  config.emitDebugInfo = true;
  config.emitDebugLine = true;
  Colors::setEnabled(false);

  std::string const testCaseName = GetParam();
  std::filesystem::path const testDir = std::filesystem::path(__FILE__).parent_path();
  std::filesystem::path const testFilePath = testDir / (testCaseName + ".ts");
  std::vector<std::string> const entries{testFilePath.string()};
  warpo::frontend::CompilationResult const compileResult{warpo::frontend::compile(nullptr, entries, config)};
  if (compileResult.errorMessage.size() > 0U) {
    std::cout << "compile failed due to " << compileResult.errorMessage << std::endl;
    std::terminate();
  }

  // wasm and source map
  wasm::BufferWithRandomAccess buffer;
  wasm::PassOptions const options = wasm::PassOptions::getWithoutOptimization();

  wasm::PassRunner runner(compileResult.m.get());
  runner.add("propagate-debug-locs");
  runner.run();

  wasm::WasmBinaryWriter writer(compileResult.m.get(), buffer, options);
  std::stringstream sourceMapStream;
  writer.setSourceMap(&sourceMapStream, "");
  writer.setNamesSection(true);
  writer.setEmitModuleName(true);
  writer.write();

  llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> const debugSections =
      warpo::passes::DwarfGenerator::generateDebugSections(compileResult.m.variableInfo_,
                                                           writer.getExpressionOffsets());

  std::string const rawDump = warpo::passes::DwarfGenerator::dumpDwarf(debugSections);
  std::string const dumpOutput =
      filterLibSubprograms(rawDump, writer.getSourceMapLocations(), compileResult.m.get()->debugInfoFileNames);
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
                             "TestFunctionParameter",
                             "TestGlobal",
                             "TestLambda",
                             "TestTemplateClass",
                             "TestLocalInFor",
                             "TestLocalInIf",
                             "TestLocalInWhile",
                             "TestLocalInBlock",
                             "TestLocalInSwitch",
                         }));

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);

  argparse::ArgumentParser program("TestVariableInfo");
  warpo::cli::init(warpo::cli::Category::OnlyForTest, program, argc, const_cast<const char **>(argv));

  return RUN_ALL_TESTS();
}