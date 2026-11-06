add_subdirectory(ASC)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_frontend_sources)

add_library(warpo_frontend ${warpo_frontend_sources})
add_dependencies(warpo_frontend warpo_frontend_asc_wasm)

target_link_libraries(warpo_frontend
  PRIVATE warp_runner
  PUBLIC binaryen fmt::fmt warpo_common
)
target_include_directories(warpo_frontend
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
)
target_include_directories(warpo_frontend
  PUBLIC "${PROJECT_SOURCE_DIR}/include"
)
