include(FetchContent)

set(_binaryen_version version_133)
string(TOLOWER "${CMAKE_SYSTEM_PROCESSOR}" _binaryen_processor)
if(CMAKE_GENERATOR_PLATFORM)
  string(TOLOWER "${CMAKE_GENERATOR_PLATFORM}" _binaryen_processor)
elseif(CMAKE_CXX_COMPILER_ARCHITECTURE_ID)
  string(TOLOWER "${CMAKE_CXX_COMPILER_ARCHITECTURE_ID}" _binaryen_processor)
endif()
if(APPLE AND CMAKE_OSX_ARCHITECTURES)
  set(_binaryen_processor "${CMAKE_OSX_ARCHITECTURES}")
endif()

if(_binaryen_processor MATCHES "^(x86_64|amd64|x64)$")
  set(_binaryen_arch x86_64)
elseif(_binaryen_processor MATCHES "^(aarch64|arm64)$")
  set(_binaryen_arch arm64)
else()
  message(FATAL_ERROR "No prebuilt Binaryen package for architecture: ${_binaryen_processor}")
endif()

set(_binaryen_type STATIC)
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set(_binaryen_os linux)
  set(_binaryen_library_name libbinaryen.a)
  if(_binaryen_arch STREQUAL "arm64")
    set(_binaryen_arch aarch64)
  endif()
elseif(APPLE)
  set(_binaryen_os macos)
  set(_binaryen_type SHARED)
  set(_binaryen_library_name libbinaryen.dylib)
elseif(MSVC)
  set(_binaryen_os windows)
  set(_binaryen_library_name binaryen.lib)
  message(WARNING "Official Binaryen is built with /MT in Release; warpo uses /MD. A compatible Binaryen package is required if MSVC reports a runtime-library mismatch. Debug also requires a matching Debug library.")
else()
  message(FATAL_ERROR "No prebuilt Binaryen package for this platform/toolchain")
endif()

set(_binaryen_archive "binaryen-${_binaryen_version}-${_binaryen_arch}-${_binaryen_os}.tar.gz")
set(_binaryen_url "https://github.com/WebAssembly/binaryen/releases/download/${_binaryen_version}/${_binaryen_archive}")
set(_binaryen_checksum "${CMAKE_BINARY_DIR}/_deps/${_binaryen_archive}.sha256")
if(NOT EXISTS "${_binaryen_checksum}")
  file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/_deps")
  file(DOWNLOAD "${_binaryen_url}.sha256" "${_binaryen_checksum}"
    TLS_VERIFY ON TIMEOUT 120 STATUS _binaryen_download_status)
  if(NOT _binaryen_download_status MATCHES "^0;")
    file(REMOVE "${_binaryen_checksum}")
    message(FATAL_ERROR "Binaryen checksum download failed: ${_binaryen_download_status}")
  endif()
endif()
file(READ "${_binaryen_checksum}" _binaryen_checksum_content)
string(REGEX MATCH "^[0-9a-fA-F]+" _binaryen_hash "${_binaryen_checksum_content}")
string(LENGTH "${_binaryen_hash}" _binaryen_hash_length)
if(NOT _binaryen_hash_length EQUAL 64)
  file(REMOVE "${_binaryen_checksum}")
  message(FATAL_ERROR "Invalid SHA-256 in Binaryen release checksum")
endif()

FetchContent_Declare(binaryen_prebuilt
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  URL "${_binaryen_url}"
  URL_HASH "SHA256=${_binaryen_hash}"
  SOURCE_SUBDIR _prebuilt_no_cmake)
FetchContent_Declare(binaryen_headers
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  URL "https://github.com/WebAssembly/binaryen/archive/refs/tags/${_binaryen_version}.tar.gz"
  SOURCE_DIR "${CMAKE_BINARY_DIR}/_deps/binaryen_headers/binaryen"
  SOURCE_SUBDIR _headers_only)
FetchContent_MakeAvailable(binaryen_prebuilt binaryen_headers)
add_library(binaryen_headers INTERFACE)
target_include_directories(binaryen_headers SYSTEM INTERFACE
  "${binaryen_headers_SOURCE_DIR}/.."
  "${binaryen_headers_SOURCE_DIR}/src"
  "${binaryen_headers_SOURCE_DIR}/third_party/llvm-project/include")

set(_binaryen_library "${binaryen_prebuilt_SOURCE_DIR}/lib/${_binaryen_library_name}")
if(NOT EXISTS "${_binaryen_library}")
  message(FATAL_ERROR "Binaryen release package does not contain ${_binaryen_library}")
endif()
find_package(Threads REQUIRED)
add_library(binaryen ${_binaryen_type} IMPORTED GLOBAL)
set_target_properties(binaryen PROPERTIES
  IMPORTED_LOCATION "${_binaryen_library}"
  INTERFACE_LINK_LIBRARIES "Threads::Threads;binaryen_headers"
  INTERFACE_COMPILE_FEATURES cxx_std_20)
message(STATUS "Linking downloaded Binaryen: ${_binaryen_library}")