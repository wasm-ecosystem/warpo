// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <chrono>
#include <cstddef>
#include <map>
#include <mutex>
#include <set>
#include <string>

#include "argparse/argparse.hpp"
#include "fmt/base.h"
#include "fmt/format.h"
#include "warpo/support/Opt.hpp"
#include "warpo/support/Statistics.hpp"

namespace warpo::support {

static cli::Opt<bool> EnableStatisticsOption{
    cli::Category::All,
    "--stats",
    [](argparse::Argument &arg) { arg.help("Prints statistics times.").flag().hidden(); },
};

static std::chrono::nanoseconds now() {
  return std::chrono::duration_cast<std::chrono::nanoseconds>(
      std::chrono::high_resolution_clock::now().time_since_epoch());
}

namespace {

struct PerformanceData {
  std::chrono::nanoseconds totalDuration_{0U};
  size_t cnt_ = 0;
};

const char *toString(PerfItemKind kind) {
  switch (kind) {
#define PERF_ITEM_KIND_TOP(name)                                                                                       \
  case PerfItemKind::name:                                                                                             \
    return #name;
#define PERF_ITEM_KIND_CHILD(parent, name)                                                                             \
  case PerfItemKind::parent##_##name:                                                                                  \
    return #parent "_" #name;
#include "warpo/support/StatisticsKinds.def"
  default:
    return "Unknown";
  }
}

std::string toString(std::chrono::nanoseconds ns) {
  uint64_t duration = static_cast<uint64_t>(ns.count());
  if (duration >= 1'000'000'000)
    return fmt::format("{:.3f}s", static_cast<double>(duration) / 1'000'000'000);
  if (duration >= 1'000'000)
    return fmt::format("{:.3f}ms", static_cast<double>(duration) / 1'000'000);
  if (duration >= 1'000)
    return fmt::format("{:.3f}µs", static_cast<double>(duration) / 1'000);
  return fmt::format("{:.3f}ns", static_cast<double>(duration));
}

class PerformanceCollector {
  std::mutex mutex_;
  std::map<PerfItemKind, PerformanceData> data_;

  void printNestedPerformanceData(size_t ident, PerfItemKind current,
                                  std::map<PerfItemKind, std::set<PerfItemKind>> const &nested) {
    fmt::println("{:>{}}- {}: {} times, total {}", "", ident * 2, toString(current), data_[current].cnt_,
                 toString(data_[current].totalDuration_));
    auto it = nested.find(current);
    if (it != nested.end()) {
      for (const auto &child : it->second)
        printNestedPerformanceData(ident + 1, child, nested);
    }
  }

public:
  PerformanceCollector() = default;
  PerformanceCollector(PerformanceCollector const &) = delete;
  PerformanceCollector(PerformanceCollector &&) = delete;
  PerformanceCollector &operator=(PerformanceCollector const &) = delete;
  PerformanceCollector &operator=(PerformanceCollector &&) = delete;

  static PerformanceCollector &ins() {
    static PerformanceCollector instance{};
    return instance;
  }

  void addData(PerfItemKind item, std::chrono::nanoseconds duration) {
    std::lock_guard<std::mutex> const lock(mutex_);
    PerformanceData &data = data_[item];
    data.totalDuration_ += duration;
    data.cnt_++;
  }

  ~PerformanceCollector() {
    std::map<PerfItemKind, std::set<PerfItemKind>> nested{};
#define PERF_ITEM_KIND_TOP(name)
#define PERF_ITEM_KIND_CHILD(parent, name) nested[PerfItemKind::parent].insert(PerfItemKind::parent##_##name);
#include "warpo/support/StatisticsKinds.def"

#define PERF_ITEM_KIND_TOP(name) printNestedPerformanceData(0U, PerfItemKind::name, nested);
#define PERF_ITEM_KIND_CHILD(parent, name)
#include "warpo/support/StatisticsKinds.def"
  }
};

} // namespace

PerfRAII::PerfRAII(PerfItemKind item) : item_(item), startTime_(now()) {
  if (!EnableStatisticsOption.get())
    return;
}

PerfRAII::~PerfRAII() {
  if (!free_)
    release();
}

void PerfRAII::release() {
  if (!EnableStatisticsOption.get())
    return;
  std::chrono::nanoseconds const endTime = now();
  PerformanceCollector::ins().addData(item_, endTime - startTime_);
  free_ = true;
}

} // namespace warpo::support
