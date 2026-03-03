// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

// update enum value in assemblyscript/src/glue/binaryen-enums.ts

#include <binaryen/src/binaryen-c.h>
#include <cstdint>
#include <dlfcn.h>
#include <filesystem>
#include <iostream>
#include <regex>
#include <string>

#include "warpo/support/FileSystem.hpp"

namespace warpo {
namespace {

using OpFn = int32_t (*)();
using U32Fn = uint32_t (*)();

void *resolveSymbol(char const *name) { return dlsym(RTLD_DEFAULT, name); }

int64_t callBinaryenFunction(std::string const &functionName) {
  void *symbol = resolveSymbol(functionName.c_str());
  if (symbol == nullptr) {
    std::cerr << "Failed to resolve symbol: " << functionName << "\n";
    std::exit(1);
  }

  bool const returnIsU32 = functionName.starts_with("ExpressionRunnerFlags") ||
                           functionName.starts_with("BinaryenExternal") ||
                           (functionName.starts_with("Binaryen") && functionName.ends_with("Id"));

  if (returnIsU32) {
    auto fn = reinterpret_cast<U32Fn>(symbol);
    return static_cast<int64_t>(fn());
  }

  auto fn = reinterpret_cast<OpFn>(symbol);
  return static_cast<int64_t>(fn());
}

std::string updateEnumValues(std::string const &input) {
  std::regex const pattern(R"(=\s*(-?\d+)\s*/\*\s*(_[A-Za-z0-9]+)\s*\*/)");
  std::string output;
  std::size_t last_pos = 0;

  for (auto it = std::sregex_iterator(input.begin(), input.end(), pattern), end = std::sregex_iterator(); it != end;
       ++it) {
    std::smatch const &match = *it;
    output.append(input, last_pos, static_cast<std::size_t>(match.position()) - last_pos);

    std::string const comment = match[2].str();
    std::string const function_name = comment.size() > 0 && comment[0] == '_' ? comment.substr(1) : comment;

    int64_t const value = callBinaryenFunction(function_name);
    output.append("= ");
    output.append(std::to_string(value));
    output.append(" /* ");
    output.append(comment);
    output.append(" */");

    last_pos = static_cast<std::size_t>(match.position() + match.length());
  }

  output.append(input, last_pos, std::string::npos);
  return output;
}

void GenerateBinaryenEnumsMain() {
  // force the dynamic library to be loaded and symbols to be resolved before we call them
  static_cast<void>(BinaryenInvalidId());

  std::filesystem::path const input =
      std::filesystem::weakly_canonical(std::filesystem::path{__FILE__}.parent_path().parent_path().parent_path() /
                                        "assemblyscript" / "src" / "glue" / "binaryen-enums.ts");
  std::filesystem::path const output = input;

  std::string const input_text = readTextFile(input);
  std::string const output_text = updateEnumValues(input_text);

  if (output_text != input_text)
    writeBinaryFile(output, output_text);
}

} // namespace
} // namespace warpo

int main() {
  try {
    warpo::GenerateBinaryenEnumsMain();
  } catch (std::exception const &e) {
    std::cerr << "Error: " << e.what() << "\n";
    return 1;
  }
}
