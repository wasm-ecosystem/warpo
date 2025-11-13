aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_executable(warpo_visual ${sources})

target_link_libraries(warpo_visual
  PUBLIC
  warpo_support
)
target_include_directories(warpo_visual
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/protozero/include"
)
