aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_common_sources)

add_library(warpo_common ${warpo_common_sources})

target_link_libraries(warpo_common
  PUBLIC binaryen fmt::fmt warpo_support
)
target_include_directories(warpo_common
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
)
target_include_directories(warpo_common
  PUBLIC "${PROJECT_SOURCE_DIR}/include"
)
