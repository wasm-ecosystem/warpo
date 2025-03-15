cmake_minimum_required(VERSION 3.15)
project(warpo)

option(WARPO_RELEASE "build for release" OFF)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(NOT CMAKE_BUILD_TYPE)
  if(WARPO_RELEASE)
    set(CMAKE_BUILD_TYPE Release)
  else()
    set(CMAKE_BUILD_TYPE Debug)
  endif()
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unknown-warning-option")

add_subdirectory(third_party EXCLUDE_FROM_ALL)

add_subdirectory(passes)
add_subdirectory(support)
add_subdirectory(tools)
