# Disable clang-tidy for third-party dependencies
unset(CMAKE_CXX_CLANG_TIDY)
unset(ENABLE_CLANG_TIDY)

set(BUILD_TESTS OFF CACHE BOOL "force disable binaryen's deps" FORCE)
set(ENABLE_WERROR OFF CACHE BOOL "disable -Werror for binaryen" FORCE)
set(BUILD_STATIC_LIB ON)
add_subdirectory(binaryen)

include(FetchContent)

FetchContent_Declare(
  fmt
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  URL https://github.com/fmtlib/fmt/releases/download/11.1.4/fmt-11.1.4.zip
)
FetchContent_MakeAvailable(fmt)
target_include_directories(fmt SYSTEM INTERFACE
  $<BUILD_INTERFACE:${fmt_SOURCE_DIR}/include>
)

FetchContent_Declare(
  googletest
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  URL https://github.com/google/googletest/releases/download/v1.16.0/googletest-1.16.0.tar.gz
)
FetchContent_MakeAvailable(googletest)

FetchContent_Declare(
  wasm-compiler
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  URL https://github.com/wasm-ecosystem/wasm-compiler/archive/refs/tags/4.0.0-alpha.0.tar.gz
)
set(ENABLE_EXTENSIONS ON)
FetchContent_MakeAvailable(wasm-compiler)
