#include "extensions/Tracing.hpp"

#include "src/core/runtime/Runtime.hpp"
#include "src/extensions/Extension.hpp"

void vb::extension::registerRuntime(vb::Runtime &runtime) {
  traceExtension.registerRuntime(runtime);
}

void vb::extension::unregisterRuntime(vb::Runtime &runtime) {
  traceExtension.unregisterRuntime(runtime);
}

void vb::extension::stop() {
  traceExtension.stopAndWriteData();
}
