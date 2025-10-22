// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <exception>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <map>
#include <optional>
#include <regex>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "ASC/ASC.hpp"
#include "CompilerImpl.hpp"
#include "LinkedAPI.hpp"
#include "llvm/Support/ConvertUTF.h"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/Debug.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Statistics.hpp"
#include "wasm.h"

#include "src/WasmModule/WasmModule.hpp"
#include "src/core/common/ILogger.hpp"
#include "src/core/common/NativeSymbol.hpp"
#include "src/core/runtime/TrapException.hpp"
#include "src/utils/STDCompilerLogger.hpp"

namespace warpo::frontend {

namespace {

const std::string libraryPrefix = "~lib/";
const std::string extension = ".ts";

enum WasmFFIBool : uint32_t { WASM_FALSE = 0, WASM_TRUE = 1 };

} // namespace
int32_t FrontendCompiler::allocString(std::string_view str) {
  std::u16string utf16Str = utf8ToUtf16(std::string(str));
  int32_t const ptr =
      r->callExportedFunctionWithName<1>(r.getStackTop(), "__new", static_cast<int32_t>(utf16Str.size() * 2U),
                                         static_cast<int32_t>(2))[0]
          .i32;
  r->callExportedFunctionWithName<1>(r.getStackTop(), "__pin", ptr);
  uint8_t *const stringBegin =
      r->getLinearMemoryRegion(static_cast<uint32_t>(ptr), static_cast<uint32_t>(utf16Str.size()));
  std::memcpy(stringBegin, utf16Str.data(), utf16Str.size() * sizeof(char16_t));

  return ptr;
}

void FrontendCompiler::parseFile(int32_t const program, std::optional<std::string_view> const &code,
                                 std::string_view path, IsEntry isEntry) {
  r->callExportedFunctionWithName<0>(r.getStackTop(), "__setArgumentsLength", 4U);
  if (code.has_value()) {
    r->callExportedFunctionWithName<0>(r.getStackTop(), "parse", program, allocString(code.value()), allocString(path),
                                       isEntry);
  } else {
    r->callExportedFunctionWithName<0>(r.getStackTop(), "parse", program, 0U, allocString(path), isEntry);
  }
}

std::string FrontendCompiler::getAsString(uint32_t ptr) {
  uint8_t const *const header = r->getLinearMemoryRegion(ptr - 20U, 20U);
  uint32_t size = 0;
  std::memcpy(&size, header + 16, sizeof(size));
  uint8_t const *const content = r->getLinearMemoryRegion(ptr, size);

  std::u16string utf16Str;
  utf16Str.resize(size / 2);
  std::memcpy(utf16Str.data(), content, size);
  return utf16ToUtf8(utf16Str);
};

std::u16string FrontendCompiler::utf8ToUtf16(std::string const &utf8Str) {
  if (utf8Str.empty())
    return std::u16string();
  const llvm::UTF8 *src = reinterpret_cast<const llvm::UTF8 *>(utf8Str.data());
  llvm::UTF8 const *const srcEnd = src + utf8Str.size();
  std::u16string utf16Str;
  utf16Str.resize(utf8Str.size());
  llvm::UTF16 *dst = reinterpret_cast<llvm::UTF16 *>(utf16Str.data());
  llvm::UTF16 *const dstEnd = dst + utf16Str.size();

  if (llvm::ConvertUTF8toUTF16(&src, srcEnd, &dst, dstEnd, llvm::strictConversion) != llvm::conversionOK)
    throw std::runtime_error("UTF8 to UTF16 conversion failed");
  // Resize the string to the actual number of UTF-16 code units written.
  // The pointer subtraction yields a ptrdiff_t; it must be non-negative and fit into size_t.
  ptrdiff_t const written16 = dst - reinterpret_cast<llvm::UTF16 *>(utf16Str.data());
  utf16Str.resize(static_cast<std::u16string::size_type>(written16));
  return utf16Str;
}

std::string FrontendCompiler::utf16ToUtf8(std::u16string const &utf16Str) {
  if (utf16Str.empty())
    return std::string();
  const llvm::UTF16 *src = reinterpret_cast<const llvm::UTF16 *>(utf16Str.data());
  llvm::UTF16 const *const srcEnd = src + utf16Str.size();
  std::string utf8Str;
  utf8Str.resize(utf16Str.size() * 4); // UTF-8 can be up to 4 bytes per Unicode code point
  llvm::UTF8 *dst = reinterpret_cast<llvm::UTF8 *>(utf8Str.data());
  llvm::UTF8 *const dstEnd = dst + utf8Str.size();

  if (llvm::ConvertUTF16toUTF8(&src, srcEnd, &dst, dstEnd, llvm::strictConversion) != llvm::conversionOK)
    throw std::runtime_error("UTF16 to UTF8 conversion failed");
  // Resize the string to the actual number of UTF-8 bytes written.
  ptrdiff_t const written8 = dst - reinterpret_cast<llvm::UTF8 *>(utf8Str.data());
  utf8Str.resize(static_cast<std::string::size_type>(written8));
  return utf8Str;
}

using PackageResolveResult = std::optional<std::pair<std::string, std::optional<std::string>>>;

static PackageResolveResult getPackageName(std::string const &fileInternalPath) {
  static std::regex const libRegex{R"(^~lib/((?:@[^/]+/)?[^/]+)(?:/(.*?))?$)"};
  std::smatch match;
  if (!std::regex_match(fileInternalPath, match, libRegex))
    return std::nullopt;
  std::string const packageName = match[1].str();
  std::optional<std::string> const filePath =
      (match.size() > 2 && match[2].matched) ? std::optional<std::string>{match[2].str()} : std::nullopt;
  return std::pair<std::string, std::optional<std::string>>{packageName, filePath};
}

std::optional<std::filesystem::path> FrontendCompiler::findPackageRoot(std::filesystem::path const &sourceInternalPath,
                                                                       std::string const &packageName) {
  auto const it = packageRootMap_.find(packageName);
  if (it != packageRootMap_.end())
    return it->second;
  std::filesystem::path current;
  PackageResolveResult const sourcePackage = getPackageName(sourceInternalPath);
  if (sourcePackage.has_value()) {
    std::string const sourcePackageName = (*sourcePackage).first;
    assert(packageRootMap_.contains(sourcePackageName));
    std::filesystem::path const packagePath = packageRootMap_.at(sourcePackageName);
    current = packagePath;
  } else {
    current = std::filesystem::absolute(sourceInternalPath).parent_path();
  }
  while (current != current.root_path()) {
    std::filesystem::path const target = current / "node_modules" / packageName;
    // fmt::println("[module resolve] try to resolving library '{}' in '{}'", packageName, target.c_str());
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
  int32_t const dependee = r->callExportedFunctionWithName<1>(r.getStackTop(), "getDependee", program, nextFile)[0].i32;
  std::string const dependeePath = getAsString(static_cast<uint32_t>(dependee));
  if (PackageResolveResult const package = getPackageName(nextFileInternalPath); package.has_value()) {
    auto const [packageName, filePath] = *package;
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
      return {readTextFile(filePathWithExt), internalPath};
    }
    const std::string indexPathWithExt = plainPath / ("index" + extension);
    if (std::filesystem::exists(indexPathWithExt) && std::filesystem::is_regular_file(indexPathWithExt)) {
      std::string const internalPath =
          libraryPrefix + packageName + (filePath.has_value() ? ("/" + *filePath) : "") + "/index" + extension;
      if (support::isDebug("ModuleResolve"))
        fmt::println("[module resolve] resolve '{}' to '{}'", nextFileInternalPath, internalPath);
      return {readTextFile(indexPathWithExt), internalPath};
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
    return {readTextFile(filePathWithExt), filePathWithExt};
  }
  const std::string indexPathWithExt = std::filesystem::path{nextFileInternalPath} / ("index" + extension);
  if (std::filesystem::exists(indexPathWithExt) && std::filesystem::is_regular_file(indexPathWithExt)) {
    return {readTextFile(indexPathWithExt), indexPathWithExt};
  }
  const std::string dFilePathWithExt = nextFileInternalPath + ".d" + extension;
  if (std::filesystem::exists(dFilePathWithExt) && std::filesystem::is_regular_file(dFilePathWithExt)) {
    return {readTextFile(dFilePathWithExt), filePathWithExt};
  }
  if (support::isDebug("ModuleResolve"))
    fmt::println("[module resolve] cannot find library '{}'", nextFileInternalPath);
  return {std::nullopt, nextFileInternalPath + extension};
}
FrontendCompiler::Dependency FrontendCompiler::getDependency(std::string const &nextFileInternalPath, int32_t program,
                                                             int32_t nextFile) {
  support::PerfRAII const r{support::PerfItemKind::CompilationHIR_Parsing_DepsResolve};
  if (nextFileInternalPath.starts_with(libraryPrefix)) {
    std::string const plainName = nextFileInternalPath.substr(libraryPrefix.size());
    if (embed_library_sources.contains(plainName)) {
      return {.text = std::string{embed_library_sources.at(plainName)}, .path = libraryPrefix + plainName + extension};
    }
    std::string const indexName = plainName + "/index";
    if (embed_library_sources.contains(indexName)) {
      return {.text = std::string{embed_library_sources.at(indexName)}, .path = libraryPrefix + indexName + extension};
    }
    return getDependencyForNodeModules(nextFileInternalPath, program, nextFile);
  }
  return getDependencyForUserCode(nextFileInternalPath);
}

std::vector<FrontendCompiler::Dependency> FrontendCompiler::getAllDependencies(int32_t const program) {
  std::vector<Dependency> dependencies{};
  while (true) {
    int32_t const nextFile = r->callExportedFunctionWithName<1U>(r.getStackTop(), "nextFile", program)[0].i32;
    if (nextFile == 0U) {
      break;
    }
    std::string const nextFileInternalPath = getAsString(static_cast<uint32_t>(nextFile));
    dependencies.push_back(getDependency(nextFileInternalPath, program, nextFile));
  }
  return dependencies;
}

bool FrontendCompiler::checkDiag(int32_t const program, bool useColorfulDiagMessage) {
  size_t errorCount = 0;
  while (true) {
    int32_t const diag = r->callExportedFunctionWithName<1>(r.getStackTop(), "nextDiagnostic", program)[0].i32;
    if (diag == 0)
      break;
    bool const isError = static_cast<bool>(r->callExportedFunctionWithName<1>(r.getStackTop(), "isError", diag)[0].i32);
    if (isError)
      errorCount++;
    r->callExportedFunctionWithName<0>(r.getStackTop(), "__setArgumentsLength", 3U);
    int32_t const diagStrOffset =
        r->callExportedFunctionWithName<1>(r.getStackTop(), "formatDiagnostic", diag,
                                           useColorfulDiagMessage ? WasmFFIBool::WASM_TRUE : WasmFFIBool::WASM_FALSE,
                                           WasmFFIBool::WASM_TRUE)[0]
            .i32;
    errorMessage_ += getAsString(static_cast<uint32_t>(diagStrOffset)) + "\n\n";
  }
  errorCount_ += errorCount;
  return errorCount > 0;
}

FrontendCompiler::~FrontendCompiler() {
  for (void *const p : allocedPtrs_) {
    std::free(p);
  }
}

FrontendCompiler::FrontendCompiler(Config const &config) : r{this} {
  if (config.ascWasmPath) [[unlikely]] {
    support::PerfRAII const p{support::PerfItemKind::CompilationHIR_PrepareWASMModule};
    std::string const wasmBytes = readBinaryFile(*config.ascWasmPath);
    r->initFromBytecode(vb::Span<const uint8_t>{reinterpret_cast<uint8_t const *>(wasmBytes.data()), wasmBytes.size()},
                        vb::Span<vb::NativeSymbol const>{warpo::frontend::getLinkedAPI().data(),
                                                         warpo::frontend::getLinkedAPI().size()},
                        true);
  } else {
    support::PerfRAII const p{support::PerfItemKind::CompilationHIR_PrepareWASMModule};
    static vb::WasmModule::CompileResult const embedJitCode =
        r->compile(vb::Span<const uint8_t>{embed_asc_wasm.data(), embed_asc_wasm.size()},
                   vb::Span<vb::NativeSymbol const>{warpo::frontend::getLinkedAPI().data(),
                                                    warpo::frontend::getLinkedAPI().size()});
    r->initFromCompiledBinary(
        vb::Span<uint8_t const>{embedJitCode.getModule().data(), embedJitCode.getModule().size()},
        vb::Span<vb::NativeSymbol const>{},
        vb::Span<uint8_t const>{embedJitCode.getDebugSymbol().data(), embedJitCode.getDebugSymbol().size()});
  }
}

warpo::frontend::CompilationResult FrontendCompiler::compile(std::vector<std::string> const &entryFilePaths,
                                                             Config const &config) {
  try {
    support::PerfRAII initStat{support::PerfItemKind::CompilationHIR_Init};
    uint8_t const *const stackTop = r.getStackTop();
    r->start(stackTop);
    r->callExportedFunctionWithName<0>(stackTop, "_initialize");

    int32_t const option = r->callExportedFunctionWithName<1>(stackTop, "newOptions")[0].i32;
    r->callExportedFunctionWithName<1>(stackTop, "__pin", option);

    enum class RuntimeKind : uint32_t { Incremental = 2 };
    constexpr uint32_t stackSize = 32768U;
    r->callExportedFunctionWithName<0>(stackTop, "setRuntime", option, RuntimeKind::Incremental);
    r->callExportedFunctionWithName<0>(stackTop, "setStackSize", option, stackSize);

    enum class SetFeatureOn : uint32_t { OFF = 0, ON = 1 };
    uint32_t const asFeatureFlags = config.features.toASFeaturesFlags();
    r->callExportedFunctionWithName<0>(stackTop, "setFeature", option, ~asFeatureFlags, SetFeatureOn::OFF);
    r->callExportedFunctionWithName<0>(stackTop, "setFeature", option, asFeatureFlags, SetFeatureOn::ON);

    r->callExportedFunctionWithName<0>(stackTop, "setExportTable", option,
                                       config.exportTable ? WasmFFIBool::WASM_TRUE : WasmFFIBool::WASM_FALSE);
    r->callExportedFunctionWithName<0>(stackTop, "setExportRuntime", option,
                                       config.exportRuntime ? WasmFFIBool::WASM_TRUE : WasmFFIBool::WASM_FALSE);
    if (config.exportStart.has_value())
      r->callExportedFunctionWithName<0>(stackTop, "setExportStart", option, allocString(*config.exportStart));
    r->callExportedFunctionWithName<0>(stackTop, "setDebugInfo", option, WasmFFIBool::WASM_TRUE);
    r->callExportedFunctionWithName<0>(stackTop, "setSourceMap", option,
                                       config.emitDebugLine ? WasmFFIBool::WASM_TRUE : WasmFFIBool::WASM_FALSE);
    if (config.initialMemory.has_value())
      r->callExportedFunctionWithName<0>(stackTop, "setInitialMemory", option, *config.initialMemory);

    for (auto const &[useName, useValue] : config.uses) {
      r->callExportedFunctionWithName<0>(stackTop, "addGlobalAlias", option, allocString(useName),
                                         allocString(useValue));
    }
    r->callExportedFunctionWithName<0>(stackTop, "setOptimizeLevelHints", option, config.optimizationLevel,
                                       config.shrinkLevel);

    int32_t const program = r->callExportedFunctionWithName<1>(stackTop, "newProgram", option)[0].i32;
    r->callExportedFunctionWithName<1>(stackTop, "__pin", program);
    initStat.release();

    support::PerfRAII parseStat{support::PerfItemKind::CompilationHIR_Parsing};
    support::PerfRAII parseLibStat{support::PerfItemKind::CompilationHIR_Parsing_BuiltinLib};
    for (auto const &[libName, libSource] : warpo::frontend::embed_library_sources) {
      // in sub-directory: imported on demand
      if (libName.find('/') != std::string::npos)
        continue;
      parseFile(program, libSource, libraryPrefix + libName + extension, IsEntry::NO);
    }
    if (config.enableExtensions) {
      for (auto const &[libName, libSource] : warpo::frontend::embed_extension_library_sources)
        parseFile(program, libSource, libraryPrefix + libName + extension, IsEntry::NO);
    }
    parseFile(program, warpo::frontend::embed_library_sources.at("rt/index-incremental"),
              libraryPrefix + "rt/index-incremental" + extension, IsEntry::NO);
    parseLibStat.release();

    for (std::string const &filePath : entryFilePaths) {
      std::string const relativeFilePath = std::filesystem::relative(filePath).string();
      parseFile(program, readTextFile(filePath), relativeFilePath, IsEntry::YES);
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
    if (checkDiag(program, config.useColorfulDiagMessage))
      return {.m = {}, .errorMessage = errorMessage_};
    parseStat.release();

    support::PerfRAII compileStat{support::PerfItemKind::CompilationHIR_Compilation};

    if (config.enableExtensions)
      r->callExportedFunctionWithName<0>(stackTop, "activeExtensions");

    r->callExportedFunctionWithName<0>(stackTop, "initializeProgram", program);

    int32_t const compiled = r->callExportedFunctionWithName<1>(stackTop, "compile", program)[0].i32;
    if (checkDiag(program, config.useColorfulDiagMessage))
      return {.m = {}, .errorMessage = errorMessage_};
    asModule_.set(BinaryenModule{reinterpret_cast<wasm::Module *>(
        r->callExportedFunctionWithName<1>(stackTop, "getBinaryenModuleRef", compiled)[0].i64)});

    compileStat.release();
    return {.m = std::move(asModule_), .errorMessage = errorMessage_};
  } catch (vb::TrapException const &e) {
    r.getLogger() << "Error: " << e.what() << vb::endStatement;
    r.printStacktrace();
  } catch (std::exception const &e) {
    r.getLogger() << "Error: " << e.what() << vb::endStatement;
  }
  return {.m = {}, .errorMessage = "AS wasm execution failed"};
}

} // namespace warpo::frontend
