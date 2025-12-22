# Disable clang-tidy for third-party dependencies
unset(CMAKE_CXX_CLANG_TIDY)
unset(ENABLE_CLANG_TIDY)

set(BUILD_TESTS OFF CACHE BOOL "force disable binaryen's deps" FORCE)
set(BUILD_STATIC_LIB ON)
add_subdirectory(binaryen)

include(FetchContent)

FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/releases/download/v1.16.0/googletest-1.16.0.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)
FetchContent_MakeAvailable(googletest)

FetchContent_Declare(
  wasm-compiler
  URL https://github.com/wasm-ecosystem/wasm-compiler/archive/refs/tags/3.0.5.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)
set(ENABLE_EXTENSIONS ON)
FetchContent_MakeAvailable(wasm-compiler)
