#include <fstream>
#include <gtest/gtest.h>
#include <pass.h>
#include <regex>
#include <sstream>
#include <string>
#include <support/colors.h>
#include <vector>

#include "frontend/VariableInfo/VariableInfo.hpp"
#include "llvm/DebugInfo/DWARF/DWARFContext.h"
#include "llvm/Support/MemoryBuffer.h"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/FileSystem.hpp"
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

TEST(TestVariableInfo, TestClassInfo) {
  warpo::frontend::init();
  warpo::frontend::Config config = warpo::frontend::getDefaultConfig();
  config.useColorfulDiagMessage = false;
  Colors::setEnabled(false);

  std::filesystem::path const testDir = std::filesystem::path(__FILE__).parent_path();
  std::filesystem::path const testFilePath = testDir / "test.ts";
  std::vector<std::string> const entries{testFilePath.string()};
  warpo::frontend::CompilationResult const compileResult{warpo::frontend::compile(entries, config)};
  std::stringstream ss;
  ss << *compileResult.m.get();
  std::string actual = std::move(ss).str();

  llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> debugSections;

  // Extract debug sections from the compiled module
  static std::regex const debugSectionPattern{R"(debug_(info|line|str|abbrev|aranges|ranges))"};
  wasm::Module *wasmModule = reinterpret_cast<wasm::Module *>(compileResult.m.get());
  for (auto const &customSection : wasmModule->customSections) {
    if (std::regex_match(customSection.name, debugSectionPattern)) {
      std::unique_ptr<llvm::MemoryBuffer> buffer = llvm::MemoryBuffer::getMemBufferCopy(
          llvm::StringRef(customSection.data.data(), customSection.data.size()), customSection.name);
      debugSections[customSection.name] = std::move(buffer);
    }
  }

  std::string const dumpOutput = warpo::frontend::VariableInfo::dumpDwarf(debugSections);
  const char *const fixtureName{"debug_info_fixture.txt"};
  std::filesystem::path const expectedDumpPath = testDir / fixtureName;

  if (updateFixturesFlag.get()) {
    // Update mode: overwrite the fixture file
    std::ofstream outFile(expectedDumpPath);
    ASSERT_TRUE(outFile.is_open()) << "Failed to open fixture file for writing: " << expectedDumpPath;
    outFile << dumpOutput;
    outFile.close();
    std::cout << "Updated fixture file: " << expectedDumpPath << std::endl;
  } else {
    // Test mode: compare with expected output
    std::ifstream expectedFile(expectedDumpPath);
    ASSERT_TRUE(expectedFile.is_open()) << "Failed to open expected debug_info fixture at " << expectedDumpPath;

    std::stringstream expectedBuffer;
    expectedBuffer << expectedFile.rdbuf();
    std::string const expectedContent = expectedBuffer.str();

    ASSERT_EQ(expectedContent, dumpOutput) << "Debug info dump does not match expected fixture!";
  }
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);

  argparse::ArgumentParser program("TestVariableInfo");
  warpo::cli::init(warpo::cli::Category::OnlyForTest, program, argc, const_cast<const char **>(argv));

  return RUN_ALL_TESTS();
}