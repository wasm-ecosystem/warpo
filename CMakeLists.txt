cmake_minimum_required(VERSION 3.15)
project(warpo)

set(CMAKE_CXX_STANDARD 20)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(NOT CMAKE_BUILD_TYPE)
  if(EMSCRIPTEN)
    set(CMAKE_BUILD_TYPE Release)
  else()
    set(CMAKE_BUILD_TYPE Debug)
  endif()
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unknown-warning-option")

add_subdirectory(third_party EXCLUDE_FROM_ALL)

if(EMSCRIPTEN)
  add_link_options("-sENVIRONMENT=node" "-sEXPORT_ES6=0") # runtime
  add_link_options("-sNODERAWFS=1") # file system
  add_link_options("-sALLOW_MEMORY_GROWTH" "-sSTACK_SIZE=4mb") # memory
  add_link_options("--post-js=${PROJECT_SOURCE_DIR}/tools/optimizer/EnvironmentLoader.js")
endif()

add_subdirectory(passes)
add_subdirectory(support)
add_subdirectory(tools)
