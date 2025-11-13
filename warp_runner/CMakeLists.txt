aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warp_runner_sources)

add_library(warp_runner
  ${warp_runner_sources}
)

target_link_libraries(warp_runner
  PUBLIC binaryen vb_libWasmModule fmt::fmt vb_extensions
)
target_include_directories(warp_runner
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/third_party/llvm-project/include"
  PUBLIC "${PROJECT_SOURCE_DIR}/include"
)
