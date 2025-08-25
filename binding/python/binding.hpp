#ifndef BINDING_PYTHON_BINDING_HPP
#define BINDING_PYTHON_BINDING_HPP

#include <pybind11/pybind11.h>

#include "src/core/common/ExtendableMemory.hpp"

namespace vb {
namespace binding {

extern void bindingCompiler(pybind11::module_ &m);
extern void bindingRuntime(pybind11::module_ &m);

void memoryFnc(ExtendableMemory &currentObject, uint32_t minimumLength, void *const ctx);
void *allocFnc(uint32_t size, void *ctx);
void freeFnc(void *ptr, void *ctx);

} // namespace binding
} // namespace vb

#endif // BINDING_PYTHON_BINDING_HPP
