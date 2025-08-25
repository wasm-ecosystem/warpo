cmake_minimum_required(VERSION 3.20)
project(warpo)

option(WARPO_RELEASE "build for release" OFF)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unknown-warning-option")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")

add_definitions("-DLINEAR_MEMORY_BOUNDS_CHECKS=1")
add_definitions("-DACTIVE_STACK_OVERFLOW_CHECK=1")
add_definitions("-DNO_PASSIVE_PROTECTION_WARNING=1")

if(NOT WARPO_RELEASE)
  # keep assert during development
  set(CMAKE_CXX_FLAGS_RELEASE "-O3")
endif()

if(NOT CMAKE_BUILD_TYPE)
  if(WARPO_RELEASE)
    set(CMAKE_BUILD_TYPE Release)
  else()
    set(CMAKE_BUILD_TYPE Debug)
  endif()
endif()

add_subdirectory(third_party EXCLUDE_FROM_ALL)

add_subdirectory(frontend)
add_subdirectory(passes)
add_subdirectory(support)
add_subdirectory(tools)