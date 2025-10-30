aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_driver_sources)

add_library(warpo_driver ${warpo_driver_sources})

target_link_libraries(warpo_driver
    PRIVATE warpo_frontend warpo_passes warp_runner
    PUBLIC binaryen fmt::fmt warpo_common
)
target_include_directories(warpo_driver
    PUBLIC "${PROJECT_SOURCE_DIR}/include"
)
