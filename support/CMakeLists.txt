aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_library(warpo_support ${sources})

target_include_directories(warpo_support
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
)
