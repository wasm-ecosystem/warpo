///
/// @file Unreachable.hpp
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
#pragma once

#ifndef WARPO_UNREACHABLE
#ifdef _MSC_VER
#define WARPO_UNREACHABLE __assume(0)
#elif (defined __GNUC__) || (defined __clang__)
#define WARPO_UNREACHABLE __builtin_unreachable()
#else
static_assert(false, "C/C++ compiler not supported");
#endif
#endif
