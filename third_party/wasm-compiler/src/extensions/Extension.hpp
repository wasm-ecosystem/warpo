#ifndef SRC_EXTENSIONS_EXTENSION_HPP
#define SRC_EXTENSIONS_EXTENSION_HPP

#include "src/core/runtime/Runtime.hpp"

namespace vb {
namespace extension {

void registerRuntime(Runtime &runtime);
void unregisterRuntime(Runtime &runtime);
void stop();

} // namespace extension
} // namespace vb

#endif // SRC_EXTENSIONS_EXTENSION_HPP
