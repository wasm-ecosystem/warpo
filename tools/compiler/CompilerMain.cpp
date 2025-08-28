#include <argparse/argparse.hpp>
#include <binaryen/src/binaryen-c.h>
#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fstream>
#include <vector>

#include "support/Opt.hpp"
#include "warpo/frontend/Compiler.hpp"

static warpo::cli::Opt<std::string> outputPath{
    "-t",
    "--text",
    [](argparse::Argument &arg) -> void { arg.help("output text file").required(); },
};

static warpo::cli::Opt<std::vector<std::string>> entryPaths{
    "entries",
    [](argparse::Argument &arg) -> void {
      arg.help("entry files").required().nargs(argparse::nargs_pattern::at_least_one);
    },
};

int main(int argc, const char *argv[]) {
  using namespace warpo;

  frontend::init();

  argparse::ArgumentParser program("warpo_compiler");
  cli::init(program, argc, argv);

  BinaryenModuleRef const m = frontend::compile(entryPaths.get());
  if (m == nullptr)
    return -1;

  char *const wasmText = BinaryenModuleAllocateAndWriteText(m);
  std::ofstream watOf{outputPath.get(), std::ios::out};
  watOf << wasmText;
  std::free(wasmText);
}
