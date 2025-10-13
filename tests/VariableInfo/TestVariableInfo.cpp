#include <gtest/gtest.h>
#include <pass.h>
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
}