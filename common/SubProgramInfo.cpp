///
/// @file SubProgramInfo.hpp
/// @copyright Copyright (C) 2025 wasm-ecosystem
/// SPDX-License-Identifier: Apache-2.0
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

#include "warpo/common/SubProgramInfo.hpp"

namespace warpo {
void SubProgramInfo::addParameter(std::string variableName, std::string_view const typeName, uint32_t const index,
                                  bool const nullable) {

  addParameter(ParameterInfo{
      std::move(variableName),
      typeName,
      index,
      nullable,
  });
}

void SubProgramInfo::addLocal(std::string variableName, std::string_view const typeName, uint32_t const index,
                              bool const nullable) {

  LocalInfo local{
      std::move(variableName),
      typeName,
      LocalIndexLocation{index},
      nullable,
  };
  if (blockInfoStack_.empty()) {
    locals_.push_back(std::move(local));
  } else {
    blockInfoStack_.back()->addLocal(std::move(local));
  }
}

void SubProgramInfo::addTupleLocal(std::string variableName, std::string_view const typeName,
                                   uint32_t const tupleFieldOffset, uint32_t const storageLocalIndex,
                                   bool const nullable) {

  LocalInfo local{
      std::move(variableName),
      typeName,
      TupleFieldLocation{tupleFieldOffset, storageLocalIndex},
      nullable,
  };
  if (blockInfoStack_.empty()) {
    locals_.push_back(std::move(local));
  } else {
    blockInfoStack_.back()->addLocal(std::move(local));
  }
}

void SubProgramInfo::addTupleParameter(std::string variableName, std::string_view const typeName,
                                       uint32_t const tupleFieldOffset, uint32_t const storageLocalIndex,
                                       bool const nullable) {

  addParameter(ParameterInfo{
      std::move(variableName),
      typeName,
      TupleFieldLocation{tupleFieldOffset, storageLocalIndex},
      nullable,
  });
}

void SubProgramInfo::enterBlock(uint32_t const startLine, uint32_t const endLine) {
  blockInfoStack_.push_back(std::make_unique<BlockInfo>(startLine, endLine));
}

void SubProgramInfo::leaveBlock() {
  std::unique_ptr<BlockInfo> last = std::move(blockInfoStack_.back());
  blockInfoStack_.pop_back();
  if (blockInfoStack_.empty()) {
    blocks_.push_back(std::move(last));
  } else {
    blockInfoStack_.back()->pushChild(std::move(last));
  }
}
} // namespace warpo