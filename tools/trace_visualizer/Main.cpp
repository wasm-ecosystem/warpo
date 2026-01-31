// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <array>
#include <atomic>
#include <cassert>
#include <chrono>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <exception>
#include <filesystem>
#include <fmt/base.h>
#include <fstream>
#include <functional>
#include <ios>
#include <iostream>
#include <map>
#include <optional>
#include <protozero/pbf_writer.hpp>
#include <ranges>
#include <ratio>
#include <stdexcept>
#include <string>
#include <thread>
#include <utility>
#include <vector>

#include "Perfetto.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"

#if defined(__x86_64__) || defined(_M_X64)
#if defined(__clang__) || defined(__GNUC__)
#include <x86intrin.h>
#elif defined(_MSC_VER)
#include <intrin.h>
#endif
#elif defined(__aarch64__) || defined(_M_ARM64) || defined(_M_ARM64EC)
#if defined(_MSC_VER)
#include <intrin.h>
#include <winnt.h>
#endif
#endif

namespace warpo {

#if defined(__aarch64__) || defined(_M_ARM64) || defined(_M_ARM64EC)
#if defined(__clang__) || defined(__GNUC__)
static uint64_t getCurrentCPUCounterImpl() {
  uint64_t result;
  asm volatile("mrs %0, cntvct_el0" : "=r"(result));
  return result;
}
#elif defined(_MSC_VER)
static uint64_t getCurrentCPUCounterImpl() {
  return static_cast<uint64_t>(_ReadStatusReg(ARM64_SYSREG(3, 3, 14, 0, 2)));
}
#endif
#endif // defined(__aarch64__) || defined(_M_ARM64) || defined(_M_ARM64EC)

#if defined(__x86_64__) || defined(_M_X64)
#if defined(__clang__) || defined(__GNUC__)
static uint64_t getCurrentCPUCounterImpl() { return static_cast<uint64_t>(__rdtsc()); }
#elif defined(_MSC_VER)
static uint64_t getCurrentCPUCounterImpl() { return static_cast<uint64_t>(__rdtsc()); }
#endif
#endif // defined(__x86_64__) || defined(_M_X64)

static uint64_t getCurrentCPUCounter() {
  std::atomic_signal_fence(std::memory_order_seq_cst);
  uint64_t const counter = getCurrentCPUCounterImpl();
  std::atomic_signal_fence(std::memory_order_seq_cst);
  return counter;
};

static double measureCountToPerfettoTimestampRate() {
  std::chrono::high_resolution_clock::time_point const startTime = std::chrono::high_resolution_clock::now();
  uint64_t const startCount = getCurrentCPUCounter();
  std::atomic_signal_fence(std::memory_order_seq_cst);
  std::this_thread::sleep_for(std::chrono::microseconds(100));
  std::atomic_signal_fence(std::memory_order_seq_cst);
  std::chrono::high_resolution_clock::time_point const endTime = std::chrono::high_resolution_clock::now();
  uint64_t const endCount = getCurrentCPUCounter();
  double const elapsedTimeNs =
      std::chrono::duration_cast<std::chrono::duration<double, std::nano>>(
          std::chrono::duration_cast<std::chrono::duration<double, std::nano>>(endTime - startTime))
          .count();
  uint64_t const elapsedCount = endCount - startCount;
  if (elapsedCount == 0U) {
    fmt::println("Elapsed count is zero, cannot measure rate.");
    std::terminate();
  }

  double const rate = elapsedTimeNs / static_cast<double>(elapsedCount);
  fmt::println("measured count to Perfetto timestamp rate: {} ns/count", rate);
  return rate;
}

namespace {

struct Record {
  uint64_t uuid;
  uint64_t time;
  int64_t deltaTime;
  int32_t fnId;
};

class RecordReader {
  uint64_t lastCounter_ = 0U;
  uint64_t overflowCount_ = 0U;
  std::ifstream recordFile_;
  double const countToPerfettoTimestampRate_;
  std::optional<Record> nextRecord_;

  struct RawRecord {
    uint64_t uuid;
    uint32_t rawCounter;
    int32_t fnId;
  };
  std::optional<RawRecord> readRawRecord() {
    std::array<uint8_t, 16U> data{};
    recordFile_.read(reinterpret_cast<char *>(data.data()), data.size());
    if (recordFile_.gcount() < 16)
      return std::nullopt;

    uint64_t uuid;
    std::memcpy(&uuid, &data[0], sizeof(uuid));
    uint32_t rawCounter;
    std::memcpy(&rawCounter, &data[8], sizeof(rawCounter));
    int32_t fnId;
    std::memcpy(&fnId, &data[12], sizeof(fnId));
    return {{.uuid = uuid, .rawCounter = rawCounter, .fnId = fnId}};
  }

public:
  inline static constexpr double EPS = 1e-9;
  explicit RecordReader(std::ifstream recordFile, double countToPerfettoTimestampRate)
      : recordFile_(std::move(recordFile)), countToPerfettoTimestampRate_(std::abs(countToPerfettoTimestampRate) < EPS
                                                                              ? measureCountToPerfettoTimestampRate()
                                                                              : countToPerfettoTimestampRate) {
    std::string magic(16, '\0');
    recordFile_.read(magic.data(), 16);
    if (magic != "___WARP_TRACE___")
      throw std::runtime_error("Invalid trace record file");
  }

