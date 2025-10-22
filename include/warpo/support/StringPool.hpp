///
/// @file StringPool.hpp
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
#include <cstdint>
#include <memory>
#include <string>
#include <unordered_map>
namespace warpo {
class StringPool final {

public:
  std::string_view internString(std::string_view str);

private:
  using PoolType = std::unordered_map<std::string_view, std::unique_ptr<std::string>>;
  PoolType pool_;
};
} // namespace warpo