set(CMAKE_CXX_STANDARD 26) # use c++ 26 to embed binary file

if(WARPO_RELEASE)
  set(AS_BUILD_TARGET release)
else()
  set(AS_BUILD_TARGET debug)
endif()

message("build assemblyscript target: ${AS_BUILD_TARGET}")

file(GLOB_RECURSE asc_sources
  "${PROJECT_SOURCE_DIR}/assemblyscript/src/*.ts"
  "${PROJECT_SOURCE_DIR}/assemblyscript/std/*.ts"
  "${PROJECT_SOURCE_DIR}/assemblyscript/scripts/*.js"
  "${PROJECT_SOURCE_DIR}/assemblyscript_extension/src/*.ts"
  "${PROJECT_SOURCE_DIR}/assemblyscript_extension/std/*.ts"
)
set_source_files_properties(${asc_sources})

set(asc_target_folder "${CMAKE_BINARY_DIR}/build-as")

# Ensure the build-as directory exists
file(MAKE_DIRECTORY ${asc_target_folder})
add_custom_command(
  COMMENT "Build ASC<${AS_BUILD_TARGET}> to WASM"
  OUTPUT ${asc_target_folder}/assemblyscript.inc ${asc_target_folder}/library_sources.inc ${asc_target_folder}/library_sources_map.inc
  DEPENDS ${asc_sources} ${CMAKE_CURRENT_SOURCE_DIR}/gen.mjs ${PROJECT_SOURCE_DIR}/asconfig.json
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}

  COMMAND node
  ARGS gen.mjs ${asc_target_folder} ${AS_BUILD_TARGET}
)

add_custom_target(warpo_frontend_asc_wasm_hpp ALL DEPENDS ${asc_target_folder}/assemblyscript.inc ${asc_target_folder}/library_sources.inc ${asc_target_folder}/library_sources_map.inc)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_frontend_asc_sources)

add_library(warpo_frontend_asc ${warpo_frontend_asc_sources})
add_dependencies(warpo_frontend_asc warpo_frontend_asc_wasm_hpp)
target_include_directories(warpo_frontend_asc PRIVATE ${asc_target_folder})
