aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_library(warpo_passes ${sources})

target_link_libraries(warpo_passes
  PUBLIC binaryen
  PRIVATE warpo_support
)
target_include_directories(warpo_passes
  PRIVATE ${PROJECT_SOURCE_DIR}/third_party/binaryen/src
)
target_include_directories(warpo_passes
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
)
