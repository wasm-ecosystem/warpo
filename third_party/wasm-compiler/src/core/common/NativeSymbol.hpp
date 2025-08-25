///
/// @file NativeSymbol.hpp
/// @copyright Copyright (C) 2021 BMW Group
///
/// Definition of the NativeSymbol which can be used to create linkable host functions
///

#ifndef NATIVESYMBOL_HPP
#define NATIVESYMBOL_HPP

#include <cstdint>

namespace vb {

///
/// @brief Reference of a native symbol (e.g. a C++ function) that can be linked (as an imported symbol) to a Wasm
/// module by the compiler
///
struct NativeSymbol final {
  ///
  /// @brief Denotes how the native symbol (e.g. a C++ function) should be linked by the compiler
  ///
  enum class Linkage : uint8_t { STATIC, DYNAMIC };

  ///
  /// @brief Denoting the type of linkage, i.e. whether it will be statically linked during compilation or dynamically
  /// linked during initialization of the Runtime
  ///
  /// This field will not be read by the runtime since it is assumed that the runtime will only be given the dynamically
  /// linked NativeSymbols. Setting this to DYNAMIC and passing it to the compiler will be equivalent to a "placeholder"
  /// and will tell the compiler that the final symbol will be passed to the runtime
  ///
  Linkage linkage;

  ///
  /// @brief Name of the module as a pointer to a null-terminated string
  ///
  char const *module;

  ///
  /// @brief Name of the symbol as a pointer to a null-terminated string
  ///
  char const *symbol;

  ///
  /// @brief Signature of the symbol (function) as a pointer to a null-terminated string, see also SignatureType; e.g.
  /// (iIfF)f
  ///
  char const *signature;

  ///
  /// @brief The pointer to the native symbol (e.g. a function pointer if the symbol is a C++ function)
  ///
  /// Will not be read if the linkage is Linkage::DYNAMIC and it is passed to the compiler
  /// NOTE: The runtime will read this field irrespective of the Linkage
  ///
  void const *ptr;
};

} // namespace vb

#endif /* NATIVESYMBOL_H */
