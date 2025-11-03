#ifndef WARPO_SUPPORT_UNREACHABLE_HPP
#define WARPO_SUPPORT_UNREACHABLE_HPP

#ifndef UNREACHABLE
#ifdef _MSC_VER
#define UNREACHABLE __assume(0);
#elif (defined VB_GCC) || (defined __clang__)
#define UNREACHABLE __builtin_unreachable();
#else
static_assert(false, "C/C++ compiler not supported");
#endif
#endif

#endif