  std::optional<Record> nextRecord() {
    if (nextRecord_.has_value()) {
      Record record = *nextRecord_;
      nextRecord_.reset();
      return record;
    }
    std::optional<RawRecord> rawRecord = readRawRecord();
    if (!rawRecord.has_value())
      return std::nullopt;
    uint64_t refinedCounter = static_cast<uint64_t>(rawRecord->rawCounter) + (overflowCount_ << 32ULL);
    if (lastCounter_ > refinedCounter) {
      overflowCount_++;
      refinedCounter += 1ULL << 32ULL;
    }
    assert(lastCounter_ <= refinedCounter);
    int64_t const deltaTime = static_cast<int64_t>(refinedCounter - lastCounter_);
    lastCounter_ = refinedCounter;
    uint64_t const scaledTime =
        static_cast<uint64_t>(static_cast<double>(refinedCounter) * countToPerfettoTimestampRate_);
    // workaround for macos missing the first record issue
    if (scaledTime == 0) {
      nextRecord_ = nextRecord();
      return {{.uuid = rawRecord->uuid, .time = nextRecord_->time, .deltaTime = deltaTime, .fnId = rawRecord->fnId}};
    }
    return {{.uuid = rawRecord->uuid, .time = scaledTime, .deltaTime = deltaTime, .fnId = rawRecord->fnId}};
  }
};

class TraceBuilder {
public:
  TraceWriter writer_;

  explicit TraceBuilder(std::filesystem::path const &tracePointMappingFile,
                        std::filesystem::path const &traceRecordFile, double countToPerfettoTimestampRate,
                        uint32_t maxSliceCount)
      : recordReader_{std::ifstream{traceRecordFile, std::ios::in | std::ios::binary}, countToPerfettoTimestampRate},
        maxSliceCount_{maxSliceCount == 0U ? UINT32_MAX : maxSliceCount} {
    std::ifstream mappingFile(tracePointMappingFile, std::ios::in);
    std::string line;
    while (std::getline(mappingFile, line)) {
      size_t const index = line.find(' ');
      if (index != std::string::npos) {
        int32_t const fnId = std::stoi(line.substr(0, index));
        functionIndexes_[fnId] = line.substr(index + 1);
      }
    }
  }

