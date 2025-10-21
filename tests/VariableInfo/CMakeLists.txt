project(TestVariableInfo)

aux_source_directory(${CMAKE_CURRENT_LIST_DIR} sourceFiles)

add_executable(${PROJECT_NAME} ${sourceFiles})
target_link_libraries(${PROJECT_NAME}
  PRIVATE warpo_frontend warp_runner warpo_passes gtest
)
target_include_directories(${PROJECT_NAME}
  SYSTEM PRIVATE "${ProjectRoot}/third_party/binaryen/src"
)
target_include_directories(${PROJECT_NAME}
  PRIVATE "${ProjectRoot}"
  "${ProjectRoot}/frontend"
)
