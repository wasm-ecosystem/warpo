# Check if node_modules exists (npm dependencies must be installed first)
if(NOT EXISTS "${PROJECT_SOURCE_DIR}/node_modules")
  message(FATAL_ERROR "node_modules directory not found. Please run 'npm ci' or 'npm install' before building.")
endif()

if(WARPO_RELEASE)
  set(AS_BUILD_TARGET release)
else()
  set(AS_BUILD_TARGET debug)
endif()

message("build assemblyscript target: ${AS_BUILD_TARGET}")

file(GLOB_RECURSE asc_sources

  # sources
  "${PROJECT_SOURCE_DIR}/assemblyscript/src/*.ts"
  "${PROJECT_SOURCE_DIR}/assemblyscript/std/*.ts"

  # warpo extension
  "${PROJECT_SOURCE_DIR}/warpo_extension/src/*.ts"
  "${PROJECT_SOURCE_DIR}/warpo_extension/std/*.ts"

  # generator
  "${PROJECT_SOURCE_DIR}/frontend/ASC/*.mjs"
)
set_source_files_properties(${asc_sources})

set(asc_target_folder "${CMAKE_BINARY_DIR}/build-as")
set(asc_wasm_file "${PROJECT_SOURCE_DIR}/dist/asc.wasm")

file(MAKE_DIRECTORY ${asc_target_folder} ${PROJECT_SOURCE_DIR}/dist)
add_custom_command(
  COMMENT "Build ASC<${AS_BUILD_TARGET}> to WASM"
  OUTPUT ${asc_wasm_file}
  DEPENDS ${asc_sources} ${CMAKE_CURRENT_SOURCE_DIR}/gen.mjs ${PROJECT_SOURCE_DIR}/asconfig.json
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}

  COMMAND node
  ARGS gen.mjs ${asc_target_folder} ${AS_BUILD_TARGET} ${asc_wasm_file}
)

add_custom_target(warpo_frontend_asc_wasm ALL DEPENDS ${asc_wasm_file})
