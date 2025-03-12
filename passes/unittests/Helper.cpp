#include <gtest/gtest.h>
#include <memory>
#include <stdexcept>
#include <string_view>

#include "Helper.hpp"
#include "parser/wat-parser.h"
#include "wasm-features.h"
#include "wasm-validator.h"
#include "wasm.h"

namespace warpo::passes {

std::unique_ptr<wasm::Module> ut::loadWat(std::string_view wat) {
  std::unique_ptr<wasm::Module> m{new wasm::Module()};
  m->features = wasm::FeatureSet::All;
  auto parsed = wasm::WATParser::parseModule(*m, wat);
  if (auto *err = parsed.getErr())
    throw std::logic_error(err->msg);
  if (!wasm::WasmValidator{}.validate(*m))
    throw std::logic_error("validate error");
  return m;
}

} // namespace warpo::passes
