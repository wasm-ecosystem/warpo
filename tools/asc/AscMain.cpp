#include <argparse/argparse.hpp>
#include <binaryen/src/binaryen-c.h>
#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fstream>
#include <iostream>
#include <vector>

#include "support/Opt.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/Runner.hpp"

static warpo::cli::Opt<std::string> outputPath{
    "-o",
    "--output",
    [](argparse::Argument &arg) -> void { arg.help("output file").required(); },
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
  passes::init();

  argparse::ArgumentParser program("asc (next generation)");
  cli::init(program, argc, argv);

  BinaryenModuleRef const m = frontend::compile(entryPaths.get());
  if (m == nullptr)
    return -1;
  passes::Output const output = passes::runOnModule(m);

  std::string watPathStr{};
  std::string wasmPathStr{};
  if (outputPath.get().ends_with("wat")) {
    watPathStr = outputPath.get();
    wasmPathStr = outputPath.get().substr(0, outputPath.get().size() - 3) + "wasm";
  } else if (outputPath.get().ends_with("wasm")) {
    watPathStr = outputPath.get().substr(0, outputPath.get().size() - 4) + "wat";
    wasmPathStr = outputPath.get();
  } else {
    fmt::println("ERROR: invalid file extension: {}", outputPath.get());
    return 1;
  }
  std::ofstream wasmOf{wasmPathStr, std::ios::binary | std::ios::out};
  if (!wasmOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPath.get());
    return 1;
  }
  wasmOf.write(reinterpret_cast<char const *>(output.wasm.data()), static_cast<std::streamsize>(output.wasm.size()));
  std::ofstream watOf{watPathStr, std::ios::out};
  if (!watOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPath.get());
    return 1;
  }
  watOf.write(output.wat.data(), static_cast<std::streamsize>(output.wat.size()));
}
