///
/// @file SanitizeHelper.hpp
/// @copyright Copyright (C) 2021
///
/// Helper definitions for Thread Sanitizer
///

#ifndef SANITIZE_HELPER_HPP
#define SANITIZE_HELPER_HPP

#if defined(__has_feature)
#if (__has_feature(thread_sanitizer))
#define COMPILER_SUPPORTS_THREAD_SANITIZER
#endif
#endif

#if !(defined COMPILER_SUPPORTS_THREAD_SANITIZER) && (defined __SANITIZE_THREAD__)
#define COMPILER_SUPPORTS_THREAD_SANITIZER
#endif

#ifdef COMPILER_SUPPORTS_THREAD_SANITIZER
#define NO_THREAD_SANITIZE __attribute__((no_sanitize("thread")))
#else
#define NO_THREAD_SANITIZE
#endif

#endif
