///
/// @file TrapException.hpp
/// @copyright Copyright (C) 2021 BMW Group
///

#ifndef TRAP_EXCEPTION_HPP
#define TRAP_EXCEPTION_HPP

#include <exception>

#include "src/core/common/TrapCode.hpp"

namespace vb {

///
/// @brief Exception class for WebAssembly traps
///
// coverity[autosar_cpp14_m3_4_1_violation]
class TrapException final : public std::exception {
public:
  ///
  /// @brief Constructor for a TrapException and a given TrapCode
  ///
  /// @param trapCode
  // NOLINTNEXTLINE(readability-redundant-member-init)
  inline explicit TrapException(TrapCode const trapCode) VB_NOEXCEPT : std::exception(), trapCode_(trapCode) {
  }

  ///
  /// @brief Get the stored TrapCode
  ///
  /// @return TrapCode Stored TrapCode
  inline TrapCode getTrapCode() const VB_NOEXCEPT {
    return trapCode_;
  };

  ///
  /// @brief Get a human readable message for this exception and the stored TrapCode
  ///
  /// @return const char*
  inline const char *what() const noexcept final {
    if (static_cast<uint32_t>(trapCode_) >= trapCodeErrorMessages.size()) {
      return "Unknown trap";
    } else {
      return trapCodeErrorMessages[static_cast<uint32_t>(trapCode_)];
    }
  }

  ///
  /// @brief Default copy constructor
  ///
  TrapException(const TrapException &) = default;
  ///
  /// @brief Default move constructor
  ///
  TrapException(TrapException &&) VB_NOEXCEPT = default;
  ///
  /// @brief Default copy operator
  ///
  TrapException &operator=(const TrapException &) & = default;
  ///
  /// @brief Default move operator
  ///
  TrapException &operator=(TrapException &&) &VB_NOEXCEPT = default;
  ///
  /// @brief Default destructor
  ///
  ~TrapException() VB_NOEXCEPT final = default;

private:
  TrapCode trapCode_; ///< Stored TrapCode
};

} // namespace vb

#endif
