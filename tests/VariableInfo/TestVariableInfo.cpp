#include <fstream>
#include <gtest/gtest.h>
#include <pass.h>
#include <sstream>
#include <string>
#include <support/colors.h>
#include <vector>

#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/FileSystem.hpp"

TEST(TestVariableInfo, TestClassInfo) {
  warpo::frontend::init();
  warpo::frontend::Config config = warpo::frontend::getDefaultConfig();
  config.useColorfulDiagMessage = false;
  Colors::setEnabled(false);

  std::vector<std::string> const entries{"/home/jcq/workspace/warpo/tests/VariableInfo/test.ts"};
  warpo::frontend::CompilationResult const compileResult{warpo::frontend::compile(entries, config)};
  std::stringstream ss;
  ss << *compileResult.m.get();
  std::string actual = std::move(ss).str();
  warpo::writeBinaryFile("/home/jcq/workspace/warpo/build/test.wat", std::move(actual));

  // Compare the two debug info dump files
  std::ifstream expectedFile("/home/jcq/workspace/warpo/tests/VariableInfo/debug_info_dump.txt");
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