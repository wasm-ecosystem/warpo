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
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "ASC/ASC.hpp"
#include "CompilerImpl.hpp"
#include "LinkedAPI.hpp"
#include "UTF16.hpp"
#include "warpo/frontend/Compiler.hpp"
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

enum WasmFFIBool : uint32_t { WASM_FALSE = 0, WASM_TRUE = 1 };

} // namespace
int32_t FrontendCompiler::allocString(std::string_view str) {
  std::u16string utf16Str = utf16::fromUTF8(std::string(str));
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
  return utf16::toUTF8(utf16Str);
};

Dependency FrontendCompiler::getDependency(std::string const &nextFileInternalPath, int32_t program, int32_t nextFile) {
  support::PerfRAII const perfRAII{support::PerfItemKind::CompilationHIR_Parsing_DepsResolve};
  if (nextFileInternalPath.starts_with(libraryPrefix)) {
    std::string const plainName = nextFileInternalPath.substr(std::string_view{libraryPrefix}.size());
    if (embed_library_sources.contains(plainName))
      return {.text = std::string{embed_library_sources.at(plainName)}, .path = libraryPrefix + plainName + extension};
    std::string const indexName = plainName + "/index";
    if (embed_library_sources.contains(indexName))
      return {.text = std::string{embed_library_sources.at(indexName)}, .path = libraryPrefix + indexName + extension};
    int32_t const dependee =
        r->callExportedFunctionWithName<1>(r.getStackTop(), "getDependee", program, nextFile)[0].i32;
    std::string const dependeePath = getAsString(static_cast<uint32_t>(dependee));
    return moduleResolver_.getDependencyForNodeModules(nextFileInternalPath, dependeePath);
  }
  return moduleResolver_.getDependencyForUserCode(nextFileInternalPath);
}

std::vector<Dependency> FrontendCompiler::getAllDependencies(int32_t const program) {
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
    if (config.experimental) {
      for (auto const &[libName, libSource] : warpo::frontend::embed_extension_library_sources)
        parseFile(program, libSource, libraryPrefix + libName + extension, IsEntry::NO);
    }
    std::string const retIncremental = "rt/index-incremental";
    parseFile(program, warpo::frontend::embed_library_sources.at(retIncremental),
              libraryPrefix + retIncremental + extension, IsEntry::NO);
    parseLibStat.release();

    for (std::string const &filePath : entryFilePaths) {
      std::string const relativeFilePath = std::filesystem::relative(filePath).string();
      parseFile(program, readTextFile(filePath), relativeFilePath, IsEntry::YES);
    }
    while (true) {
      std::vector<Dependency> const deps = getAllDependencies(program);
      if (deps.empty())
        break;
      for (auto const &[text, path] : deps)
        parseFile(program, text, path, IsEntry::NO);
    }
    if (checkDiag(program, config.useColorfulDiagMessage))
      return {.m = {}, .errorMessage = errorMessage_};
    parseStat.release();

    support::PerfRAII compileStat{support::PerfItemKind::CompilationHIR_Compilation};

    if (config.experimental)
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
