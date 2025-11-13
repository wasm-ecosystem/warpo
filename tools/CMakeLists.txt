add_subdirectory(asc)
add_subdirectory(compiler)
add_subdirectory(optimizer)

if(NOT WARPO_RELEASE)
  add_subdirectory(test_runner)
endif()
