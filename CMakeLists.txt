cmake_minimum_required(VERSION 3.15)
project(warpo)

set(CMAKE_CXX_STANDARD 20)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unknown-warning-option")

add_subdirectory(third_party EXCLUDE_FROM_ALL)

add_subdirectory(passes)
add_subdirectory(support)
add_subdirectory(tools)
