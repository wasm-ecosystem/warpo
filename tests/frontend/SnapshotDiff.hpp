#pragma once

#include <string_view>

namespace warpo {

void printCompactDiff(std::string_view expected, std::string_view actual);

} // namespace warpo
