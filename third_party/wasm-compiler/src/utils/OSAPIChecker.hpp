///
/// @file OSAPIChecker.hpp
/// @copyright Copyright (C) 2021, BMW Group
///
#ifndef OS_API_CHECKER_HPP
#define OS_API_CHECKER_HPP

#include <cstdint>

namespace vb {
///
/// @brief The the return error code of OS api
///
/// @param msg Additional message for logging
/// @param errorCode The error code to be checked
/// @throws std::runtime_error error code is not 0
///
void checkSysCallReturn(const char *const msg, int32_t const errorCode);

} // namespace vb

#endif
