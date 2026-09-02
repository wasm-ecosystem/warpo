// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>
#include <filesystem>
#include <iosfwd>
#include <map>
#include <memory>
#include <optional>
#include <string>
#include <vector>

#include "Perfetto.hpp"

namespace warpo {

struct Record {
  uint64_t uuid;
  uint64_t time;
  int64_t deltaTime;
  int32_t fnId;
};

struct RawRecord {
  uint64_t uuid;
  uint32_t rawCounter;
  int32_t fnId;
};

class RecordReader {
public:
  inline static constexpr double EPS = 1e-9;

  explicit RecordReader(std::unique_ptr<std::istream> stream, double countToPerfettoTimestampRate = 0.0);
  explicit RecordReader(std::filesystem::path const &recordPath, double countToPerfettoTimestampRate = 0.0);

  std::optional<Record> nextRecord();

private:
  std::optional<RawRecord> readRawRecord();

  std::unique_ptr<std::istream> recordStream_;
  double countToPerfettoTimestampRate_{1.0};
  uint64_t lastCounter_{0U};
  uint64_t overflowCount_{0U};
  std::optional<Record> nextRecord_;
};

std::map<int32_t, std::string> loadMappingStream(std::istream &stream);
std::map<int32_t, std::string> loadMappingFile(std::filesystem::path const &mappingPath);

struct ModuleConfig {
  std::string name;
  std::map<int32_t, std::string> functionIndexes;
};

/// Parses JSON configuration mapping module ID to its name and mapping file path.
/// Supports decimal or hexadecimal string IDs, object, array, and string shorthand forms.
std::map<uint64_t, ModuleConfig>
parseMappingJson(std::string const &jsonContent,
                 std::filesystem::path const &baseDir = std::filesystem::current_path());

/// Loads and parses trace point mapping JSON file from disk.
std::map<uint64_t, ModuleConfig> loadMappingJsonFile(std::filesystem::path const &jsonPath);

class TraceBuilder {
public:
  TraceWriter writer_;

  /// Single module constructor (legacy backward-compatible mode)
  explicit TraceBuilder(std::filesystem::path const &tracePointMappingFile,
                        std::filesystem::path const &traceRecordFile, double countToPerfettoTimestampRate = 0.0,
                        uint32_t maxSliceCount = 0U);

  /// Multi-module constructor configured via JSON mapping file
  struct MappingJsonTag {};
  explicit TraceBuilder(MappingJsonTag tag, std::filesystem::path const &tracePointMappingJsonFile,
                        std::filesystem::path const &traceRecordFile, double countToPerfettoTimestampRate = 0.0,
                        uint32_t maxSliceCount = 0U);

  /// In-memory constructors for unit testing
  explicit TraceBuilder(std::map<uint64_t, ModuleConfig> modules, std::unique_ptr<RecordReader> reader,
                        uint32_t maxSliceCount = 0U);

  explicit TraceBuilder(std::map<int32_t, std::string> defaultFunctions, std::unique_ptr<RecordReader> reader,
                        uint32_t maxSliceCount = 0U);

  /// Process records and generate Perfetto TrackEvent/TrackDescriptor packets
  void process();

private:
  struct PopCount {
    bool found = false;
    size_t additionalPopCount = 0U;
  };

  std::string getFunctionName(uint64_t uuid, int32_t fnId) const;
  PopCount getPopCount(Record const &record);
  [[nodiscard]] bool recoverFromMissingBegin(Record const &missingBeginRecord);
  [[nodiscard]] bool recoverFromMissingEnd(Record const &record, size_t additionalPopCount, uint64_t lastTime);

  void addBeginEvent(uint64_t uuid, uint64_t time, int32_t fnId);
  void addBeginEvent(uint64_t uuid, uint64_t time, std::string const &name);
  void addEndEvent(uint64_t uuid, uint64_t time);
  void addFailedBeginEndEvent(uint64_t uuid, uint64_t startTime, uint64_t endTime);

  /// Per-module call stacks isolated by module uuid
  std::map<uint64_t, std::vector<int32_t>> pendingSlices_;
  /// Per-module display track names in Perfetto UI
  std::map<uint64_t, std::string> moduleNames_;
  /// Per-module function ID -> symbol name mappings
  std::map<uint64_t, std::map<int32_t, std::string>> moduleFunctionIndexes_;
  /// Default function mappings used in single-module mode
  std::map<int32_t, std::string> defaultFunctionIndexes_;
  std::unique_ptr<RecordReader> recordReader_;
  uint32_t maxSliceCount_{UINT32_MAX};
};

uint64_t getCurrentCPUCounter();
double measureCountToPerfettoTimestampRate();

} // namespace warpo
