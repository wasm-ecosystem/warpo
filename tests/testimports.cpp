#include "testimports.hpp"

#include "src/WasmModule/WasmModule.hpp"

namespace spectest {
#ifdef JIT_TARGET_TRICORE
std::vector<uint32_t> *ImportsMaker::lastStacktraceBuffer_ = nullptr;
#else
thread_local std::vector<uint32_t> *ImportsMaker::lastStacktraceBuffer_ = nullptr;
#endif
} // namespace spectest
