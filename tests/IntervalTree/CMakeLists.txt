set(testName TestIntervalTree)

aux_source_directory(${CMAKE_CURRENT_LIST_DIR} sourceFiles)

add_executable(${testName} ${sourceFiles})
target_link_libraries(${testName}
  PRIVATE warpo_passes gtest gtest_main
)
target_include_directories(${testName}
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
)
target_include_directories(${testName}
  PRIVATE "${PROJECT_SOURCE_DIR}"
)

add_test(NAME ${testName} COMMAND ${testName})
