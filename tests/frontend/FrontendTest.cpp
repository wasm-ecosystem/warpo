// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <argparse/argparse.hpp>
#include <array>
#include <atomic>
#include <binaryen/src/binaryen-c.h>
#include <cassert>
#include <cstddef>
#include <exception>
#include <filesystem>
#include <fmt/base.h>
#include <memory>
#include <nlohmann/json.hpp>
#include <pass.h>
#include <passes/GC/OptLower.hpp>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <support/colors.h>
#include <thread>
#include <utility>
#include <vector>
#include <wasm-binary.h>

#include "LinkedAPI.hpp"
#include "warp_runner/warpRunner.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm-validator.h"
#include "wasm.h"

#include "src/WasmModule/WasmModule.hpp"
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

frontend::CompilationResult compile(nlohmann::json const &configJson, std::filesystem::path const &tsPath) {
  std::vector<std::string> const entries{tsPath.string()};
  frontend::Config config = frontend::getDefaultConfig();
  config.useColorfulDiagMessage = false;
  if (configJson.contains("asc_flags")) {
    nlohmann::json::array_t const &ascFlags = configJson["asc_flags"].get<nlohmann::json::array_t>();
    for (auto const &flag : ascFlags) {
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
      else if (flag == "--enableExtensions")
        config.enableExtensions = true;
    }
  }
  return frontend::compile(entries, config);
}

[[nodiscard]] TestResult runModuleOnWarp(AsModule const &asModule) {
  // skip unsupported test cases which has global imports
  if (std::ranges::any_of(asModule.get()->globals,
                          [](std::unique_ptr<wasm::Global> const &global) { return global->imported(); }))
    return TestResult::Skip;

  // lowering built-in imports
  wasm::PassRunner passRunner{asModule.get()};
  passRunner.add(std::unique_ptr<wasm::Pass>{new passes::gc::OptLower()});
  passRunner.run();
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
    r->initFromBytecode(vb::Span<const uint8_t>{wasm.data(), wasm.size()},
                        vb::Span<vb::NativeSymbol const>{linkedAPI.data(), linkedAPI.size()}, false);
    r->start(r.getStackTop());
  } catch (vb::TrapException &e) {
    std::cout << e.what() << ": " << static_cast<uint32_t>(e.getTrapCode()) << std::endl;
    return TestResult::Failure;
  } catch (vb::LinkingException &e) {
    // Linking failed is acceptable, skip unsupported function
    return TestResult::Skip;
  } catch (const std::exception &e) {
    // Feature not implemented in warp is acceptable
    bool const skip = std::string(e.what()).find("feature not implemented") != std::string::npos;
    if (!skip) {
      std::cout << e.what() << std::endl;
      return TestResult::Failure;
    }
    return TestResult::Skip;
  }

  return TestResult::Success;
}

[[nodiscard]] TestResult runUpdate(nlohmann::json const &configJson, std::filesystem::path const &tsPath,
                                   std::filesystem::path const &expectedOutPath) {
  frontend::CompilationResult const ret = compile(configJson, tsPath);
  if (ret.m.invalid()) {
    if (configJson.contains("stderr")) {
      return TestResult::Success;
    } else {
      fmt::println("FAILED '{}': expected to compile successfully\nerror message: {}", tsPath.c_str(),
                   ret.errorMessage);
      return TestResult::Failure;
    }
  }
  std::stringstream ss;
  ss << *ret.m.get();
  std::string actual = std::move(ss).str();
  writeBinaryFile(expectedOutPath, std::move(actual));
  return TestResult::Success;
}

