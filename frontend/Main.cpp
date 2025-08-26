#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <exception>
#include <fmt/base.h>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string_view>
#include <vector>

#include "ASC/ASC.hpp"
#include "LinkedAPI.hpp"
#include "support/colors.h"
#include "wasm-compiler/src/WasmModule/WasmModule.hpp"
#include "wasm-compiler/src/core/common/ILogger.hpp"
#include "wasm-compiler/src/core/common/NativeSymbol.hpp"
#include "wasm-compiler/src/utils/STDCompilerLogger.hpp"
#include "wasm-compiler/src/utils/StackTop.hpp"
#include "wasm.h"

constexpr std::string libraryPrefix = "~lib/";
constexpr std::string extension = ".ts";

int main(int argc, const char *argv[]) {
  vb::WasmModule::initEnvironment(&malloc, &realloc, &free);

  vb::STDCompilerLogger logger{};
  vb::WasmModule m{logger};

  m.setStacktraceRecordCount(32U);
  m.initFromBytecode(
      vb::Span<const uint8_t>{warpo::frontend::embed_asc_wasm.data(), warpo::frontend::embed_asc_wasm.size()},
      vb::Span<vb::NativeSymbol const>{warpo::frontend::linkedAPI.data(), warpo::frontend::linkedAPI.size()});

  uint8_t const *stackTop = static_cast<uint8_t const *>(vb::getStackTop());

  auto const allocString = [&](std::string_view str) -> int32_t {
    // FIXME: convert utf8 to utf16 need library
    int32_t const ptr = m.callExportedFunctionWithName<1>(stackTop, "__new", static_cast<int32_t>(str.size() * 2U),
                                                          static_cast<int32_t>(2))[0]
                            .i32;
    m.callExportedFunctionWithName<1>(stackTop, "__pin", ptr);
    for (size_t i = 0; i < str.size(); i++) {
      m.getLinearMemoryRegion(static_cast<uint32_t>(ptr) + i * 2U, 2)[0] = str[i];
    }
    return ptr;
  };

  enum class IsEntry : uint32_t { NO, YES };

  auto const parseFile = [&](int32_t const program, std::string_view code, std::string_view path,
                             IsEntry isEntry) -> void {
    m.callExportedFunctionWithName<0>(stackTop, "__setArgumentsLength", 4U);
    if (code.empty()) {
      m.callExportedFunctionWithName<0>(stackTop, "parse", program, 0U, allocString(path), isEntry);
    } else {
      m.callExportedFunctionWithName<0>(stackTop, "parse", program, allocString(code), allocString(path), isEntry);
    }
  };

  auto const getAsString = [&](int32_t ptr) -> std::string {
    uint8_t const *header = m.getLinearMemoryRegion(ptr - 20U, 20);
    uint32_t size = 0;
    std::memcpy(&size, header + 16, sizeof(size));
    uint8_t const *content = m.getLinearMemoryRegion(ptr, size);
    size /= 2U;
    std::stringstream ss{};
    for (uint32_t i = 0; i < size; ++i) {
      ss << content[i * 2U];
    }
    return std::move(ss).str();
  };
  struct Dependencies {
    std::string text;
    std::string path;
  };
  auto const getAllDependencies = [&](int32_t const program) -> std::vector<Dependencies> {
    std::vector<Dependencies> dependencies{};
    while (true) {
      int32_t const nextFile = m.callExportedFunctionWithName<1U>(stackTop, "nextFile", program)[0].i32;
      if (nextFile == 0U) {
        break;
      }
      std::string const nextFileInternalPath = getAsString(nextFile);
      if (nextFileInternalPath.starts_with(libraryPrefix)) {
        std::string const plainName = nextFileInternalPath.substr(libraryPrefix.size());
        std::string const indexName = plainName + "/index";
        if (warpo::frontend::embed_library_sources.contains(plainName)) {
          dependencies.push_back(
              {warpo::frontend::embed_library_sources.at(plainName), libraryPrefix + plainName + extension});
        } else if (warpo::frontend::embed_library_sources.contains(indexName)) {
          dependencies.push_back(
              {warpo::frontend::embed_library_sources.at(indexName), libraryPrefix + indexName + extension});
        } else {
          throw std::runtime_error{"TODO: node_module deps resolution: " + nextFileInternalPath};
          int32_t dependee = m.callExportedFunctionWithName<1>(stackTop, "getDependee", program, nextFile)[0].i32;
        }
      } else {
        throw std::runtime_error{"TODO: deps resolution: " + nextFileInternalPath};
      }
    }
    return dependencies;
  };

  auto const checkDiag = [&](int32_t const program) -> size_t {
    size_t count = 0;
    while (true) {
      int32_t const diag = m.callExportedFunctionWithName<1>(stackTop, "nextDiagnostic", program)[0].i32;
      if (diag == 0)
        break;
      count++;
      int32_t const diagStrOffset = m.callExportedFunctionWithName<1>(stackTop, "formatDiagnostic", diag, 1, 1)[0].i32;
      std::cout << getAsString(diagStrOffset) << "\n";
    }
    return count;
  };

  try {
    m.start(stackTop);
    m.callExportedFunctionWithName<0>(stackTop, "_initialize");

    int32_t const option = m.callExportedFunctionWithName<1>(stackTop, "newOptions")[0].i32;
    int32_t const program = m.callExportedFunctionWithName<1>(stackTop, "newProgram", option)[0].i32;

    for (auto const &[libName, libSource] : warpo::frontend::embed_library_sources) {
      // in sub-directory: imported on demand
      if (libName.find('/') != std::string::npos)
        continue;
      parseFile(program, libSource, libraryPrefix + libName + extension, IsEntry::NO);
    }

    parseFile(program, warpo::frontend::embed_library_sources.at("rt/index-incremental"),
              libraryPrefix + "rt/index-incremental" + extension, IsEntry::NO);

    for (int i = 1; i < argc; i++) {
      std::ifstream ifs{argv[i], std::ios::in};
      if (!ifs.is_open()) {
        std::cout << "cannot open file: " << argv[i] << "\n";
        return -1;
      }
      std::stringstream buffer;
      buffer << ifs.rdbuf();
      parseFile(program, std::move(buffer).str(), argv[i], IsEntry::YES);
    }

    while (true) {
      std::vector<Dependencies> const deps = getAllDependencies(program);
      if (deps.empty())
        break;
      for (auto const &[text, path] : deps) {
        parseFile(program, text, path, IsEntry::NO);
      }
    }
    if (checkDiag(program) > 0)
      return -1;
    m.callExportedFunctionWithName<0>(stackTop, "initializeProgram", program);
    int32_t const compiled = m.callExportedFunctionWithName<1>(stackTop, "compile", program)[0].i32;
    if (checkDiag(program) > 0)
      return -1;
    wasm::Module *binaryen_module = reinterpret_cast<wasm::Module *>(
        m.callExportedFunctionWithName<1>(stackTop, "getBinaryenModuleRef", compiled)[0].i64);
    if (binaryen_module == nullptr)
      return -1;

    Colors::setEnabled(false);
    std::ofstream ofs{"out.wat"};
    ofs << *binaryen_module << "\n";

  } catch (std::exception const &e) {
    logger << "Error: " << e.what() << vb::endStatement;
    m.printStacktrace(logger);
  }

  vb::WasmModule::destroyEnvironment();
}
