// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstdlib>
#include <set>
#include <string>

#include "warpo/support/Debug.hpp"
#include "warpo/support/StringOperator.hpp"

namespace warpo {

namespace {

enum class MatchResult { Matched, NotMatched, NotSpecified };

MatchResult combineMatchResult(MatchResult a, MatchResult b) {
  if (a == MatchResult::NotMatched || b == MatchResult::NotMatched) {
    return MatchResult::NotMatched;
  }
  if (a == MatchResult::Matched || b == MatchResult::Matched) {
    return MatchResult::Matched;
  }
  return MatchResult::NotSpecified;
}

struct DebugHelper {
  static DebugHelper &ins() {
    static DebugHelper ins{};
    return ins;
  }

  bool isEnabledAll() const { return enabledAll; }
  MatchResult isEnableFunction(std::string_view functionName) const {
    return (DebugHelper::ins().enabledFunctionName.empty() || functionName.empty())     ? MatchResult::NotSpecified
           : DebugHelper::ins().enabledFunctionName.contains(std::string{functionName}) ? MatchResult::Matched
                                                                                        : MatchResult::NotMatched;
  }
  MatchResult isEnablePass(const char *passName) const {
    return (DebugHelper::ins().enabledPassName.empty() || passName == nullptr) ? MatchResult::NotSpecified
           : DebugHelper::ins().enabledPassName.contains(passName)             ? MatchResult::Matched
                                                                               : MatchResult::NotMatched;
  }

  bool forceEnable(bool newValue) {
    bool const old = enabledAll;
    enabledAll = newValue;
    return old;
  }

private:
  bool enabledAll;
  std::set<std::string> enabledPassName;
  std::set<std::string> enabledFunctionName;

  explicit DebugHelper() : enabledAll{false} {
    const char *const warpoDebug = std::getenv("WARPO_DEBUG");
    enabledAll = warpoDebug != nullptr && std::string(warpoDebug) == "1";
    const char *const warpoDebugPasses = std::getenv("WARPO_DEBUG_PASSES");
    if (warpoDebugPasses != nullptr)
      enabledPassName = splitString(warpoDebugPasses, ';');
    const char *const warpoDebugFunctionNames = std::getenv("WARPO_DEBUG_FUNCTIONS");
    if (warpoDebugFunctionNames != nullptr)
      enabledFunctionName = splitString(warpoDebugFunctionNames, ';');
  }
};

} // namespace

bool support::isDebug(const char *passName) {
  if (DebugHelper::ins().isEnabledAll()) {
    return true;
  }
  return DebugHelper::ins().isEnablePass(passName) == MatchResult::Matched;
}

bool support::isDebug(const char *passName, std::string_view functionName) {
  if (DebugHelper::ins().isEnabledAll()) {
    return true;
  }
  return combineMatchResult(DebugHelper::ins().isEnablePass(passName),
                            DebugHelper::ins().isEnableFunction(functionName)) == MatchResult::Matched;
}

bool support::forceEnable(bool newValue) { return DebugHelper::ins().forceEnable(newValue); }

} // namespace warpo
