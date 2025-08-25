set(CMAKE_CXX_STANDARD 26) # use c++ 26 to embed binary file

file(GLOB asc_sources "${PROJECT_SOURCE_DIR}/assemblyscript/**/*")
add_custom_command(
  COMMENT "Build ASC to WASM"
  OUTPUT ${PROJECT_SOURCE_DIR}/build-as/assemblyscript.inc
  DEPENDS ${asc_sources}
  WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}

  COMMAND npx
  ARGS asc --config asconfig.json --target debug

  COMMAND xxd
  ARGS -i build-as/assemblyscript.debug.wasm build-as/assemblyscript.inc
)

add_custom_target(warpo_frontend_asc_wasm_hpp ALL DEPENDS ${PROJECT_SOURCE_DIR}/build-as/assemblyscript.inc)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_frontend_asc_sources)

add_library(warpo_frontend_asc ${warpo_frontend_asc_sources})
add_dependencies(warpo_frontend_asc warpo_frontend_asc_wasm_hpp)
target_include_directories(warpo_frontend_asc PRIVATE ${PROJECT_SOURCE_DIR}/build-as)
