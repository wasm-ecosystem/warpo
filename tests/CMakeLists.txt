add_subdirectory(frontend)
add_subdirectory(DebugSymbol)

if(NOT WARPO_RELEASE)
    add_subdirectory(snapshot_diff/test_runner)
endif()
