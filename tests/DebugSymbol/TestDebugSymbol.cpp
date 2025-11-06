#include <fstream>
#include <gtest/gtest.h>
#include <sstream>
#include <string>
#include <support/colors.h>
#include <vector>

#include "llvm/DebugInfo/DWARF/DWARFContext.h"
#include "llvm/Support/MemoryBuffer.h"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/DwarfGenerator/DwarfGenerator.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm.h"

namespace {
warpo::cli::Opt<bool> updateFixturesFlag{
    warpo::cli::Category::All,
    "-u",
    "--update-fixtures",
    [](argparse::Argument &arg) { arg.help("update fixture files instead of comparing").flag(); },
};
} // namespace

class TestDebugSymbol_P : public ::testing::TestWithParam<std::string> {
protected:
  void SetUp() override { warpo::frontend::init(); }
};

TEST_P(TestDebugSymbol_P, DebugInfo) {
  warpo::frontend::Config config = warpo::frontend::getDefaultConfig();
  config.useColorfulDiagMessage = false;
  config.emitDebugInfo = true;
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
  std::stringstream ss;
  ss << *compileResult.m.get();

  llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> const debugSections =
      warpo::passes::DwarfGenerator::generateDebugSections(compileResult.m.variableInfo_);

  std::string const dumpOutput = warpo::passes::DwarfGenerator::dumpDwarf(debugSections);
  std::string const fixtureName = testCaseName + "Fixture.txt";
  std::filesystem::path const expectedDumpPath = testDir / fixtureName;

  if (updateFixturesFlag.get()) {
    // Update mode: create or overwrite the fixture file
    std::ofstream outFile(expectedDumpPath, std::ios::out | std::ios::trunc);
    ASSERT_TRUE(outFile.is_open()) << "Failed to create/open fixture file for writing: " << expectedDumpPath;
    outFile << dumpOutput;
    std::cout << "Updated fixture file: " << expectedDumpPath << std::endl;
  } else {
    // Test mode: compare with expected output
    std::ifstream const expectedFile{expectedDumpPath};
    ASSERT_TRUE(expectedFile.is_open()) << "Failed to open expected debug_info fixture at " << expectedDumpPath;

    std::stringstream expectedBuffer;
    expectedBuffer << expectedFile.rdbuf();
    std::string const expectedContent = expectedBuffer.str();

    ASSERT_EQ(expectedContent, dumpOutput) << "Debug info dump does not match expected fixture!";
  }
}

INSTANTIATE_TEST_SUITE_P(DebugSymbolTests, TestDebugSymbol_P,
                         ::testing::Values("TestClassMemberBasic", "TestTemplateClass", "TestGlobal",
                                           "TestFunctionParameter"));

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);

  argparse::ArgumentParser program("TestVariableInfo");
  warpo::cli::init(warpo::cli::Category::OnlyForTest, program, argc, const_cast<const char **>(argv));

  return RUN_ALL_TESTS();
}