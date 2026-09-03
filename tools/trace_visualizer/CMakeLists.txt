set(LIB_NAME warpo_trace_visualizer)

if(NOT WARPO_RELEASE)
  include(GoogleTest)
  add_executable(${LIB_NAME}_test
    TraceBuilder.cpp
  )
  target_compile_definitions(${LIB_NAME}_test PRIVATE
    WARPO_ENABLE_UNIT_TESTS
  )
  target_link_libraries(${LIB_NAME}_test
    PUBLIC
    warpo_support
    gtest_main
    gmock
  )
  target_include_directories(${LIB_NAME}_test
    PUBLIC "${PROJECT_SOURCE_DIR}/include"
  )
  target_include_directories(${LIB_NAME}_test
    SYSTEM PRIVATE
    "${PROJECT_SOURCE_DIR}/third_party/protozero/include"
    "${PROJECT_SOURCE_DIR}/third_party"
  )
  gtest_add_tests(TARGET ${LIB_NAME}_test)
endif()

add_executable(${LIB_NAME}
  Main.cpp
  TraceBuilder.cpp
)

target_link_libraries(${LIB_NAME}
  PUBLIC
  warpo_support
)
target_include_directories(${LIB_NAME}
  PUBLIC "${PROJECT_SOURCE_DIR}/include"
)
target_include_directories(${LIB_NAME}
  SYSTEM PRIVATE
  "${PROJECT_SOURCE_DIR}/third_party/protozero/include"
  "${PROJECT_SOURCE_DIR}/third_party"
)
set_target_properties(${LIB_NAME} PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/warpo"
)
