#pragma once

#include <cstdint>
#include <regex>
#include <string>
#include <vector>

namespace warpo::passes {

enum class PresetOpt {
  AS_GC_LOWER,
  AS_GC_LOWER_WITH_LEAF_FUNCTION_FILTER,
  AS_GC_LOWER_WITH_SSA_MERGE,
  AS_GC_LOWER_WITH_OPTIMIZED_STACK_POSITION_ASSIGNER,
  AS_GC_LOWER_TEST_BASE,
};

inline PresetOpt getPresetOpt(std::string const &presetOptName) {
  if (presetOptName == "AS_GC_LOWER_TEST_BASE") {
    return PresetOpt::AS_GC_LOWER_TEST_BASE;
  } else if (presetOptName == "AS_GC_LOWER_WITH_LEAF_FUNCTION_FILTER") {
    return PresetOpt::AS_GC_LOWER_WITH_LEAF_FUNCTION_FILTER;
  } else if (presetOptName == "AS_GC_LOWER") {
    return PresetOpt::AS_GC_LOWER;
  } else if (presetOptName == "AS_GC_LOWER_WITH_SSA_MERGE") {
    return PresetOpt::AS_GC_LOWER_WITH_SSA_MERGE;
  } else if (presetOptName == "AS_GC_LOWER_WITH_OPTIMIZED_STACK_POSITION_ASSIGNER") {
    return PresetOpt::AS_GC_LOWER_WITH_OPTIMIZED_STACK_POSITION_ASSIGNER;
  }
  throw std::runtime_error("unknown preset option");
}

struct Output {
  std::string wat;
  std::vector<uint8_t> wasm;
};

void init();
Output runOnWat(std::string const &input);

std::string runOnWat(std::string const &input, PresetOpt presetOpt,
                     std::optional<std::regex> const &targetFunctionRegex);

} // namespace warpo::passes
