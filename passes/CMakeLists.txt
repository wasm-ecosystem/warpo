set(LIB_NAME warpo_passes)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_passes_sources)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/GC warpo_passes_sources)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/helper warpo_passes_sources)

if(NOT WARPO_RELEASE)
  add_subdirectory(unittests)

  add_executable(${LIB_NAME}_test ${warpo_passes_sources})
  target_compile_definitions(${LIB_NAME}_test PRIVATE
    WARPO_ENABLE_UNIT_TESTS
  )
  target_link_libraries(${LIB_NAME}_test
    PUBLIC warpo_support warpo_unittests_helper
  )
  target_include_directories(${LIB_NAME}_test PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
  )
endif()

if(WARPO_RELEASE)
  add_compile_definitions(
    -DWARPO_RELEASE_BUILD
  )
endif()

add_library(${LIB_NAME} ${warpo_passes_sources})
target_link_libraries(${LIB_NAME}
  PUBLIC binaryen fmt::fmt warpo_support
)
target_include_directories(${LIB_NAME}
  PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
)
target_include_directories(${LIB_NAME}
  PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
