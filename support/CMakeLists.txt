set(LIB_NAME warpo_support)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} ${LIB_NAME}_sources)

if(NOT WARPO_RELEASE)
  add_executable(${LIB_NAME}_test ${${LIB_NAME}_sources})
  target_compile_definitions(${LIB_NAME}_test PRIVATE
    WARPO_ENABLE_UNIT_TESTS
  )
  target_link_libraries(${LIB_NAME}_test
    PUBLIC fmt::fmt
  )
  target_include_directories(${LIB_NAME}_test
    PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include"
    SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party/binaryen/third_party/llvm-project/include"
    SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party"
  )
  target_link_libraries(${LIB_NAME}_test PUBLIC
    gtest_main
    gmock
  )
endif()

add_library(${LIB_NAME} ${${LIB_NAME}_sources})
target_link_libraries(${LIB_NAME}
  PUBLIC fmt::fmt
)
target_include_directories(${LIB_NAME}
  PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include"
  SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party/binaryen/third_party/llvm-project/include"
  SYSTEM PUBLIC "${PROJECT_SOURCE_DIR}/third_party"
)
