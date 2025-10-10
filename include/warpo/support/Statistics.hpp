// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <chrono>

namespace warpo::support {

enum class PerfItemKind {
#define PERF_ITEM_KIND_TOP(name) name,
#define PERF_ITEM_KIND_CHILD(parent, name) parent##_##name,
#include "warpo/support/StatisticsKinds.def"
};

class PerfRAII {
  bool free_ = false;
  PerfItemKind item_;
  std::chrono::nanoseconds startTime_;

public:
  explicit PerfRAII(PerfItemKind item);
  PerfRAII(PerfRAII const &) = delete;
  PerfRAII &operator=(PerfRAII const &) = delete;
  PerfRAII(PerfRAII &&) = delete;
  PerfRAII &operator=(PerfRAII &&) = delete;
  ~PerfRAII();

  void release();
};

} // namespace warpo::support
