aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_common_sources)

set(LIB_NAME warpo_common)

add_library(${LIB_NAME} ${warpo_common_sources})

target_link_libraries(${LIB_NAME}
  PUBLIC binaryen fmt::fmt warpo_support
)
target_include_directories(${LIB_NAME}
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
)
target_include_directories(${LIB_NAME}
  PUBLIC "${PROJECT_SOURCE_DIR}/include"
)

if(NOT WARPO_RELEASE)
  include(GoogleTest)
  add_executable(${LIB_NAME}_test ${warpo_common_sources})
  target_compile_definitions(${LIB_NAME}_test PRIVATE
    WARPO_ENABLE_UNIT_TESTS
  )
  target_link_libraries(${LIB_NAME}_test
    PUBLIC binaryen fmt::fmt warpo_support gtest_main
  )
  target_include_directories(${LIB_NAME}_test
    SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
  )
  target_include_directories(${LIB_NAME}_test
    PUBLIC "${PROJECT_SOURCE_DIR}/include"
  )
  gtest_add_tests(TARGET ${LIB_NAME}_test)
endif()
