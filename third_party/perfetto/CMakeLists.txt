aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} sources)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/protos/perfetto/trace sources)

add_library(perfetto_protobuf ${sources})
target_include_directories(perfetto_protobuf PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
