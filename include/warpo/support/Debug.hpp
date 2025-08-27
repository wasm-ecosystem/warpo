#pragma once

#include <string_view>

namespace warpo::support {

bool isDebug(const char *passName);
bool isDebug(const char *passName, std::string_view functionName);

bool forceEnable(bool newValue);

struct ForceEnableRAII {
  bool oldValue;
  ForceEnableRAII(bool newValue) { oldValue = forceEnable(newValue); }
  ~ForceEnableRAII() { forceEnable(oldValue); }
};

} // namespace warpo::support
