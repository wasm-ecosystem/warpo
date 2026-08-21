// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <array>
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
#include "ModuleResolver.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"
#include "warpo/support/Statistics.hpp"

#include "src/WasmModule/WasmModule.hpp"
#include "src/core/common/ILogger.hpp"
#include "src/core/common/NativeSymbol.hpp"
#include "src/core/runtime/TrapException.hpp"
#include "src/utils/STDCompilerLogger.hpp"

namespace warpo::frontend {

namespace {

enum WasmFFIBool : uint32_t { WASM_FALSE = 0, WASM_TRUE = 1 };

std::filesystem::path findPackageRoot() {
  std::filesystem::path const executablePath = cli::getExecutablePath();

  for (std::filesystem::path currentPath = executablePath.parent_path(); currentPath.parent_path() != currentPath;
       currentPath = currentPath.parent_path()) {
    if (std::filesystem::is_directory(currentPath / "assemblyscript" / "std" / "assembly"))
      return currentPath;
    if (currentPath.filename() == "warpo" && std::filesystem::is_regular_file(currentPath / "package.json"))
      break;
  }
  throw std::runtime_error{fmt::format("cannot find assemblyscript/std for executable '{}'", executablePath.string())};
}

std::optional<std::filesystem::path> findLibraryFile(std::filesystem::path const &libraryPath,
                                                     std::string const &libraryName, bool const index) {
  std::filesystem::path const filePath =
      index ? libraryPath / libraryName / "index.ts" : libraryPath / (libraryName + extension);
  if (!std::filesystem::is_regular_file(filePath))
    return std::nullopt;
  return filePath;
}

std::optional<Dependency> getLibraryDependency(std::filesystem::path const &libraryPath, std::string const &libraryName,
                                               bool const index) {
  const std::optional<std::filesystem::path> filePath = findLibraryFile(libraryPath, libraryName, index);
  if (!filePath.has_value())
    return std::nullopt;
  return Dependency{.text = readTextFile(*filePath), .path = libraryPrefix + libraryName + extension};
}

std::vector<std::filesystem::path> getTopLevelLibraryFiles(std::filesystem::path const &libraryPath) {
  std::vector<std::filesystem::path> files;
  for (std::filesystem::directory_entry const &entry : std::filesystem::directory_iterator{libraryPath}) {
    if (!entry.is_regular_file() || entry.path().extension() != extension ||
        entry.path().filename().string().ends_with(".d.ts"))
      continue;
    files.push_back(entry.path());
  }
  std::ranges::sort(files);
  return files;
}

std::string normalizePathForPlatform(std::filesystem::path const &filePath) {
  // NOLINTNEXTLINE(misc-const-correctness)
  std::string relativeFilePath = std::filesystem::relative(filePath).string();
#ifdef _WIN32
  // Normalize path separators to forward slashes on Windows
  std::ranges::replace(relativeFilePath, '\\', '/');
#endif
  return relativeFilePath;
}

} // namespace

void FrontendCompiler::parseFile(int32_t const program, std::optional<std::string_view> const code,
                                 std::string_view path, IsEntry isEntry) {
  r.callExportedFunctionWithName<0>("__setArgumentsLength", 4U);
  if (code.has_value()) {
    r.callExportedFunctionWithName<0>("parse", program, r.allocString(code.value()), r.allocString(path), isEntry);
  } else {
    r.callExportedFunctionWithName<0>("parse", program, 0U, r.allocString(path), isEntry);
  }
}

Dependency FrontendCompiler::getDependency(std::string const &nextFileInternalPath, int32_t program, int32_t nextFile) {
  support::PerfRAII const perfRAII{support::PerfItemKind::CompilationHIR_Parsing_DepsResolve};
  // all library sources are with "~lib/" prefix
  if (!nextFileInternalPath.starts_with(libraryPrefix))
    return moduleResolver_.getDependencyForUserCode(nextFileInternalPath);

  std::string const plainName = nextFileInternalPath.substr(std::string_view{libraryPrefix}.size());
  if (std::optional<Dependency> dependency = getLibraryDependency(libraryPath_, plainName, false))
    return *dependency;
  if (std::optional<Dependency> dependency = getLibraryDependency(extensionLibraryPath_, plainName, false))
    return *dependency;

  std::string const indexName = plainName + "/index";
  if (std::optional<Dependency> dependency = getLibraryDependency(libraryPath_, indexName, false))
    return *dependency;
  if (std::optional<Dependency> dependency = getLibraryDependency(extensionLibraryPath_, indexName, false))
    return *dependency;
  // cache miss
  int32_t const dependee = r.callExportedFunctionWithName<1>("getDependee", program, nextFile)[0].i32;
  std::string const dependeePath = r.getString(static_cast<uint32_t>(dependee));
  return moduleResolver_.getDependencyForNodeModules(nextFileInternalPath, dependeePath);
}

std::vector<Dependency> FrontendCompiler::getAllDependencies(int32_t const program) {
  std::vector<Dependency> dependencies{};
  while (true) {
    int32_t const nextFile = r.callExportedFunctionWithName<1>("nextFile", program)[0].i32;
    if (nextFile == 0U) {
      break;
    }
    std::string const nextFileInternalPath = r.getString(static_cast<uint32_t>(nextFile));
    dependencies.push_back(getDependency(nextFileInternalPath, program, nextFile));
  }
  return dependencies;
}

bool FrontendCompiler::checkDiag(int32_t const program, bool useColorfulDiagMessage) {
  size_t errorCount = 0;
  while (true) {
    int32_t const diag = r.callExportedFunctionWithName<1>("nextDiagnostic", program)[0].i32;
    if (diag == 0)
      break;
    bool const isError = static_cast<bool>(r.callExportedFunctionWithName<1>("isError", diag)[0].i32);
    if (isError)
      errorCount++;
    r.callExportedFunctionWithName<0>("__setArgumentsLength", 3U);
    int32_t const diagStrOffset =
        r.callExportedFunctionWithName<1>("formatDiagnostic", diag,
                                          useColorfulDiagMessage ? WasmFFIBool::WASM_TRUE : WasmFFIBool::WASM_FALSE,
                                          WasmFFIBool::WASM_TRUE)[0]
            .i32;
    errorMessage_ += r.getString(static_cast<uint32_t>(diagStrOffset)) + "\n\n";
  }
  errorCount_ += errorCount;
  return errorCount > 0;
}

FrontendCompiler::~FrontendCompiler() {
  for (void *const p : allocedPtrs_) {
    std::free(p);
  }
}

FrontendCompiler::FrontendCompiler(Config const &config, Pluggable *plugin)
    : r{this}, moduleResolver_(plugin, config.packageSearchPaths),
      libraryPath_{findPackageRoot() / "assemblyscript" / "std" / "assembly"},
      extensionLibraryPath_{findPackageRoot() / "warpo_extension" / "std"}, config_{config} {
  if (config.ascWasmPath) [[unlikely]] {
    support::PerfRAII const p{support::PerfItemKind::CompilationHIR_PrepareWASMModule};
    std::string const wasmBytes = readBinaryFile(*config.ascWasmPath);
    r.initFromBytecode(vb::Span<const uint8_t>{reinterpret_cast<uint8_t const *>(wasmBytes.data()), wasmBytes.size()},
                       vb::Span<vb::NativeSymbol const>{warpo::frontend::getLinkedAPI().data(),
                                                        warpo::frontend::getLinkedAPI().size()},
                       true);
  } else {
    support::PerfRAII const p{support::PerfItemKind::CompilationHIR_PrepareWASMModule};
    static vb::WasmModule::CompileResult const embedJitCode =
        r.compile(vb::Span<const uint8_t>{embed_asc_wasm.data(), embed_asc_wasm.size()},
                  vb::Span<vb::NativeSymbol const>{warpo::frontend::getLinkedAPI().data(),
                                                   warpo::frontend::getLinkedAPI().size()});
    r.initFromCompiledBinary(
        vb::Span<uint8_t const>{embedJitCode.getModule().data(), embedJitCode.getModule().size()},
        vb::Span<vb::NativeSymbol const>{},
        vb::Span<uint8_t const>{embedJitCode.getDebugSymbol().data(), embedJitCode.getDebugSymbol().size()});
  }
}

warpo::frontend::CompilationResult FrontendCompiler::compile(std::vector<std::string> const &entryFilePaths) {
  try {
    support::PerfRAII initStat{support::PerfItemKind::CompilationHIR_Init};
    r.start();
    r.callExportedFunctionWithName<0>("_initialize");

    int32_t const option = r.callExportedFunctionWithName<1>("newOptions")[0].i32;
    r.callExportedFunctionWithName<1>("__pin", option);

    r.callExportedFunctionWithName<0>("setRuntime", option, config_.runtime);
    r.callExportedFunctionWithName<0>("setHost", option, config_.host);
    r.callExportedFunctionWithName<0>("setStackSize", option, config_.stackSize);

    enum class SetFeatureOn : uint32_t { OFF = 0, ON = 1 };
    uint32_t const asFeatureFlags = config_.features.toASFeaturesFlags();
    r.callExportedFunctionWithName<0>("setFeature", option, ~asFeatureFlags, SetFeatureOn::OFF);
    r.callExportedFunctionWithName<0>("setFeature", option, asFeatureFlags, SetFeatureOn::ON);

    r.callExportedFunctionWithName<0>("setExportTable", option,
                                      config_.exportTable ? WasmFFIBool::WASM_TRUE : WasmFFIBool::WASM_FALSE);
    r.callExportedFunctionWithName<0>("setExportRuntime", option,
                                      config_.exportRuntime ? WasmFFIBool::WASM_TRUE : WasmFFIBool::WASM_FALSE);
    if (config_.exportStart.has_value())
      r.callExportedFunctionWithName<0>("setExportStart", option, r.allocString(*config_.exportStart));
    r.callExportedFunctionWithName<0>("setDebugInfo", option, WasmFFIBool::WASM_TRUE);
    r.callExportedFunctionWithName<0>("setSourceMap", option,
                                      config_.emitDebugLine ? WasmFFIBool::WASM_TRUE : WasmFFIBool::WASM_FALSE);
    if (config_.initialMemory.has_value())
      r.callExportedFunctionWithName<0>("setInitialMemory", option, *config_.initialMemory);
    if (config_.lowMemoryLimit.has_value())
      r.callExportedFunctionWithName<0>("setLowMemoryLimit", option, *config_.lowMemoryLimit);
    else if (config_.maximumMemory.has_value())
      r.callExportedFunctionWithName<0>("setMaximumMemory", option, *config_.maximumMemory);

    for (auto const &[useName, useValue] : config_.uses) {
      r.callExportedFunctionWithName<0>("addGlobalAlias", option, r.allocString(useName), r.allocString(useValue));
    }
    if (config_.host == HostKind::WasiSnapshotPreview1) {
      struct WasiAlias final {
        std::string_view alias;
        std::string_view internalName;
      };
      static constexpr std::array<WasiAlias, 8> wasiAliases{
          WasiAlias{"console", "~lib/wasi_snapshot_preview1/wasi_console/wasi_console"},
          WasiAlias{"process", "~lib/wasi_snapshot_preview1/wasi_process/wasi_process"},
          WasiAlias{"Date", "~lib/wasi_snapshot_preview1/wasi_date/wasi_Date"},
          WasiAlias{"performance", "~lib/wasi_snapshot_preview1/wasi_performance/wasi_performance"},
          WasiAlias{"crypto", "~lib/wasi_snapshot_preview1/wasi_crypto/wasi_crypto"},
          WasiAlias{"abort", "~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort"},
          WasiAlias{"seed", "~lib/wasi_snapshot_preview1/wasi_internal/wasi_seed"},
          WasiAlias{"trace", "~lib/wasi_snapshot_preview1/wasi_internal/wasi_trace"},
      };
      for (auto const &alias : wasiAliases) {
        if (config_.uses.contains(std::string{alias.alias}))
          continue;
        r.callExportedFunctionWithName<0>("addGlobalAlias", option, r.allocString(std::string{alias.alias}),
                                          r.allocString(std::string{alias.internalName}));
      }
    }
    r.callExportedFunctionWithName<0>("setOptimizeLevelHints", option, config_.optimizationLevel, config_.shrinkLevel);

    int32_t const program = r.callExportedFunctionWithName<1>("newProgram", option)[0].i32;
    r.callExportedFunctionWithName<1>("__pin", program);
    initStat.release();

    support::PerfRAII parseStat{support::PerfItemKind::CompilationHIR_Parsing};
    support::PerfRAII parseLibStat{support::PerfItemKind::CompilationHIR_Parsing_BuiltinLib};
    for (std::filesystem::path const &filePath : getTopLevelLibraryFiles(libraryPath_)) {
      std::string const libName = filePath.stem().string();
      parseFile(program, readTextFile(filePath), libraryPrefix + libName + extension, IsEntry::NO);
    }
    if (config_.host == HostKind::WasiSnapshotPreview1) {
      static constexpr std::array<std::string_view, 5> wasiStdLibs{
          "wasi_snapshot_preview1/wasi_console", "wasi_snapshot_preview1/wasi_crypto",
          "wasi_snapshot_preview1/wasi_date",    "wasi_snapshot_preview1/wasi_performance",
          "wasi_snapshot_preview1/wasi_process",
      };
      for (auto const &libName : wasiStdLibs) {
        std::optional<std::filesystem::path> const filePath =
            findLibraryFile(extensionLibraryPath_, std::string{libName}, false);
        if (!filePath.has_value())
          continue;
        parseFile(program, readTextFile(*filePath), libraryPrefix + std::string{libName} + extension, IsEntry::NO);
      }
    }

    std::string const rtIndexName =
        config_.runtime == RuntimeKind::Incremental ? "rt/index-incremental" : "rt/index-radical";
    std::optional<std::filesystem::path> const rtIndexPath = findLibraryFile(libraryPath_, rtIndexName, false);
    if (!rtIndexPath.has_value())
      throw std::runtime_error{fmt::format("cannot find AssemblyScript runtime source: {}", rtIndexName)};
    std::string const rtIndexFilePath = libraryPrefix + std::string{"rt/index"} + extension;
    parseFile(program, readTextFile(*rtIndexPath), rtIndexFilePath, IsEntry::NO);
    parseLibStat.release();

    for (std::string const &filePath : entryFilePaths) {
      std::string const relativeFilePath = normalizePathForPlatform(filePath);
      parseFile(program, readTextFile(filePath), relativeFilePath, IsEntry::YES);
    }
    while (true) {
      std::vector<Dependency> const deps = getAllDependencies(program);
      if (deps.empty())
        break;
      for (auto const &[text, path] : deps)
        parseFile(program, text, path, IsEntry::NO);
    }
    if (checkDiag(program, config_.useColorfulDiagMessage))
      return {.m = {}, .errorMessage = errorMessage_};
    parseStat.release();

    support::PerfRAII compileStat{support::PerfItemKind::CompilationHIR_Compilation};

    r.callExportedFunctionWithName<0>("initializeProgram", program);

    int32_t const compiled = r.callExportedFunctionWithName<1>("compile", program)[0].i32;
    static_cast<void>(compiled);
    if (checkDiag(program, config_.useColorfulDiagMessage))
      return {.m = {}, .errorMessage = errorMessage_};

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
