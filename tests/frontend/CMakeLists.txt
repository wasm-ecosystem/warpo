add_executable(warpo_frontend_test
  FrontendTest.cpp
  SnapshotDiff.cpp
)

target_link_libraries(warpo_frontend_test
  PRIVATE warpo_frontend warp_runner
  PRIVATE warpo_passes # For lowering built-in imports
)
