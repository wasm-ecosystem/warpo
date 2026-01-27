# Copyright (C) 2025 wasm-ecosystem
# SPDX-License-Identifier: Apache-2.0

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)

if(EMSCRIPTEN)
  add_executable(wasm-instrumentation ${sources})

  target_link_libraries(wasm-instrumentation PUBLIC "-sSINGLE_FILE")
  target_link_libraries(wasm-instrumentation PUBLIC "-sFORCE_FILESYSTEM")
  target_link_libraries(wasm-instrumentation PUBLIC "-sALLOW_MEMORY_GROWTH")

  # target_link_libraries(wasm-instrumentation PUBLIC "-sINITIAL_MEMORY=33554432")
  target_link_libraries(wasm-instrumentation PUBLIC "-sNODERAWFS=1")
  target_link_libraries(wasm-instrumentation PUBLIC "-sENVIRONMENT=node")
  target_link_libraries(wasm-instrumentation PUBLIC "-sSTACK_SIZE=4mb")
  target_link_libraries(wasm-instrumentation PUBLIC "-sMODULARIZE=1")
  target_link_libraries(wasm-instrumentation PUBLIC "-sEXPORT_NAME=initInstrumenter")
  target_link_libraries(wasm-instrumentation PUBLIC "-sEXPORT_ES6=1")
  target_link_libraries(wasm-instrumentation PUBLIC "-sEXPORTED_RUNTIME_METHODS=allocateUTF8")
  target_link_libraries(wasm-instrumentation PUBLIC "-sEXPORTED_FUNCTIONS=_malloc,_free")
else()
  add_library(wasm-instrumentation ${sources})
endif()

target_link_libraries(wasm-instrumentation PUBLIC binaryen jsoncpp_static)
target_include_directories(wasm-instrumentation SYSTEM PUBLIC ${PROJECT_SOURCE_DIR}/third_party/binaryen/src ${PROJECT_SOURCE_DIR}/third_party/jsoncpp/include)
