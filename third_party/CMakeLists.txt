set(BUILD_TESTS OFF CACHE BOOL "force disable binaryen's deps" FORCE)
set(BUILD_STATIC_LIB ON)
add_subdirectory(binaryen)
