aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warp_runner_sources)

add_library(warp_runner
  ${warp_runner_sources}
)

target_link_libraries(warp_runner
  PUBLIC vb_libWasmModule
)
add_dependencies(warp_runner vb_libWasmModule)
