///
/// @file STDCompilerLogger.hpp
/// @copyright Copyright (C) 2022, BMW Group
///
#ifndef STD_COMPILER_LOGGER
#define STD_COMPILER_LOGGER

#include <iostream>

#include "src/core/common/ILogger.hpp"

namespace vb {
///
/// @brief Log compiler error message to std::cout
///
class STDCompilerLogger : public ILogger {
public:
  ///
  /// @brief Log const char*
  ///
  /// @param message
  /// @return const ILogger&
  ///
  inline ILogger &operator<<(char const *const message) override {
    std::cout << message;
    return *this;
  }
  ///
  /// @brief Log message in Span format
  ///
  /// @param message
  /// @return const ILogger&
  ///
  inline ILogger &operator<<(Span<char const> const &message) override {
    static_cast<void>(std::cout.write(message.data(), static_cast<std::streamsize>(message.size())));
    return *this;
  }
  ///
  /// @brief log error code
  ///
  /// @param errorCode
  /// @return const ILogger&
  ///
  inline ILogger &operator<<(uint32_t const errorCode) override {
    std::cout << errorCode;
    return *this;
  }

  /// @brief The type of function which can be executed by ILogger
  using ILoggerFunc = ILogger &(*)(ILogger &logger);
  ///
  /// @brief Allows usage of vb::endStatement
  ///
  /// @param fnc Function to be executed with the corresponding ILogger
  /// @return ILogger&
  inline ILogger &operator<<(ILoggerFunc const fnc) override {
    return ILogger::operator<<(fnc);
  }

  ///
  /// @brief Mark this statement as finished
  ///
  /// @param level Log level
  ///
  inline void endStatement(LogLevel const level) override {
    static_cast<void>(level);
    std::cout << std::endl;
  }
};

} // namespace vb

#endif
