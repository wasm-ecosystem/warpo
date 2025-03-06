#include <cstdlib>

#include "support/Debug.hpp"

namespace warpo {

bool support::isDebug() { return getenv("WARPO_DBBUG") != nullptr; }

} // namespace warpo
