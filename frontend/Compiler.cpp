#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <exception>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fstream>
#include <iostream>
#include <map>
#include <optional>
#include <regex>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <vector>

#include "ASC/ASC.hpp"
#include "LinkedAPI.hpp"
#include "support/Debug.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "wasm-compiler/src/WasmModule/WasmModule.hpp"
#include "wasm-compiler/src/core/common/ILogger.hpp"
#include "wasm-compiler/src/core/common/NativeSymbol.hpp"
#include "wasm-compiler/src/utils/STDCompilerLogger.hpp"
#include "wasm-compiler/src/utils/StackTop.hpp"
#include "wasm.h"

#include "src/core/runtime/TrapException.hpp"

namespace warpo::frontend {

class FrontendCompiler {
  enum class IsEntry : uint32_t { NO, YES };

  vb::STDCompilerLogger logger;
  vb::WasmModule m;
  uint8_t const *stackTop;

  std::map<std::string, std::filesystem::path> packageRootMap_{};

  int32_t allocString(std::string_view str);

  void parseFile(int32_t const program, std::optional<std::string> const &code, std::string_view path, IsEntry isEntry);

  std::string getAsString(int32_t ptr);

  std::optional<std::filesystem::path> findPackageRoot(std::filesystem::path const &sourcePath,
                                                       std::string const &packageName);

  struct Dependency {
    std::optional<std::string> text;
    std::string path;
  };

  Dependency getDependencyForNodeModules(std::string const &nextFileInternalPath, int32_t program, int32_t nextFile);
  Dependency getDependencyForUserCode(std::string const &nextFileInternalPath);
  Dependency getDependency(std::string const &nextFileInternalPath, int32_t program, int32_t nextFile);

  std::vector<Dependency> getAllDependencies(int32_t const program);

  size_t checkDiag(int32_t const program);

public:
  static void init() { vb::WasmModule::initEnvironment(&malloc, &realloc, &free); }
  static void deinit() { vb::WasmModule::destroyEnvironment(); }

  FrontendCompiler();

  wasm::Module *compile(std::vector<std::string> const &entryFilePaths);
};

static std::string readFile(std::string const &path) {
  std::ifstream ifs{path, std::ios::in};
  if (!ifs.is_open()) {
    throw std::runtime_error{"cannot open file: " + std::string{path}};
  }
  std::stringstream buffer;
  buffer << ifs.rdbuf();
  return std::move(buffer).str();
}

constexpr std::string libraryPrefix = "~lib/";
constexpr std::string extension = ".ts";

int32_t FrontendCompiler::allocString(std::string_view str) {
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

void FrontendCompiler::parseFile(int32_t const program, std::optional<std::string> const &code, std::string_view path,
                                 IsEntry isEntry) {
  m.callExportedFunctionWithName<0>(stackTop, "__setArgumentsLength", 4U);
  if (code.has_value()) {
    m.callExportedFunctionWithName<0>(stackTop, "parse", program, allocString(code.value()), allocString(path),
                                      isEntry);
  } else {
    m.callExportedFunctionWithName<0>(stackTop, "parse", program, 0U, allocString(path), isEntry);
  }
}

std::string FrontendCompiler::getAsString(int32_t ptr) {
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

std::optional<std::filesystem::path> FrontendCompiler::findPackageRoot(std::filesystem::path const &sourcePath,
                                                                       std::string const &packageName) {
  auto const it = packageRootMap_.find(packageName);
  if (it != packageRootMap_.end())
    return it->second;
  std::filesystem::path current = std::filesystem::absolute(sourcePath);
  while (current != current.root_path()) {
    std::filesystem::path const target = current / "node_modules" / packageName;
    if (std::filesystem::exists(target) && std::filesystem::is_directory(target)) {
      packageRootMap_[packageName] = target;
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] resolve library '{}' in '{}'", packageName, target.c_str());
      return target;
    }
    current = current.parent_path();
  }
  return std::nullopt;
}

FrontendCompiler::Dependency FrontendCompiler::getDependencyForNodeModules(std::string const &nextFileInternalPath,
                                                                           int32_t program, int32_t nextFile) {
  if (support::isDebug("ModuleResolve"))
    fmt::println("[module resolve] get dependency for '{}'", nextFileInternalPath);
  int32_t const dependee = m.callExportedFunctionWithName<1>(stackTop, "getDependee", program, nextFile)[0].i32;
  std::string const dependeePath = getAsString(dependee);
  std::regex const libRegex{R"(^~lib/((?:@[^/]+/)?[^/]+)(?:/(.*?))?$)"};
  std::smatch match;
  if (std::regex_match(nextFileInternalPath, match, libRegex)) {
    std::string const packageName = match[1].str();
    std::optional<std::string> const filePath =
        (match.size() > 2 && match[2].matched) ? std::optional<std::string>{match[2].str()} : std::nullopt;
    std::optional<std::filesystem::path> const packageRoot = findPackageRoot(dependeePath, packageName);
    if (!packageRoot) {
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] cannot find node_modules for package '{}'", packageName);
      return {std::nullopt, nextFileInternalPath + extension};
    }
    std::filesystem::path const plainPath = filePath.has_value() ? (*packageRoot / *filePath) : (*packageRoot);
    const std::string filePathWithExt = plainPath.string() + extension;
    if (std::filesystem::exists(filePathWithExt) && std::filesystem::is_regular_file(filePathWithExt)) {
      std::string const internalPath = libraryPrefix + packageName + "/" + *filePath + extension;
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] resolve '{}' to '{}'", nextFileInternalPath, internalPath);
      return {readFile(filePathWithExt), internalPath};
    }
    const std::string indexPathWithExt = plainPath / ("index" + extension);
    if (std::filesystem::exists(indexPathWithExt) && std::filesystem::is_regular_file(indexPathWithExt)) {
      std::string const internalPath =
          libraryPrefix + packageName + (filePath.has_value() ? ("/" + *filePath) : "") + "/index" + extension;
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] resolve '{}' to '{}'", nextFileInternalPath, internalPath);
      return {readFile(indexPathWithExt), internalPath};
    }
  }
  if (support::isDebug("ModuleResolve"))
    fmt::println("[module resolve] cannot find library '{}'", nextFileInternalPath);
  return {std::nullopt, nextFileInternalPath + extension};
}
FrontendCompiler::Dependency FrontendCompiler::getDependencyForUserCode(std::string const &nextFileInternalPath) {
  const std::string filePathWithExt = nextFileInternalPath + extension;
  if (std::filesystem::exists(filePathWithExt) && std::filesystem::is_regular_file(filePathWithExt)) {
    if (support::isDebug("ModuleResolve"))
      fmt::println("[module resolve] find user code '{}'", filePathWithExt);
    return {readFile(filePathWithExt), filePathWithExt};
  }
  const std::string indexPathWithExt = std::filesystem::path{nextFileInternalPath} / ("index" + extension);
  if (std::filesystem::exists(indexPathWithExt) && std::filesystem::is_regular_file(indexPathWithExt)) {
    return {readFile(indexPathWithExt), indexPathWithExt};
  }
  if (support::isDebug("ModuleResolve"))
    fmt::println("[module resolve] cannot find library '{}'", nextFileInternalPath);
  return {std::nullopt, nextFileInternalPath + extension};
}
FrontendCompiler::Dependency FrontendCompiler::getDependency(std::string const &nextFileInternalPath, int32_t program,
                                                             int32_t nextFile) {
  if (nextFileInternalPath.starts_with(libraryPrefix)) {
    std::string const plainName = nextFileInternalPath.substr(libraryPrefix.size());
    if (embed_library_sources.contains(plainName)) {
      return {embed_library_sources.at(plainName), libraryPrefix + plainName + extension};
    }
    std::string const indexName = plainName + "/index";
    if (embed_library_sources.contains(indexName)) {
      return {embed_library_sources.at(indexName), libraryPrefix + indexName + extension};
    }
    return getDependencyForNodeModules(nextFileInternalPath, program, nextFile);
  }
  return getDependencyForUserCode(nextFileInternalPath);
}

