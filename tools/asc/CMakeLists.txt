aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_executable(warpo_asc ${sources})

target_link_libraries(warpo_asc
    PUBLIC warpo_frontend warpo_passes
)
target_include_directories(
    warpo_asc
    SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party"
)
set_target_properties(warpo_asc PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/warpo"
)
