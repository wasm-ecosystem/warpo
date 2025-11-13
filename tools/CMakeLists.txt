add_subdirectory(asc)
add_subdirectory(compiler)
add_subdirectory(optimizer)
add_subdirectory(trace_visualizer)

if(NOT WARPO_RELEASE)
  add_subdirectory(test_runner)
endif()
