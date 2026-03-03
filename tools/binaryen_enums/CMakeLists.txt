add_executable(warpo_binaryen_enums_gen GenerateBinaryenEnums.cpp)

target_link_libraries(warpo_binaryen_enums_gen
    PRIVATE binaryen
    PRIVATE warpo_support
)

if(UNIX AND NOT APPLE)
    target_link_libraries(warpo_binaryen_enums_gen PRIVATE dl)
endif()

set_target_properties(warpo_binaryen_enums_gen PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
