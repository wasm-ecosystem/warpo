///
/// @file ILogger.hpp
/// @copyright Copyright (C) 2021
///
/// Placeholder implementation for the compiler logger
///

#ifndef ILOGGER_HPP
#define ILOGGER_HPP

#include <cstdint>

#include "Span.hpp"

namespace vb {

///
/// @brief Different log levels
///
enum class LogLevel : uint8_t { LOGERROR, LOGWARNING, LOGINFO, LOGDEBUG, LOGVERBOSE };

///
/// @brief Compiler logger interface with placeholder implementation
///
class ILogger {
public:
  ///
  /// @brief Default constructor
  ///
  ILogger() = default;

  ///
  /// @brief Default copy constructor
  ///
  ILogger(const ILogger &) = default;

  ///
  /// @brief Default move constructor
  ///
  ILogger(ILogger &&) = default;

  ///
  /// @brief Default copy operator
  ///
  /// @return ILogger& Reference to the assigned ILogger
  // coverity[autosar_cpp14_m9_3_3_violation]
  ILogger &operator=(const ILogger &) & = default;

  ///
  /// @brief Default move operator
  ///
  /// @return ILogger& Reference to the assigned ILogger
  // coverity[autosar_cpp14_m9_3_3_violation]
  ILogger &operator=(ILogger &&) & = default;

  ///
  /// @brief Default destructor
  ///
  virtual ~ILogger() = default;

  ///
  /// @brief Logs a string
  ///
  /// @param message String to log
  /// @return const ILogger& Returns a reference to the logger instance
  // coverity[autosar_cpp14_a15_4_4_violation]
  // coverity[autosar_cpp14_a13_2_2_violation]
  inline virtual ILogger &operator<<(char const *const message) {
    static_cast<void>(message);
    return *this;
  }

  ///
  /// @brief Logs part of a string
  ///
  /// @param message Span of the message to log
  /// @return const ILogger& Returns a reference to the logger instance
  // coverity[autosar_cpp14_a15_4_4_violation]
  // coverity[autosar_cpp14_a13_2_2_violation]
  inline virtual ILogger &operator<<(const vb::Span<char const> &message) {
    static_cast<void>(message);
    return *this;
  }

  ///
  /// @brief Logs an integer
  ///
  /// @param errorCode Integer to log
  /// @return const ILogger& Returns a reference to the logger instance
  // coverity[autosar_cpp14_a15_4_4_violation]
  // coverity[autosar_cpp14_a13_2_2_violation]
  inline virtual ILogger &operator<<(uint32_t const errorCode) {
    static_cast<void>(errorCode);
    return *this;
  }

  ///
  /// @brief Allows usage of vb::endStatement
  ///
  /// @param fnc Function to be executed with the corresponding ILogger
  /// @return ILogger&
  // coverity[autosar_cpp14_m7_1_2_violation]
  // coverity[autosar_cpp14_a15_4_4_violation]
  // coverity[autosar_cpp14_a13_2_2_violation]
  inline virtual ILogger &operator<<(ILogger &(*fnc)(ILogger &logger)) {
    return fnc(*this);
  }

  ///
  /// @brief Mark this statement as finished
  ///
  /// @param level Log level
  ///
  // coverity[autosar_cpp14_m7_1_2_violation]
  // coverity[autosar_cpp14_a15_4_4_violation]
  inline virtual void endStatement(const LogLevel level) {
    static_cast<void>(level);
  }
};

///
/// @brief Helper function to use inline analogous to std::endl and std::flush
///
/// @tparam level Level at which to log
/// @param logger Reference to the logger
/// @return ILogger&
///
// coverity[autosar_cpp14_a15_4_4_violation]
template <LogLevel level = LogLevel::LOGINFO> inline ILogger &endStatement(ILogger &logger) {
  logger.endStatement(level);
  return logger;
}

} // namespace vb
#endif
