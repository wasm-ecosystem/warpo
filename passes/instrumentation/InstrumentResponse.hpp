// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>
namespace warpo::passes::instrumentation {
///
/// @brief Status class that returned by instrumentation flow
///
enum class InstrumentationResponse : uint8_t {
  NORMAL = 0U,                      ///< success
  CONFIG_ERROR = 1U,                ///< configuration error
  CONFIG_FILEPATH_ERROR = 2U,       ///< path check error for configuration
  DEBUG_INFO_GENERATION_ERROR = 3U, ///< error during generate debug json info
  FILE_GENERATION_ERROR = 4U,       ///< instrumented file generation error
  EXPECT_INFO_GENERATION_ERROR = 5U ///< expectation info generation error
};

} // namespace warpo::passes::instrumentation
