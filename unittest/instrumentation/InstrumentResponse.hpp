#ifndef __ASC_INSTRUMENTATION_RESPONSE_HPP__
#define __ASC_INSTRUMENTATION_RESPONSE_HPP__
#include <cstdint>
namespace wasmInstrumentation {
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

} // namespace wasmInstrumentation

#endif
