aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_executable(warpo_compiler ${sources})

target_link_libraries(warpo_compiler
    PUBLIC warpo_frontend warpo_passes
)
target_include_directories(
    warpo_compiler
    SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party"
)
set_target_properties(warpo_compiler PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/warpo"
)
