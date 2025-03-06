aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_executable(warpo ${sources})

target_link_libraries(warpo PUBLIC warpo_passes warpo_support)
