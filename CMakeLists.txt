cmake_minimum_required(VERSION 3.20)
project(warpo)
enable_testing()

option(WARPO_RELEASE "build for release" OFF)
option(WARPO_SANITIZE "enable address sanitizer" OFF)
option(ENABLE_CLANG_TIDY "Enable clang-tidy static analysis" OFF)
option(ENABLE_WERROR "Enable warnings as errors" OFF)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(NOT CMAKE_BUILD_TYPE)
  if(WARPO_RELEASE)
    set(CMAKE_BUILD_TYPE Release)
  else()
    set(CMAKE_BUILD_TYPE Debug)
  endif()
endif()

add_definitions("-DINTERRUPTION_REQUEST=0")
add_definitions("-DEAGER_ALLOCATION=1")

add_subdirectory(third_party EXCLUDE_FROM_ALL)

if(MSVC)
  add_definitions(-D_CRT_SECURE_NO_WARNINGS)
  add_compile_options(/W4 /EHsc)

  if(ENABLE_WERROR)
    add_compile_options(/WX)
  endif()

  set(CMAKE_SUPPRESS_REGENERATION ON)
  add_compile_options(/MP)
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unknown-warning-option")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")

  if(WARPO_SANITIZE)
    add_compile_options(-fsanitize=address)
    add_link_options(-fsanitize=address)
  endif()

  add_compile_options(
    -Wall
    -Wextra
    -Wpedantic
    -Wformat=2
    -Wformat-security
    -Werror=format-security
    -Wcast-align
    -Wcast-qual
    -Wconversion
    -Wdouble-promotion
    -Wfloat-equal
    -Wmissing-include-dirs
    -Wredundant-decls
    -Wsign-conversion
    -Wswitch
    -Wuninitialized
    -Wunused-parameter
    -Walloca
    -Wunused-result
    -Wunused-local-typedefs
    -Wwrite-strings
    -Wpointer-arith
    -Wfloat-conversion
    -Wnull-dereference
    -Wdiv-by-zero
    -Wunknown-pragmas
  )

  if((CMAKE_CXX_COMPILER_ID STREQUAL "GNU") AND(NOT(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "11")))
    add_compile_options(
      -Wformat-signedness
      -Walloc-zero
      -Wduplicated-branches
      -Wduplicated-cond
      -Wimplicit-fallthrough=5
      -Wlogical-op
      -Wenum-conversion
      -Wliteral-suffix
      -Wno-builtin-macro-redefined
      -Wno-unknown-warning-option
      -Wdeprecated-copy

      # negative
      -Wno-switch-unreachable
    )
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
    add_compile_options(
      -Wenum-conversion

      # negative
    )
  endif()

  set(cxx_warning_flags -Wnon-virtual-dtor -Wold-style-cast)

  add_compile_options(
    "$<$<COMPILE_LANGUAGE:CXX>:${cxx_warning_flags}>"
  )

  if(ENABLE_WERROR)
    add_compile_options(-Werror)
  endif()

  if(ENABLE_CLANG_TIDY)
    set(CMAKE_CXX_CLANG_TIDY clang-tidy --config-file ${CMAKE_CURRENT_LIST_DIR}/.clang-tidy "--header-filter=${CMAKE_CURRENT_LIST_DIR}/(frontend|common|passes|support|tools|tests|include)/.*")

    if(ENABLE_WERROR)
      set(CMAKE_CXX_CLANG_TIDY ${CMAKE_CXX_CLANG_TIDY} -warnings-as-errors=*)
    endif()
  endif()
endif()

add_subdirectory(common)
add_subdirectory(frontend)
add_subdirectory(passes)
add_subdirectory(support)
add_subdirectory(tools)
add_subdirectory(tests)
