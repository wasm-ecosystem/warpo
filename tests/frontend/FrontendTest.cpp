// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <argparse/argparse.hpp>
#include <atomic>
#include <binaryen/src/binaryen-c.h>
#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <exception>
#include <filesystem>
#include <fmt/base.h>
#include <memory>
#include <nlohmann/json.hpp>
#include <pass.h>
#include <sstream>
#include <stdexcept>
#include <string>
#include <support/colors.h>
#include <thread>
#include <utility>
#include <vector>
#include <wasm-binary.h>

#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"
#include "warpo/warp_runner/LinkedAPIAssemblyscript.hpp"
#include "warpo/warp_runner/WarpRunner.hpp"
#include "wasm-validator.h"
#include "wasm.h"

#include "src/core/runtime/TrapException.hpp"

namespace warpo {
namespace {

cli::Opt<bool> updateFlag{
    cli::Category::All,
    "-u",
    "--update",
    [](argparse::Argument &arg) { arg.help("update snapshot").flag(); },
};

enum class TestResult : uint8_t { Success, Failure, Skip };

class TestConfigJson {
  nlohmann::json const configJson_;

public:
  explicit TestConfigJson(nlohmann::json const &configJson) : configJson_(configJson) {
    assert(configJson_.is_object());
  }

  frontend::Config createConfig() const {
    frontend::Config config = frontend::getDefaultConfig();
    config.useColorfulDiagMessage = false;
    config.features =
        common::Features::bulkMemory() | common::Features::mutableGlobals() | common::Features::signExtension();
    if (configJson_.contains("asc_flags")) {
      nlohmann::json::array_t const &ascFlags = configJson_["asc_flags"].get<nlohmann::json::array_t>();
      for (nlohmann::basic_json<> const &flag : ascFlags) {
        if (flag == "--exportStart _start")
          config.exportStart = "_start";
        else if (flag == "--exportRuntime")
          config.exportRuntime = true;
        else if (flag == "--initialMemory 2")
          config.initialMemory = 2;
        else if (flag == "--use Date=")
          config.uses["Date"] = "";
        else if (flag == "--runtime incremental")
          static_cast<void>(0); // do nothing, incremental is default
        else if (flag == "--bindings raw")
          static_cast<void>(0); // do nothing, raw binding is default
        else if (flag == "--experimental")
          config.experimental = true;
        else if (flag == "--shrinkLevel 3")
          config.shrinkLevel = 3;
        else
          throw std::logic_error("unsupported asc_flag: " + flag.get<std::string>());
      }
    }
    return config;
  }
  bool hasNonTrappingF2IFeature() const {
    return configJson_.contains("features") &&
           std::ranges::any_of(configJson_["features"].get<nlohmann::json::array_t>(),
                               [](nlohmann::basic_json<> const &flag) { return flag == "nontrapping-f2i"; });
  }
  bool hasExportStart() const {
    return configJson_.contains("asc_flags") &&
           std::ranges::any_of(configJson_["asc_flags"].get<nlohmann::json::array_t>(),
                               [](nlohmann::basic_json<> const &flag) { return flag == "--exportStart _start"; });
  }
  bool checkErrorMessage() const { return configJson_.contains("stderr"); }
  std::vector<std::string> getExpectedErrorMessages() const {
    assert(checkErrorMessage());
    std::vector<std::string> expectedStderr;
    if (configJson_["stderr"].is_string()) {
      expectedStderr.push_back(configJson_["stderr"].get<std::string>());
    } else if (configJson_["stderr"].is_array()) {
      for (auto const &item : configJson_["stderr"]) {
        expectedStderr.push_back(item.get<std::string>());
      }
    }
    return expectedStderr;
  }
};

frontend::CompilationResult compile(TestConfigJson const &configJson, std::filesystem::path const &tsPath) {
  std::vector<std::string> const entries{tsPath.string()};
  return frontend::compile(nullptr, entries, configJson.createConfig());
}

[[nodiscard]] TestResult runModuleOnWarp(TestConfigJson const &configJson, std::filesystem::path const &tsPath,
                                         AsModule const &asModule) {
  bool const hasImportedGlobal = std::ranges::any_of(
      asModule.get()->globals, [](std::unique_ptr<wasm::Global> const &global) { return global->imported(); });
  if (hasImportedGlobal)
    return TestResult::Skip;
  if (configJson.hasNonTrappingF2IFeature())
    return TestResult::Skip;

  // lowering built-in imports
  passes::lowering(asModule);
  wasm::BufferWithRandomAccess buffer;
  wasm::WasmBinaryWriter writer(asModule.get(), buffer, wasm::PassOptions::getWithoutOptimization());
  writer.setNamesSection(false);
  writer.setEmitModuleName(false);
  writer.write();
  std::vector<uint8_t> wasm{static_cast<std::vector<uint8_t>>(buffer)};

  // validate
  if (!wasm::WasmValidator{}.validate(*asModule.get()))
    throw std::logic_error("validate error");

  // run
  WarpRunner r{nullptr};
  try {
    static std::vector<vb::NativeSymbol> const linkedAPI = frontend::createAssemblyscriptAPI();
    r.initFromBytecode(vb::Span<const uint8_t>{wasm.data(), wasm.size()},
                       vb::Span<vb::NativeSymbol const>{linkedAPI.data(), linkedAPI.size()}, false);
    r.start();
    if (configJson.hasExportStart())
      r.callExportedFunctionWithName<0>("_start");
  } catch (vb::TrapException &e) {
    fmt::println("FAILED '{}': execution trapped due to {}", tsPath.string(), e.what());
    return TestResult::Failure;
  } catch (vb::LinkingException &e) {
    // Linking failed is acceptable, skip unsupported function
    fmt::println("SKIP '{}': {}", tsPath.string(), e.what());
    return TestResult::Skip;
  } catch (const std::exception &e) {
    // Feature not implemented in warp is acceptable
    bool const featureNotImplemented = std::string(e.what()).find("feature not implemented") != std::string::npos;
    if (!featureNotImplemented) {
      fmt::println("FAILED '{}': {}", tsPath.string(), e.what());
      return TestResult::Failure;
    }
    fmt::println("SKIP '{}': {}", tsPath.string(), e.what());
    return TestResult::Skip;
  }

  return TestResult::Success;
}

[[nodiscard]] TestResult runUpdate(TestConfigJson const &configJson, std::filesystem::path const &tsPath,
                                   std::filesystem::path const &expectedOutPath) {
  if (configJson.checkErrorMessage())
    return TestResult::Success;
  frontend::CompilationResult const ret = compile(configJson, tsPath);
  if (ret.m.invalid()) {
    fmt::println("FAILED '{}': expected to compile successfully\nerror message: {}", tsPath.string(), ret.errorMessage);
    return TestResult::Failure;
  }
  std::stringstream ss;
  ss << *ret.m.get();
  std::string const actual = std::move(ss).str();
  writeBinaryFile(expectedOutPath.string(), actual);
  return runModuleOnWarp(configJson, tsPath, ret.m);
}

[[nodiscard]] TestResult runCompilationErrorCase(TestConfigJson const &configJson,
                                                 std::filesystem::path const &tsPath) {
  frontend::CompilationResult const ret = compile(configJson, tsPath);
  std::vector<std::string> const expectedStderr{configJson.getExpectedErrorMessages()};

  size_t lastIndex = 0;
  bool failed = false;
  for (std::string const &expectedErrorMessageLine : expectedStderr) {
    size_t const index = ret.errorMessage.find(expectedErrorMessageLine, lastIndex);
    if (index == std::string::npos) {
      fmt::println("\tmissing pattern '{}' in stderr.", expectedErrorMessageLine);
      failed = true;
    } else {
      lastIndex = index + expectedErrorMessageLine.length();
    }
  }
  if (failed) {
    fmt::println("\t========== actual error message==========\n"
                 "{}"
                 "\t========== actual error message==========",
                 ret.errorMessage);
    fmt::println("FAILED '{}': stderr mismatch", tsPath.string());
    return TestResult::Failure;
  }
  return TestResult::Success;
}

[[nodiscard]] TestResult runSnapshotCase(TestConfigJson const &configJson, std::filesystem::path const &tsPath,
                                         std::filesystem::path const &expectedOutPath) {
  frontend::CompilationResult const ret = compile(configJson, tsPath);
  if (ret.m.invalid()) {
    fmt::println("FAILED '{}': expected to compile successfully\nerror message: {}", tsPath.string(), ret.errorMessage);
    return TestResult::Failure;
  }
  std::stringstream ss;
  ss << *ret.m.get();
  std::string const actual = std::move(ss).str();
  std::string const expected = readTextFile(expectedOutPath.string());
  if (expected != actual) {
    fmt::println("FAILED '{}': mismatched wat output", tsPath.string());
    return TestResult::Failure;
  }
  return runModuleOnWarp(configJson, tsPath, ret.m);
}

[[nodiscard]] TestResult run(std::filesystem::path const &tsPath) {
  try {
    std::filesystem::path const jsonPath = replaceExtension(tsPath, ".json");
    nlohmann::json const j =
        nlohmann::json::parse(std::filesystem::exists(jsonPath) ? readTextFile(jsonPath.string()) : "{}");
    TestConfigJson const configJson{j};
    std::filesystem::path const expectedOutPath = replaceExtension(tsPath, ".wat");
    if (updateFlag.get())
      return runUpdate(configJson, tsPath, expectedOutPath);
    if (configJson.checkErrorMessage()) {
      if (std::filesystem::exists(expectedOutPath)) {
        fmt::println("{} should be removed when --stderr is specified.", expectedOutPath.string());
        std::abort();
      }
      return runCompilationErrorCase(configJson, tsPath);
    }
    return runSnapshotCase(configJson, tsPath, expectedOutPath);
  } catch (std::exception const &e) {
    fmt::println("FAILED '{}': unkown error {}", tsPath.string(), e.what());
    return TestResult::Failure;
  }
}

/// @brief Get all *.ts files recursively under the given folder.
void collectTestFilesImpl(std::vector<std::filesystem::path> &testFiles, std::filesystem::path const &folder) {
  for (std::filesystem::directory_entry const &entry : std::filesystem::directory_iterator{folder}) {
    if (entry.is_directory()) {
      // ignore all file inside node_modules
      if (entry.path().filename() == "node_modules")
        continue;
      collectTestFilesImpl(testFiles, entry.path());
    } else if (entry.is_regular_file()) {
      if (entry.path().extension() != ".ts")
        continue;
      // ignore .d.ts
      if (entry.path().stem().extension() == ".d")
        continue;
      testFiles.push_back(entry.path());
    }
  }
}

std::filesystem::path getTestFolder() {
  // __FILE__ is absolute path when compiled with MSVC /FC flag
  std::filesystem::path const folder = std::filesystem::path{__FILE__}.parent_path() / "compiler";
  return folder;
}

std::vector<std::filesystem::path> collectTestFiles(std::filesystem::path const &folder) {
  std::vector<std::filesystem::path> testFiles;
  collectTestFilesImpl(testFiles, folder);
  return testFiles;
}
// NOLINTNEXTLINE(modernize-avoid-c-arrays)
void frontendTestMain(int argc, const char *argv[]) {
  frontend::init();
  Colors::setEnabled(false);

  std::atomic<size_t> numFailed = 0;
  std::atomic<size_t> numSkipped = 0;

  argparse::ArgumentParser program("FrontendTest", "git@" GIT_COMMIT);
  cli::init(cli::Category::OnlyForTest, program, argc, argv);

  std::filesystem::path const testFolder = getTestFolder();
  std::filesystem::current_path(testFolder);
  std::vector<std::filesystem::path> const testFiles = collectTestFiles(testFolder);

  size_t const numThreads = std::max(1U, std::thread::hardware_concurrency());
  fmt::println("using {} threads for test execution.", numThreads);
  std::vector<std::thread> executeThread{};
  executeThread.reserve(numThreads);
  auto const executor = [&testFiles, &numFailed, &numSkipped, numThreads](size_t currentThreadId) -> void {
    size_t const chunkSize = (testFiles.size() / numThreads) + 1U;
    size_t const start = chunkSize * currentThreadId;
    size_t const end = std::min(chunkSize * (currentThreadId + 1U), testFiles.size());
    for (size_t i = start; i < end; i++) {
      TestResult const testResult = run(testFiles[i]);
      switch (testResult) {
      case TestResult::Success:
        break;
      case TestResult::Failure:
        numFailed++;
        break;
      case TestResult::Skip:
        numSkipped++;
        break;
      }
    }
  };
  for (size_t threadId = 0; threadId < numThreads; threadId++) {
    executeThread.emplace_back(executor, threadId);
  }
  for (auto &thread : executeThread) {
    thread.join();
  }

  if (numFailed > 0U)
    throw std::runtime_error("test failed");
  fmt::println("\x1b[32m[SUCCESS]\x1b[0m {} tests passed. ({} skipped)", testFiles.size() - numSkipped.load(),
               numSkipped.load());
}

} // namespace
} // namespace warpo

int main(int argc, const char *argv[]) {
  try {
    warpo::frontendTestMain(argc, argv);
  } catch (std::exception const &e) {
    fmt::println("ERROR: {}", e.what());
    return 1;
  }
}
