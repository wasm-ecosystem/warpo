#pragma once

#include <binaryen/src/binaryen-c.h>
#include <string>
#include <vector>

namespace warpo::frontend {

void init();

BinaryenModuleRef compile(std::vector<std::string> const &entryFilePaths);

} // namespace warpo::frontend
