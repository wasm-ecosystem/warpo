///
/// @file windows_clean.hpp
/// @copyright Copyright (C) 2021, BMW Group
///
#ifndef WINDOWS_CLEAN_H
#if defined(_WIN32) || defined(__CYGWIN__)

#ifdef __MINGW32__
#if _WIN32_WINNT != 0x0A00
#undef _WIN32_WINNT
#define _WIN32_WINNT 0x0A00
#endif
#endif

// clang-format off
#include <windows.h>
#include <memoryapi.h>
#include <malloc.h>
#include "wintt_undef.hpp"
// clang-format on
#endif
#endif
