add_executable(warpo_frontend_test FrontendTest.cpp)
if(MSVC)
  target_compile_options(warpo_frontend_test PRIVATE /FC)
endif()
target_link_libraries(warpo_frontend_test
  PRIVATE warpo_frontend warp_runner
  PRIVATE warpo_passes # For lowering built-in imports
)
target_include_directories(warpo_frontend_test
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
)
