set(testName TestDebugSymbol)

aux_source_directory(${CMAKE_CURRENT_LIST_DIR} sourceFiles)

add_executable(${testName} ${sourceFiles})
target_link_libraries(${testName}
  PRIVATE warpo_frontend warp_runner warpo_passes gtest
)
target_include_directories(${testName}
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
)
target_include_directories(${testName}
  PRIVATE "${PROJECT_SOURCE_DIR}"
  "${PROJECT_SOURCE_DIR}/frontend"
)
