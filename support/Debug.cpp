#include <cstdlib>

#include "support/Debug.hpp"

namespace warpo {

bool support::isDebug() {
  static bool enableDebugFromEnv = getenv("WARPO_DBBUG") != nullptr;
  return enableDebugFromEnv;
}

} // namespace warpo
