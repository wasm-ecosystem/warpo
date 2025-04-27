aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

add_library(warpo_support ${sources})
target_link_libraries(warpo_support
  PUBLIC fmt::fmt
)
target_include_directories(warpo_support
  PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include"
  PUBLIC "${PROJECT_SOURCE_DIR}/third_party/binaryen/third_party/llvm-project/include"
)
