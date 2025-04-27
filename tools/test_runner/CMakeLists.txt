aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_executable(warpo_test_runner ${sources})

target_link_libraries(warpo_test_runner PUBLIC warpo_passes warpo_support)
target_include_directories(warpo_test_runner SYSTEM PUBLIC ${PROJECT_SOURCE_DIR}/third_party)
