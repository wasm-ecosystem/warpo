#pragma once

#include <string_view>
namespace warpo::support {

bool isDebug(const char *passName);
bool isDebug(const char *passName, std::string_view functionName);

} // namespace warpo::support
