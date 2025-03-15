
if(NOT WARPO_RELEASE)
  add_subdirectory(unittests)
endif()

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_passes_sources)

if(NOT WARPO_RELEASE)
  add_executable(warpo_passes_test ${warpo_passes_sources})
  target_compile_definitions(warpo_passes_test PRIVATE
    WARPO_ENABLE_UNIT_TESTS
  )
  target_link_libraries(warpo_passes_test
    PUBLIC warpo_support warpo_unittests_helper
  )
  target_include_directories(warpo_passes_test PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
  )
endif()

add_library(warpo_passes ${warpo_passes_sources})
target_link_libraries(warpo_passes
  PUBLIC binaryen fmt::fmt warpo_support
)
target_include_directories(warpo_passes
  PRIVATE ${PROJECT_SOURCE_DIR}/third_party/binaryen/src
)
target_include_directories(warpo_passes
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
)
