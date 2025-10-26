There are some features implemented in WARPO but not stable enough to release.

It is not enabled by default, a command line option `--experimental` is needed to enable experimental features.

# utf8 const string

In WARPO, string will be encoded to utf16 to ensure the same behavior with TS. But it is also a common requirement to use string in FFI.
In low level WebAssembly runtime, the native string most likely is utf8 encoded, for example rust or C++.

It is a experimental support to store the static string in linear memory with utf8 encoding to reduce the overhead in FFI.
