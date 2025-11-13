aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_executable(warpo_trace_visualizer ${sources})

target_link_libraries(warpo_trace_visualizer
  PUBLIC
  warpo_support
)
target_include_directories(warpo_trace_visualizer
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/protozero/include"
)
set_target_properties(warpo_trace_visualizer PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/warpo"
)
