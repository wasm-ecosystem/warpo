aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_executable(warpo_visual ${sources})

target_link_libraries(warpo_visual
  PUBLIC
  perfetto_protobuf
  warpo_support
)
