aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} perfetto_sources)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/protos/perfetto/trace perfetto_sources)

add_library(perfetto ${perfetto_sources})
target_include_directories(perfetto PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