[[nodiscard]] TestResult runCompilationErrorCase(nlohmann::json const &configJson,
                                                 std::filesystem::path const &tsPath) {
  frontend::CompilationResult const ret = compile(configJson, tsPath);
  if (ret.m.valid()) {
    fmt::println("'{}' success to compile but expect failed", tsPath.c_str());
    return TestResult::Failure;
  }
  assert(configJson.contains("stderr"));
  std::vector<std::string> expectedStderr;
  if (configJson["stderr"].is_string()) {
    expectedStderr.push_back(configJson["stderr"].get<std::string>());
  } else if (configJson["stderr"].is_array()) {
    for (auto const &item : configJson["stderr"]) {
      expectedStderr.push_back(item.get<std::string>());
    }
  }

  size_t lastIndex = 0;
  bool failed = false;
  for (auto const &expectedErrorMessageLineJson : configJson["stderr"].get<nlohmann::json::array_t>()) {
    std::string const expectedErrorMessageLine = expectedErrorMessageLineJson.get<std::string>();
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
    fmt::println("FAILED '{}': stderr mismatch", tsPath.c_str());
    return TestResult::Failure;
  }
  return TestResult::Success;
}

[[nodiscard]] TestResult runSnapshotCase(nlohmann::json const &configJson, std::filesystem::path const &tsPath,
                                         std::filesystem::path const &expectedOutPath) {
  frontend::CompilationResult const ret = compile(configJson, tsPath);
  if (ret.m.invalid()) {
    fmt::println("FAILED '{}': expected to compile successfully\nerror message: {}", tsPath.c_str(), ret.errorMessage);
    return TestResult::Failure;
  }
  std::stringstream ss;
  ss << *ret.m.get();
  std::string const actual = std::move(ss).str();
  std::string const expected = readTextFile(expectedOutPath);
  if (expected != actual) {
    fmt::println("FAILED '{}': mismatched wat output", tsPath.c_str());
    return TestResult::Failure;
  }
  return runModuleOnWarp(ret.m);
}

bool isAnyASCFlagsNotImplemented(nlohmann::json::array_t const &ascFlags, std::filesystem::path const &tsPath) {
  if (ascFlags.empty())
    return false;
  constexpr std::array<const char *, 7> allowedASCFlags = {
      "--exportStart _start", "--runtime incremental", "--initialMemory 2",  "--exportRuntime",
      "--bindings raw",       "--use Date=",           "--enableExtensions",
  };
  for (auto const &flag : ascFlags) {
    if (0 == std::count(std::begin(allowedASCFlags), std::end(allowedASCFlags), flag.get<std::string>())) {
      fmt::println("SKIP '{}': has not supported asc_flags '{}'", tsPath.c_str(), flag.get<std::string>());
      return true;
    }
  }
  return false;
}

bool shouldSkipTestCase(nlohmann::json const &configJson, std::filesystem::path const &tsPath) {
  constexpr const char *ascFlags = "asc_flags";
  constexpr const char *features = "features";
  if (configJson.contains(ascFlags)) {
    if (isAnyASCFlagsNotImplemented(configJson[ascFlags].get<nlohmann::json::array_t>(), tsPath))
      return true;
  }
  if (configJson.contains(features) && !configJson[features].get<nlohmann::json::array_t>().empty()) {
    fmt::println("SKIP '{}': has not supported features", tsPath.c_str());
    return true;
  }
  return false;
}

[[nodiscard]] TestResult run(std::filesystem::path const &tsPath) {
  try {
    std::filesystem::path const jsonPath = replaceExtension(tsPath, ".json");
    nlohmann::json const configJson =
        std::filesystem::exists(jsonPath) ? nlohmann::json::parse(readTextFile(jsonPath)) : nlohmann::json{};
    if (shouldSkipTestCase(configJson, tsPath))
      return TestResult::Skip;
    std::filesystem::path const expectedOutPath = replaceExtension(tsPath, ".wat");
    if (updateFlag.get())
      return runUpdate(configJson, tsPath, expectedOutPath);
    if (!std::filesystem::exists(expectedOutPath)) {
      return runCompilationErrorCase(configJson, tsPath);
    } else {
      return runSnapshotCase(configJson, tsPath, expectedOutPath);
    }
  } catch (std::exception const &e) {
    fmt::println("FAILED '{}': unkown error {}", tsPath.c_str(), e.what());
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
