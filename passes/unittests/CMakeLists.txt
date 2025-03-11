aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} unittests_helper_sources)
add_library(warpo_unittests_helper ${unittests_helper_sources})
target_link_libraries(warpo_unittests_helper PUBLIC
  binaryen
  gtest_main
)
target_include_directories(warpo_unittests_helper PUBLIC
  ${PROJECT_SOURCE_DIR}/third_party/binaryen/src
)
