#include <fstream>
#include <gtest/gtest.h>
#include <pass.h>
#include <sstream>
#include <string>
#include <support/colors.h>
#include <vector>

#include "frontend/VariableInfo/VariableInfo.hpp"
#include "llvm/DebugInfo/DWARF/DWARFContext.h"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/FileSystem.hpp"

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

  llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> debugSections = warpo::frontend::VariableInfo::generateDwarf();

  std::unique_ptr<llvm::DWARFContext> dwarfContext = llvm::DWARFContext::create(debugSections, 4U, true);

  std::string dumpOutput;
  llvm::raw_string_ostream dumpStream(dumpOutput);
  llvm::DIDumpOptions dumpOptions;
  dumpOptions.ShowChildren = true;
  dumpOptions.ShowParents = false;
  dumpOptions.ShowForm = false;
  dumpOptions.SummarizeTypes = false;
  dumpOptions.Verbose = false;
  dumpOptions.DisplayRawContents = false;
  dwarfContext->dump(dumpStream, dumpOptions);
  dumpStream.flush();

  std::ofstream outFile("/home/jcq/workspace/warpo/debug_info_dump.txt");
  if (outFile) {
    outFile << dumpOutput;
    outFile.close();
  }

  // Compare the two debug info dump files
  std::filesystem::path const expectedDumpPath = testDir / "debug_info_dump.txt";
  std::ifstream expectedFile(expectedDumpPath);
  std::ifstream actualFile("/home/jcq/workspace/warpo/debug_info_dump.txt");

  ASSERT_TRUE(expectedFile.is_open()) << "Failed to open expected debug_info_dump.txt";
  ASSERT_TRUE(actualFile.is_open()) << "Failed to open actual debug_info_dump.txt";

  std::stringstream expectedBuffer;
  std::stringstream actualBuffer;
  expectedBuffer << expectedFile.rdbuf();
  actualBuffer << actualFile.rdbuf();

  std::string expectedContent = expectedBuffer.str();
  std::string actualContent = actualBuffer.str();

  ASSERT_EQ(expectedContent, actualContent) << "Debug info dump files do not match!";
}