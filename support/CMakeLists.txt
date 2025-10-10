find_package(Git QUIET)

set(GIT_COMMIT "unknown")

if(GIT_FOUND)
  execute_process(
    COMMAND ${GIT_EXECUTABLE} log -1 --pretty=format:%H
    OUTPUT_VARIABLE GIT_COMMIT
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_QUIET
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
  )
endif()

message(STATUS "Git commit: ${GIT_COMMIT}")

set(LIB_NAME warpo_support)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} ${LIB_NAME}_sources)

if(NOT WARPO_RELEASE)
  add_executable(${LIB_NAME}_test
    ${${LIB_NAME}_sources}
  )
  target_compile_definitions(${LIB_NAME}_test PRIVATE
    WARPO_ENABLE_UNIT_TESTS
  )
  target_link_libraries(${LIB_NAME}_test
    PUBLIC fmt::fmt
  )
  target_include_directories(${LIB_NAME}_test
    PUBLIC "${PROJECT_SOURCE_DIR}/include"
  )
  target_include_directories(${LIB_NAME}_test
    SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party"
  )
  target_include_directories(${LIB_NAME}_test
    SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party/binaryen/third_party/llvm-project/include"
  )
  target_link_libraries(${LIB_NAME}_test PUBLIC
    gtest_main
    gmock
  )
endif()

add_library(${LIB_NAME}
  ${${LIB_NAME}_sources}
)
target_link_libraries(${LIB_NAME}
  PUBLIC fmt::fmt
)
target_include_directories(${LIB_NAME}
  PUBLIC "${PROJECT_SOURCE_DIR}/include"
)
target_include_directories(${LIB_NAME}
  SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party/binaryen/third_party/llvm-project/include"
)
target_include_directories(${LIB_NAME}
  SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party"
)
target_compile_definitions(${LIB_NAME}
  PUBLIC
  GIT_COMMIT="${GIT_COMMIT}"
)
