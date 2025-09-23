aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_executable(warpo_opt ${sources})

target_link_libraries(
    warpo_opt PUBLIC warpo_passes
)
target_include_directories(
    warpo_opt SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party"
)
set_target_properties(warpo_opt PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/warpo"
)
