#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <exception>
#include <filesystem>
#include <fmt/base.h>
#include <fstream>
#include <iostream>
#include <optional>
#include <sstream>
#include <stdexcept>
#include <string>
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

#include "src/core/runtime/TrapException.hpp"

constexpr std::string libraryPrefix = "~lib/";
constexpr std::string extension = ".ts";

std::string readFile(const char *path) {
  std::ifstream ifs{path, std::ios::in};
  if (!ifs.is_open()) {
    throw std::runtime_error{"cannot open file: " + std::string{path}};
  }
  std::stringstream buffer;
  buffer << ifs.rdbuf();
  return std::move(buffer).str();
}

namespace warpo::frontend {

class FrontendCompiler {
  enum class IsEntry : uint32_t { NO, YES };

  vb::STDCompilerLogger logger{};
  vb::WasmModule m{logger};
  uint8_t const *stackTop;

  int32_t allocString(std::string_view str) {
    // FIXME: convert utf8 to utf16 need library
    int32_t const ptr = m.callExportedFunctionWithName<1>(stackTop, "__new", static_cast<int32_t>(str.size() * 2U),
                                                          static_cast<int32_t>(2))[0]
                            .i32;
    m.callExportedFunctionWithName<1>(stackTop, "__pin", ptr);
    for (size_t i = 0; i < str.size(); i++) {
      m.getLinearMemoryRegion(static_cast<uint32_t>(ptr) + i * 2U, 2)[0] = str[i];
    }
    return ptr;
  }

  void parseFile(int32_t const program, std::optional<std::string> const &code, std::string_view path,
                 IsEntry isEntry) {
    m.callExportedFunctionWithName<0>(stackTop, "__setArgumentsLength", 4U);
    if (code.has_value()) {
      m.callExportedFunctionWithName<0>(stackTop, "parse", program, allocString(code.value()), allocString(path),
                                        isEntry);
    } else {
      m.callExportedFunctionWithName<0>(stackTop, "parse", program, 0U, allocString(path), isEntry);
    }
  }

  std::string getAsString(int32_t ptr) {
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
    std::optional<std::string> text;
    std::string path;
  };

  std::vector<Dependencies> getAllDependencies(int32_t const program) {
    std::vector<Dependencies> dependencies{};
    while (true) {
      int32_t const nextFile = m.callExportedFunctionWithName<1U>(stackTop, "nextFile", program)[0].i32;
      if (nextFile == 0U) {
        break;
      }
      std::string const nextFileInternalPath = getAsString(nextFile);
      if (nextFileInternalPath.starts_with(libraryPrefix)) {
        std::string const plainName = nextFileInternalPath.substr(libraryPrefix.size());
        if (warpo::frontend::embed_library_sources.contains(plainName)) {
          dependencies.push_back(
              {warpo::frontend::embed_library_sources.at(plainName), libraryPrefix + plainName + extension});
          continue;
        }
        std::string const indexName = plainName + "/index";
        if (warpo::frontend::embed_library_sources.contains(indexName)) {
          dependencies.push_back(
              {warpo::frontend::embed_library_sources.at(indexName), libraryPrefix + indexName + extension});
          continue;
        }
        // lib deps
        int32_t const dependee = m.callExportedFunctionWithName<1>(stackTop, "getDependee", program, nextFile)[0].i32;
        throw std::runtime_error{"TODO: node_module deps resolution: " + nextFileInternalPath + " " +
                                 getAsString(dependee)};
        continue;
      }
      const std::string filePathWithExt = nextFileInternalPath + extension;
      if (std::filesystem::exists(filePathWithExt)) {
        dependencies.push_back({readFile(filePathWithExt.c_str()), filePathWithExt});
        continue;
      }
      const std::string indexPathWithExt = nextFileInternalPath + "/index" + extension;
      if (std::filesystem::exists(indexPathWithExt)) {
        dependencies.push_back({readFile(indexPathWithExt.c_str()), indexPathWithExt});
        continue;
      }
      dependencies.push_back({std::nullopt, nextFileInternalPath});
    }
    return dependencies;
  }

  size_t checkDiag(int32_t const program) {
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
  }

public:
  static void init() { vb::WasmModule::initEnvironment(&malloc, &realloc, &free); }
  static void deinit() { vb::WasmModule::destroyEnvironment(); }

  FrontendCompiler() : logger(), m{logger}, stackTop(static_cast<uint8_t const *>(vb::getStackTop())) {
    m.setStacktraceRecordCount(32U);
    m.initFromBytecode(
        vb::Span<const uint8_t>{warpo::frontend::embed_asc_wasm.data(), warpo::frontend::embed_asc_wasm.size()},
        vb::Span<vb::NativeSymbol const>{warpo::frontend::linkedAPI.data(), warpo::frontend::linkedAPI.size()});
  }

  wasm::Module *compile(std::vector<const char *> entryFilePaths) {
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

      for (const char *filePath : entryFilePaths) {
        parseFile(program, readFile(filePath), filePath, IsEntry::YES);
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
        return nullptr;
      m.callExportedFunctionWithName<0>(stackTop, "initializeProgram", program);
      int32_t const compiled = m.callExportedFunctionWithName<1>(stackTop, "compile", program)[0].i32;
      if (checkDiag(program) > 0)
        return nullptr;
      wasm::Module *binaryen_module = reinterpret_cast<wasm::Module *>(
          m.callExportedFunctionWithName<1>(stackTop, "getBinaryenModuleRef", compiled)[0].i64);
      return binaryen_module;
    } catch (vb::TrapException const &e) {
      logger << "Error: " << e.what() << vb::endStatement;
      m.printStacktrace(logger);
    } catch (std::exception const &e) {
      logger << "Error: " << e.what() << vb::endStatement;
    }
    return nullptr;
  }
};

} // namespace warpo::frontend

int main(int argc, const char *argv[]) {
  warpo::frontend::FrontendCompiler::init();
  warpo::frontend::FrontendCompiler c{};
  std::vector<const char *> entryFilePaths;
  for (int i = 1; i < argc; ++i) {
    entryFilePaths.push_back(argv[i]);
  }
  auto binaryen_module = c.compile(entryFilePaths);
  if (binaryen_module) {
    Colors::setEnabled(false);
    std::ofstream ofs{"out.wat"};
    ofs << *binaryen_module << "\n";
  }
  warpo::frontend::FrontendCompiler::deinit();
}
