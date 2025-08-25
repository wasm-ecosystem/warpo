#ifndef DBG_FUZZ_HPP
#define DBG_FUZZ_HPP

#define GDB_FUZZ_INPUT_BINARY_INIT(MAXLENGTH)                                                                                                        \
  extern "C" {                                                                                                                                       \
  volatile uint8_t VBHELPER_GDB_FUZZ_INPUT_BINARY[MAXLENGTH];                                                                                        \
  volatile uint32_t VBHELPER_GDB_FUZZ_INPUT_BINARY_ACTUAL_LENGTH = 0U;                                                                               \
  volatile uint32_t VBHELPER_GDB_FUZZ_INPUT_REFOUTPUT_LENGTH = 0U;                                                                                   \
  volatile bool VBHELPER_GDB_FUZZ_ITERATION_FAILED = false;                                                                                          \
  volatile bool VBHELPER_INPUT_IS_ALREADY_COMPILED = false;                                                                                          \
  }

#define GDB_FUZZ_INPUT_BINARY &VBHELPER_GDB_FUZZ_INPUT_BINARY[0]

#define GDB_FUZZ_INPUT_BINARY_ACTUAL_LENGTH VBHELPER_GDB_FUZZ_INPUT_BINARY_ACTUAL_LENGTH
#define GDB_FUZZ_INPUT_REFOUTPUT_LENGTH VBHELPER_GDB_FUZZ_INPUT_REFOUTPUT_LENGTH
#define GDB_FUZZ_ITERATION_FAILED VBHELPER_GDB_FUZZ_ITERATION_FAILED

#define GDB_FUZZ_OUTPUT(MAXLENGTH)                                                                                                                   \
  extern "C" {                                                                                                                                       \
  uint8_t VBHELPER_GDB_FUZZ_OUTPUT_RESULT[MAXLENGTH];                                                                                                \
  uint32_t VBHELPER_GDB_FUZZ_OUTPUT_RESULT_LENGTH = 0U;                                                                                              \
  uint8_t VBHELPER_GDB_FUZZ_OUTPUT_MESSAGE[MAXLENGTH];                                                                                               \
  uint32_t VBHELPER_GDB_FUZZ_OUTPUT_MESSAGE_SIZE = 0;                                                                                                \
  }

#endif