  void process() {
    uint32_t sliceCount = 0;

    while (true) {
      if (pendingSlice_.empty()) {
        sliceCount++;
        if (sliceCount > maxSliceCount_)
          break;
      }
      std::optional<Record> record = recordReader_.nextRecord();
      // finish
      if (!record.has_value())
        break;

      if (record->fnId > 0) {
        pendingSlice_.push_back(record->fnId);
        if (pendingSlice_.size() == 1U)
          fmt::println("start slice '{}' in {}ms", functionIndexes_.at(record->fnId), record->time / 1000'000U);
        addBeginEvent(record->uuid, record->time, record->fnId);
      } else {
        PopCount const popCount = getPopCount(*record);
        if (!popCount.found) {
          std::cerr << "warning: No matching begin for end event " << record->fnId << " in " << record->time
                    << std::endl;
          if (!recoverFromMissingBegin(*record))
            return;
          continue;
        }
        if (popCount.additionalPopCount > 0U) {
          std::cerr << "warning: No matching end for begin event "
                    << pendingSlice_[pendingSlice_.size() - popCount.additionalPopCount] << " in " << record->time
                    << std::endl;
          if (!recoverFromMissingEnd(*record, popCount.additionalPopCount,
                                     record->time - static_cast<uint64_t>(record->deltaTime)))
            return;
          continue;
        }
        if (pendingSlice_.size() == 1U)
          fmt::println("end slice {} in {}ms", functionIndexes_.at(pendingSlice_.back()), record->time / 1000'000U);
        pendingSlice_.pop_back();
        addEndEvent(record->uuid, record->time);
      }
    }
  }

private:
  std::vector<int32_t> pendingSlice_;
  std::map<int32_t, std::string> functionIndexes_;
  RecordReader recordReader_;
  uint32_t const maxSliceCount_;

  struct PopCount {
    bool found = false;
    size_t additionalPopCount = 0;
  };
  PopCount getPopCount(Record const &record) {
    size_t popCount = 0;
    for (int32_t const it : std::ranges::reverse_view(pendingSlice_)) {
      if (it == -record.fnId)
        return {.found = true, .additionalPopCount = popCount};
      popCount++;
    }
    return {.found = false, .additionalPopCount = 0U};
  }

  // true for recover successfully
  [[nodiscard]] bool recoverFromMissingBegin(Record const &missingBeginRecord) {
    while (true) {
      std::optional<Record> record = recordReader_.nextRecord();
      // finish
      if (!record.has_value())
        return false;
      if (record->fnId > 0)
        continue;
      PopCount const popCount = getPopCount(*record);
      if (!popCount.found)
        continue;
      for (size_t i = 0; i < popCount.additionalPopCount; ++i) {
        pendingSlice_.pop_back();
        addEndEvent(missingBeginRecord.uuid, missingBeginRecord.time);
      }
      addFailedBeginEndEvent(missingBeginRecord.uuid, missingBeginRecord.time, record->time);
      pendingSlice_.pop_back();
      addEndEvent(record->uuid, record->time);
      return true;
    }
  }

  [[nodiscard]] bool recoverFromMissingEnd(Record const &record, size_t additionalPopCount, uint64_t lastTime) {
    for (size_t i = 0; i < additionalPopCount; ++i) {
      pendingSlice_.pop_back();
      addEndEvent(record.uuid, lastTime);
    }
    addFailedBeginEndEvent(record.uuid, lastTime, record.time);
    pendingSlice_.pop_back();
    addEndEvent(record.uuid, record.time);
    return true;
  }

  void addBeginEvent(uint64_t uuid, uint64_t time, int32_t fnId) {
    auto it = functionIndexes_.find(fnId);
    std::string const functionName =
        (it != functionIndexes_.end()) ? it->second : "unknown function " + std::to_string(fnId);
    addBeginEvent(uuid, time, functionName);
  }
  void addBeginEvent(uint64_t uuid, uint64_t time, std::string const &name) {
    writer_.writeTracePacket([&](TracePacketWriter &tracePacketWriter) -> void {
      tracePacketWriter.writeTimestamp(time);
      tracePacketWriter.writeTrustedPacketSequenceId(1U);
      tracePacketWriter.writeTrackEvent([&](TraceEventWriter &traceEventWriter) -> void {
        traceEventWriter.writeTrackUuid(uuid);
        traceEventWriter.writeName(name);
        traceEventWriter.writeType(TraceEventWriter::Type::TYPE_SLICE_BEGIN);
      });
    });
  }
  void addEndEvent(uint64_t uuid, uint64_t time) {
    writer_.writeTracePacket([&](TracePacketWriter &tracePacketWriter) -> void {
      tracePacketWriter.writeTimestamp(time);
      tracePacketWriter.writeTrustedPacketSequenceId(1U);
      tracePacketWriter.writeTrackEvent([&](TraceEventWriter &traceEventWriter) -> void {
        traceEventWriter.writeTrackUuid(uuid);
        traceEventWriter.writeType(TraceEventWriter::Type::TYPE_SLICE_END);
      });
    });
  }
  void addFailedBeginEndEvent(uint64_t uuid, uint64_t startTime, uint64_t endTime) {
    addBeginEvent(uuid, startTime, "UNKNOWN [lose data]");
    addEndEvent(uuid, endTime);
  }
};

} // namespace

static cli::Opt<std::filesystem::path> tracePointMappingFileOption{
    cli::Category::All,
    "--trace-point-mapping-file",
    [](argparse::Argument &arg) -> void { arg.required().help("File to read the trace point mapping."); },
};

static cli::Opt<std::filesystem::path> traceRecordFileOption{
    cli::Category::All,
    "--trace-point-record-file",
    [](argparse::Argument &arg) -> void { arg.required().help("File to read the trace point record."); },
};

static cli::Opt<std::filesystem::path> outputFileOption{
    cli::Category::All,
    "--output-pftrace-file",
    [](argparse::Argument &arg) -> void { arg.required().help("File to write the Perfetto trace data."); },
};

static cli::Opt<uint32_t> maxSliceCountOption{
    cli::Category::All,
    "--max-slice-count",
    [](argparse::Argument &arg) -> void {
      arg.help("Maximum number of slices to process. Slice means a complete call");
    },
};

static cli::Opt<double> countToPerfettoTimestampRateOption{
    cli::Category::All,
    "--count-to-perfetto-timestamp-rate",
    [](argparse::Argument &arg) -> void { arg.help("Rate to convert CPU count to Perfetto timestamp."); },
};

void traceVisualizerMain(int argc, const char **argv) {
  argparse::ArgumentParser program("warpo_trace_visualizer", "git@" GIT_COMMIT);
  cli::init(cli::Category::All, program, argc, argv);
  TraceBuilder builder{tracePointMappingFileOption.get(), traceRecordFileOption.get(),
                       countToPerfettoTimestampRateOption.get(), maxSliceCountOption.get()};
  builder.process();
  warpo::writeBinaryFile(outputFileOption.get(), builder.writer_.data_);
  std::cout << "Trace written to " << outputFileOption.get() << std::endl;
  std::cout << "Open with https://ui.perfetto.dev." << std::endl;
}

} // namespace warpo

int main(int argc, const char **argv) {
  try {
    warpo::traceVisualizerMain(argc, argv);
  } catch (std::exception const &e) {
    fmt::println("ERROR: {}", e.what());
    return 1;
  }
  return 0;
}