std::vector<FrontendCompiler::Dependency> FrontendCompiler::getAllDependencies(int32_t const program) {
  std::vector<Dependency> dependencies{};
  while (true) {
    int32_t const nextFile = m.callExportedFunctionWithName<1U>(stackTop, "nextFile", program)[0].i32;
    if (nextFile == 0U) {
      break;
    }
    std::string const nextFileInternalPath = getAsString(nextFile);
    dependencies.push_back(getDependency(nextFileInternalPath, program, nextFile));
  }
  return dependencies;
}

size_t FrontendCompiler::checkDiag(int32_t const program) {
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

FrontendCompiler::FrontendCompiler() : logger(), m{logger}, stackTop(static_cast<uint8_t const *>(vb::getStackTop())) {
  m.setStacktraceRecordCount(32U);
  m.initFromBytecode(
      vb::Span<const uint8_t>{warpo::frontend::embed_asc_wasm.data(), warpo::frontend::embed_asc_wasm.size()},
      vb::Span<vb::NativeSymbol const>{warpo::frontend::linkedAPI.data(), warpo::frontend::linkedAPI.size()});
}

wasm::Module *FrontendCompiler::compile(std::vector<std::string> const &entryFilePaths) {
  try {
    m.start(stackTop);
    m.callExportedFunctionWithName<0>(stackTop, "_initialize");

    int32_t const option = m.callExportedFunctionWithName<1>(stackTop, "newOptions")[0].i32;

    enum class RuntimeKind : uint32_t { Incremental = 2 };
    constexpr uint32_t stackSize = 32768U;
    m.callExportedFunctionWithName<0>(stackTop, "setRuntime", option, RuntimeKind::Incremental);
    m.callExportedFunctionWithName<0>(stackTop, "setStackSize", option, stackSize);

    int32_t const program = m.callExportedFunctionWithName<1>(stackTop, "newProgram", option)[0].i32;

    for (auto const &[libName, libSource] : warpo::frontend::embed_library_sources) {
      // in sub-directory: imported on demand
      if (libName.find('/') != std::string::npos)
        continue;
      parseFile(program, libSource, libraryPrefix + libName + extension, IsEntry::NO);
    }

    parseFile(program, warpo::frontend::embed_library_sources.at("rt/index-incremental"),
              libraryPrefix + "rt/index-incremental" + extension, IsEntry::NO);

    for (std::string const &filePath : entryFilePaths) {
      std::string const relativeFilePath = std::filesystem::relative(filePath).string();
      parseFile(program, readFile(filePath), relativeFilePath, IsEntry::YES);
    }
    while (true) {
      std::vector<Dependency> const deps = getAllDependencies(program);
      if (deps.empty())
        break;
      for (auto const &[text, path] : deps) {
        if (support::isDebug("ModuleResolve")) {
          if (!embed_library_sources.contains(path))
            fmt::println("[module resolve] parse '{}'", path);
        }
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

} // namespace warpo::frontend

void warpo::frontend::init() { FrontendCompiler::init(); }

BinaryenModuleRef warpo::frontend::compile(std::vector<std::string> const &entryFilePaths) {
  FrontendCompiler compiler{};
  return compiler.compile(entryFilePaths);
}
