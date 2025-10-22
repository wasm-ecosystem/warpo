set(LIB_NAME warpo_passes)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_passes_sources)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/GC warpo_passes_sources)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/helper warpo_passes_sources)

if(NOT WARPO_RELEASE)
  include(GoogleTest)
  add_subdirectory(unittests)

  add_executable(${LIB_NAME}_test ${warpo_passes_sources})
  target_compile_definitions(${LIB_NAME}_test PRIVATE
    WARPO_ENABLE_UNIT_TESTS
  )
  target_link_libraries(${LIB_NAME}_test
    PUBLIC warpo_unittests_helper warpo_common
  )
  target_include_directories(${LIB_NAME}_test
    PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
    PUBLIC "${PROJECT_SOURCE_DIR}/include"
  )
  gtest_add_tests(TARGET ${LIB_NAME}_test)
endif()

if(WARPO_RELEASE)
  add_compile_definitions(
    -DWARPO_RELEASE_BUILD
  )
endif()

add_library(${LIB_NAME} ${warpo_passes_sources})
target_link_libraries(${LIB_NAME}
  PUBLIC binaryen fmt::fmt warpo_common
)
target_include_directories(${LIB_NAME}
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
)
target_include_directories(${LIB_NAME}
  PUBLIC "${PROJECT_SOURCE_DIR}/include"
)
