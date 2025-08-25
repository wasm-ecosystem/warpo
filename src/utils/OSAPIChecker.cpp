///
/// @file OSAPIChecker.hpp
/// @copyright Copyright (C) 2021, BMW Group
///
#include <cstdint>
// coverity[autosar_cpp14_m27_0_1_violation] Need perror
#include <cstdio>
#include <iostream>
#include <ostream>

#include "OSAPIChecker.hpp"

#include "src/core/common/VbExceptions.hpp"

namespace vb {

void checkSysCallReturn(const char *const msg, int32_t const errorCode) {
  if (errorCode != 0) {
    perror(msg);
    std::cout << "error code " << errorCode << &std::endl;
    throw vb::RuntimeError(ErrorCode::Syscall_failed);
  }
}

} // namespace vb
