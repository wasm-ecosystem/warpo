aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_executable(warpo_asc ${sources})

target_link_libraries(warpo_asc
    PUBLIC warpo_frontend warpo_passes warpo_support
)
target_include_directories(
    warpo_asc
    SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party"
)
