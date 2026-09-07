// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <array>
#include <atomic>
#include <cassert>
#include <charconv>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <exception>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fstream>
#include <ios>
#include <map>
#include <memory>
#include <nlohmann/json.hpp>
#include <optional>
#include <ranges>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <thread>
#include <utility>
#include <vector>

#include "TraceBuilder.hpp"

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

uint64_t getCurrentCPUCounter() {
  std::atomic_signal_fence(std::memory_order_seq_cst);
  uint64_t const counter = getCurrentCPUCounterImpl();
  std::atomic_signal_fence(std::memory_order_seq_cst);
  return counter;
}

double measureCountToPerfettoTimestampRate() {
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
    fmt::println(stderr, "Elapsed count is zero, cannot measure rate.");
    std::terminate();
  }

  double const rate = elapsedTimeNs / static_cast<double>(elapsedCount);
  fmt::println("measured count to Perfetto timestamp rate: {} ns/count", rate);
  return rate;
}

RecordReader::RecordReader(std::unique_ptr<std::istream> stream, double countToPerfettoTimestampRate)
    : recordStream_{std::move(stream)},
      countToPerfettoTimestampRate_{std::abs(countToPerfettoTimestampRate) < EPS ? measureCountToPerfettoTimestampRate()
                                                                                 : countToPerfettoTimestampRate} {
  if (!recordStream_ || !recordStream_->good())
    throw std::runtime_error("Invalid record stream");

  std::string magic(16U, '\0');
  recordStream_->read(magic.data(), 16);
  if (magic != "___WARP_TRACE___")
    throw std::runtime_error("Invalid trace record file");
}

RecordReader::RecordReader(std::filesystem::path const &recordPath, double countToPerfettoTimestampRate)
    : RecordReader(std::make_unique<std::ifstream>(recordPath, std::ios::in | std::ios::binary),
                   countToPerfettoTimestampRate) {}

std::optional<RawRecord> RecordReader::readRawRecord() {
  std::array<uint8_t, 16U> data{};
  recordStream_->read(reinterpret_cast<char *>(data.data()), static_cast<std::streamsize>(data.size()));
  if (recordStream_->gcount() < 16)
    return std::nullopt;

  uint64_t uuid;
  std::memcpy(&uuid, &data[0], sizeof(uuid));
  uint32_t rawCounter;
  std::memcpy(&rawCounter, &data[8], sizeof(rawCounter));
  int32_t fnId;
  std::memcpy(&fnId, &data[12], sizeof(fnId));
  return {{.uuid = uuid, .rawCounter = rawCounter, .fnId = fnId}};
}

std::optional<Record> RecordReader::nextRecord() {
  if (nextRecord_.has_value()) {
    Record const record = *nextRecord_;
    nextRecord_.reset();
    return record;
  }
  std::optional<RawRecord> const rawRecord = readRawRecord();
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
  // Workaround for macOS missing first record timestamp
  if (scaledTime == 0U) {
    nextRecord_ = nextRecord();
    if (nextRecord_.has_value())
      return {{.uuid = rawRecord->uuid, .time = nextRecord_->time, .deltaTime = deltaTime, .fnId = rawRecord->fnId}};
    return {{.uuid = rawRecord->uuid, .time = 0U, .deltaTime = deltaTime, .fnId = rawRecord->fnId}};
  }
  return {{.uuid = rawRecord->uuid, .time = scaledTime, .deltaTime = deltaTime, .fnId = rawRecord->fnId}};
}

std::unordered_map<int32_t, std::string> loadMappingStream(std::istream &stream) {
  std::unordered_map<int32_t, std::string> functionIndexes;
  std::string line;
  while (std::getline(stream, line)) {
    size_t const index = line.find(' ');
    if (index != std::string::npos) {
      int32_t fnId = 0;
      auto const [ptr, ec] = std::from_chars(line.data(), line.data() + index, fnId);
      if (ec == std::errc{} && ptr == line.data() + index) {
        functionIndexes[fnId] = line.substr(index + 1);
      }
    }
  }
  return functionIndexes;
}

std::unordered_map<int32_t, std::string> loadMappingFile(std::filesystem::path const &mappingPath) {
  std::ifstream mappingFile(mappingPath, std::ios::in);
  if (!mappingFile.is_open())
    throw std::runtime_error(fmt::format("Failed to open trace point mapping file: {}", mappingPath.string()));
  return loadMappingStream(mappingFile);
}

static uint64_t parseModuleId(std::string_view key) {
  if (key.empty())
    throw std::runtime_error("Invalid moduleId in trace point mapping JSON: empty key");
  int base = 10;
  if (key.starts_with("0x") || key.starts_with("0X")) {
    key.remove_prefix(2);
    base = 16;
  }
  if (key.empty())
    throw std::runtime_error("Invalid moduleId in trace point mapping JSON: 0x");
  uint64_t val = 0;
  auto const [ptr, ec] = std::from_chars(key.data(), key.data() + key.size(), val, base);
  if (ec != std::errc{} || ptr != key.data() + key.size())
    throw std::runtime_error(fmt::format("Invalid moduleId in trace point mapping JSON: {}", key));
  return val;
}

std::unordered_map<uint64_t, ModuleConfig> parseMappingJson(std::string const &jsonContent,
                                                            std::filesystem::path const &baseDir) {
  nlohmann::json jsonArray;
  try {
    jsonArray = nlohmann::json::parse(jsonContent);
  } catch (std::exception const &e) {
    throw std::runtime_error(fmt::format("Failed to parse trace point mapping JSON file: {}", e.what()));
  }

  if (!jsonArray.is_array())
    throw std::runtime_error("Trace point mapping JSON must be an array of module configurations.");

  std::unordered_map<uint64_t, ModuleConfig> modules;
  for (auto const &item : jsonArray) {
    if (!item.is_object())
      throw std::runtime_error("Each item in trace point mapping JSON array must be an object.");

    if (!item.contains("moduleId"))
      throw std::runtime_error("Missing 'moduleId' in trace point mapping configuration item.");

    uint64_t moduleId = 0ULL;
    auto const &modIdVal = item["moduleId"];
    if (modIdVal.is_number_unsigned()) {
      moduleId = modIdVal.get<uint64_t>();
    } else if (modIdVal.is_string()) {
      moduleId = parseModuleId(modIdVal.get<std::string>());
    } else {
      throw std::runtime_error(
          "Invalid 'moduleId' type in trace point mapping JSON: expected unsigned integer or string.");
    }

    if (!item.contains("mappingFile") || !item["mappingFile"].is_string())
      throw std::runtime_error(fmt::format(
          "Missing or invalid 'mappingFile' in trace point mapping configuration for moduleId {}", moduleId));

    std::filesystem::path mappingPath = item["mappingFile"].get<std::string>();
    std::string const moduleName = (item.contains("moduleName") && item["moduleName"].is_string())
                                       ? item["moduleName"].get<std::string>()
                                       : fmt::format("Module {}", moduleId);

    // Resolve relative path against base directory (JSON parent path)
    if (mappingPath.is_relative()) {
      std::filesystem::path const resolved = baseDir / mappingPath;
      if (std::filesystem::exists(resolved))
        mappingPath = resolved;
    }

    modules[moduleId] = ModuleConfig{
        .name = moduleName,
        .functionIndexes = loadMappingFile(mappingPath),
    };
  }
  return modules;
}

std::unordered_map<uint64_t, ModuleConfig> loadMappingJsonFile(std::filesystem::path const &jsonPath) {
  std::ifstream jsonFile(jsonPath, std::ios::in);
  if (!jsonFile.is_open())
    throw std::runtime_error(fmt::format("Failed to open trace point mapping JSON file: {}", jsonPath.string()));
  std::string const content((std::istreambuf_iterator<char>(jsonFile)), std::istreambuf_iterator<char>());
  return parseMappingJson(content, jsonPath.parent_path());
}

TraceBuilder::TraceBuilder(std::filesystem::path const &tracePointMappingFile,
                           std::filesystem::path const &traceRecordFile, double countToPerfettoTimestampRate,
                           uint32_t maxSliceCount)
    : recordReader_{std::make_unique<RecordReader>(traceRecordFile, countToPerfettoTimestampRate)},
      maxSliceCount_{maxSliceCount == 0U ? UINT32_MAX : maxSliceCount} {
  defaultFunctionIndexes_ = loadMappingFile(tracePointMappingFile);
}

TraceBuilder::TraceBuilder(MappingJsonTag /*unused*/, std::filesystem::path const &tracePointMappingJsonFile,
                           std::filesystem::path const &traceRecordFile, double countToPerfettoTimestampRate,
                           uint32_t maxSliceCount)
    : recordReader_{std::make_unique<RecordReader>(traceRecordFile, countToPerfettoTimestampRate)},
      maxSliceCount_{maxSliceCount == 0U ? UINT32_MAX : maxSliceCount} {
  std::unordered_map<uint64_t, ModuleConfig> const configs = loadMappingJsonFile(tracePointMappingJsonFile);
  for (auto const &[moduleId, config] : configs) {
    moduleNames_[moduleId] = config.name;
    moduleFunctionIndexes_[moduleId] = config.functionIndexes;
  }
}

TraceBuilder::TraceBuilder(std::unordered_map<uint64_t, ModuleConfig> modules, std::unique_ptr<RecordReader> reader,
                           uint32_t maxSliceCount)
    : recordReader_{std::move(reader)}, maxSliceCount_{maxSliceCount == 0U ? UINT32_MAX : maxSliceCount} {
  for (auto &[moduleId, config] : modules) {
    moduleNames_[moduleId] = std::move(config.name);
    moduleFunctionIndexes_[moduleId] = std::move(config.functionIndexes);
  }
}

TraceBuilder::TraceBuilder(std::unordered_map<int32_t, std::string> defaultFunctions,
                           std::unique_ptr<RecordReader> reader, uint32_t maxSliceCount)
    : defaultFunctionIndexes_{std::move(defaultFunctions)}, recordReader_{std::move(reader)},
      maxSliceCount_{maxSliceCount == 0U ? UINT32_MAX : maxSliceCount} {}

void TraceBuilder::process() {
  // Emit TrackDescriptors at the beginning to declare explicit tracks in Perfetto UI
  if (!moduleFunctionIndexes_.empty()) {
    std::vector<uint64_t> moduleIds;
    moduleIds.reserve(moduleFunctionIndexes_.size());
    for (auto const &[moduleId, _] : moduleFunctionIndexes_) {
      moduleIds.push_back(moduleId);
    }
    std::ranges::sort(moduleIds);
    for (uint64_t const moduleId : moduleIds) {
      std::string const trackName =
          moduleNames_.count(moduleId) != 0U ? moduleNames_.at(moduleId) : fmt::format("Module {}", moduleId);
      writer_.writeTracePacket([moduleId, &trackName](TracePacketWriter &tracePacketWriter) -> void {
        tracePacketWriter.writeTrustedPacketSequenceId(1U);
        tracePacketWriter.writeTrackDescriptor(
            [moduleId, &trackName](TrackDescriptorWriter &trackDescriptorWriter) -> void {
              trackDescriptorWriter.writeUuid(moduleId);
              trackDescriptorWriter.writeName(trackName);
            });
      });
    }
  } else {
    // Default single-module track descriptor
    writer_.writeTracePacket([](TracePacketWriter &tracePacketWriter) -> void {
      tracePacketWriter.writeTrustedPacketSequenceId(1U);
      tracePacketWriter.writeTrackDescriptor([](TrackDescriptorWriter &trackDescriptorWriter) -> void {
        trackDescriptorWriter.writeUuid(1ULL);
        trackDescriptorWriter.writeName("Wasm Module");
      });
    });
  }

  uint32_t sliceCount = 0;

  while (true) {
    bool allEmpty = true;
    for (auto const &[uuid, slice] : pendingSlices_) {
      if (!slice.empty()) {
        allEmpty = false;
        break;
      }
    }
    if (allEmpty) {
      sliceCount++;
      if (sliceCount > maxSliceCount_)
        break;
    }
    std::optional<Record> const record = recordReader_->nextRecord();
    if (!record.has_value())
      break;

    // In single-mapping mode, ensure all records belong to the same module
    if (moduleFunctionIndexes_.empty()) {
      if (!singleModuleUuid_.has_value()) {
        singleModuleUuid_ = record->uuid;
      } else if (*singleModuleUuid_ != record->uuid) {
        throw std::runtime_error(
            "Multiple modules detected in trace record, but only single mapping file was provided. "
            "Use --trace-point-mapping-json-file instead.");
      }
    }

    // Route event and slice stack by record.uuid (per-module isolation)
    auto &pendingSlice = pendingSlices_[record->uuid];
    if (record->fnId > 0) {
      pendingSlice.push_back(record->fnId);
      if (pendingSlice.size() == 1U)
        fmt::println("start slice '{}' in {}ms", getFunctionName(record->uuid, record->fnId), record->time / 1000'000U);
      addBeginEvent(record->uuid, record->time, record->fnId);
    } else {
      PopCount const popCount = getPopCount(*record);
      if (!popCount.found) {
        fmt::println(stderr, "warning: No matching begin for end event {} in {}", record->fnId, record->time);
        if (!recoverFromMissingBegin(*record))
          return;
        continue;
      }
      if (popCount.additionalPopCount > 0U) {
        fmt::println(stderr, "warning: No matching end for begin event {} in {}",
                     pendingSlice[pendingSlice.size() - popCount.additionalPopCount], record->time);
        if (!recoverFromMissingEnd(*record, popCount.additionalPopCount,
                                   record->time - static_cast<uint64_t>(record->deltaTime)))
          return;
        continue;
      }
      if (pendingSlice.size() == 1U)
        fmt::println("end slice {} in {}ms", getFunctionName(record->uuid, pendingSlice.back()),
                     record->time / 1000'000U);
      pendingSlice.pop_back();
      addEndEvent(record->uuid, record->time);
    }
  }
}

std::string TraceBuilder::getFunctionName(uint64_t uuid, int32_t fnId) const {
  // Query module-specific symbol table first
  auto const modIt = moduleFunctionIndexes_.find(uuid);
  if (modIt != moduleFunctionIndexes_.end()) {
    auto const fnIt = modIt->second.find(fnId);
    if (fnIt != modIt->second.end())
      return fnIt->second;
  }
  // Fall back to default single-module symbol table
  auto const fnIt = defaultFunctionIndexes_.find(fnId);
  if (fnIt != defaultFunctionIndexes_.end())
    return fnIt->second;
  return fmt::format("unknown function {}", fnId);
}

TraceBuilder::PopCount TraceBuilder::getPopCount(Record const &record) {
  auto const it = pendingSlices_.find(record.uuid);
  if (it == pendingSlices_.end())
    return {.found = false, .additionalPopCount = 0U};

  auto const &pendingSlice = it->second;
  size_t popCount = 0;
  for (int32_t const itFnId : std::ranges::reverse_view(pendingSlice)) {
    if (itFnId == -record.fnId)
      return {.found = true, .additionalPopCount = popCount};
    popCount++;
  }
  return {.found = false, .additionalPopCount = 0U};
}

bool TraceBuilder::recoverFromMissingBegin(Record const &missingBeginRecord) {
  while (true) {
    std::optional<Record> const record = recordReader_->nextRecord();
    if (!record.has_value())
      return false;
    if (record->uuid != missingBeginRecord.uuid)
      continue;
    if (record->fnId > 0)
      continue;
    PopCount const popCount = getPopCount(*record);
    if (!popCount.found)
      continue;
    auto &pendingSlice = pendingSlices_[record->uuid];
    for (size_t i = 0; i < popCount.additionalPopCount; ++i) {
      pendingSlice.pop_back();
      addEndEvent(missingBeginRecord.uuid, missingBeginRecord.time);
    }
    addFailedBeginEndEvent(missingBeginRecord.uuid, missingBeginRecord.time, record->time);
    pendingSlice.pop_back();
    addEndEvent(record->uuid, record->time);
    return true;
  }
}

bool TraceBuilder::recoverFromMissingEnd(Record const &record, size_t additionalPopCount, uint64_t lastTime) {
  auto &pendingSlice = pendingSlices_[record.uuid];
  for (size_t i = 0; i < additionalPopCount; ++i) {
    pendingSlice.pop_back();
    addEndEvent(record.uuid, lastTime);
  }
  addFailedBeginEndEvent(record.uuid, lastTime, record.time);
  pendingSlice.pop_back();
  addEndEvent(record.uuid, record.time);
  return true;
}

void TraceBuilder::addBeginEvent(uint64_t uuid, uint64_t time, int32_t fnId) {
  std::string const functionName = getFunctionName(uuid, fnId);
  addBeginEvent(uuid, time, functionName);
}

void TraceBuilder::addBeginEvent(uint64_t uuid, uint64_t time, std::string const &name) {
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

void TraceBuilder::addEndEvent(uint64_t uuid, uint64_t time) {
  writer_.writeTracePacket([&](TracePacketWriter &tracePacketWriter) -> void {
    tracePacketWriter.writeTimestamp(time);
    tracePacketWriter.writeTrustedPacketSequenceId(1U);
    tracePacketWriter.writeTrackEvent([&](TraceEventWriter &traceEventWriter) -> void {
      traceEventWriter.writeTrackUuid(uuid);
      traceEventWriter.writeType(TraceEventWriter::Type::TYPE_SLICE_END);
    });
  });
}

void TraceBuilder::addFailedBeginEndEvent(uint64_t uuid, uint64_t startTime, uint64_t endTime) {
  addBeginEvent(uuid, startTime, "UNKNOWN [lose data]");
  addEndEvent(uuid, endTime);
}

} // namespace warpo

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <protozero/pbf_reader.hpp>

namespace warpo::ut {

namespace {

std::string makeTraceRecordBinary(std::vector<std::tuple<uint64_t, uint32_t, int32_t>> const &records) {
  constexpr size_t headerSize = 16U;
  constexpr size_t recordSize = 16U;
  std::vector<char> buffer(headerSize + records.size() * recordSize);
  std::memcpy(buffer.data(), "___WARP_TRACE___", headerSize);
  for (size_t i = 0; i < records.size(); ++i) {
    auto const &[uuid, counter, fnId] = records[i];
    char *const dest = buffer.data() + headerSize + i * recordSize;
    std::memcpy(dest, &uuid, sizeof(uuid));
    std::memcpy(dest + 8U, &counter, sizeof(counter));
    std::memcpy(dest + 12U, &fnId, sizeof(fnId));
  }
  return {buffer.data(), buffer.size()};
}

struct ParsedPacket {
  uint64_t timestamp = 0U;
  uint32_t trustedSeqId = 0U;
  std::optional<uint64_t> trackDescUuid;
  std::optional<std::string> trackDescName;
  std::optional<int32_t> trackEventType;
  std::optional<uint64_t> trackEventUuid;
  std::optional<std::string> trackEventName;
};

std::vector<ParsedPacket> parseProtobufPackets(std::string const &data) {
  std::vector<ParsedPacket> packets;
  protozero::pbf_reader reader{data};
  while (reader.next(TraceWriter::packet_tag)) {
    protozero::pbf_reader packetReader = reader.get_message();
    ParsedPacket packet;
    while (packetReader.next()) {
      switch (packetReader.tag()) {
      case TracePacketWriter::timestamp_tag:
        packet.timestamp = packetReader.get_uint64();
        break;
      case TracePacketWriter::trusted_packet_sequence_id_tag:
        packet.trustedSeqId = packetReader.get_uint32();
        break;
      case TracePacketWriter::track_descriptor_tag: {
        protozero::pbf_reader descReader = packetReader.get_message();
        while (descReader.next()) {
          if (descReader.tag() == TrackDescriptorWriter::uuid_tag) {
            packet.trackDescUuid = descReader.get_uint64();
          } else if (descReader.tag() == TrackDescriptorWriter::name_tag) {
            packet.trackDescName = descReader.get_string();
          } else {
            descReader.skip();
          }
        }
        break;
      }
      case TracePacketWriter::track_event_tag: {
        protozero::pbf_reader eventReader = packetReader.get_message();
        while (eventReader.next()) {
          if (eventReader.tag() == TraceEventWriter::type_tag) {
            packet.trackEventType = eventReader.get_int32();
          } else if (eventReader.tag() == TraceEventWriter::track_uuid_tag) {
            packet.trackEventUuid = eventReader.get_uint64();
          } else if (eventReader.tag() == TraceEventWriter::name_tag) {
            packet.trackEventName = eventReader.get_string();
          } else {
            eventReader.skip();
          }
        }
        break;
      }
      default:
        packetReader.skip();
        break;
      }
    }
    packets.push_back(packet);
  }
  return packets;
}

} // namespace

TEST(TraceVisualizerTest, LoadMappingStream) {
  std::istringstream stream("0 main\n1 foo_bar\n2 baz\n");
  std::unordered_map<int32_t, std::string> const result = loadMappingStream(stream);

  EXPECT_EQ(result.size(), 3U);
  EXPECT_EQ(result.at(0), "main");
  EXPECT_EQ(result.at(1), "foo_bar");
  EXPECT_EQ(result.at(2), "baz");
}

TEST(TraceVisualizerTest, RecordReaderValidation) {
  // Invalid header
  {
    std::string const invalidData = "INVALID_HEADER__";
    EXPECT_THROW((void)RecordReader(std::make_unique<std::istringstream>(invalidData), 1.0), std::runtime_error);
  }

  // Valid records reading & counter overflow
  {
    std::string const binData = makeTraceRecordBinary({
        {1ULL, 100U, 1},
        {1ULL, 200U, -1},
        {1ULL, 50U, 2}, // wraps around
    });
    RecordReader reader(std::make_unique<std::istringstream>(binData), 1.0);

    auto const rec1 = reader.nextRecord();
    ASSERT_TRUE(rec1.has_value());
    EXPECT_EQ(rec1->uuid, 1ULL);
    EXPECT_EQ(rec1->time, 100U);
    EXPECT_EQ(rec1->fnId, 1);

    auto const rec2 = reader.nextRecord();
    ASSERT_TRUE(rec2.has_value());
    EXPECT_EQ(rec2->uuid, 1ULL);
    EXPECT_EQ(rec2->time, 200U);
    EXPECT_EQ(rec2->fnId, -1);

    auto const rec3 = reader.nextRecord();
    ASSERT_TRUE(rec3.has_value());
    EXPECT_EQ(rec3->uuid, 1ULL);
    EXPECT_EQ(rec3->time, (1ULL << 32ULL) + 50U);
    EXPECT_EQ(rec3->fnId, 2);

    auto const rec4 = reader.nextRecord();
    EXPECT_FALSE(rec4.has_value());
  }
}

TEST(TraceVisualizerTest, ParseMappingJsonFormats) {
  // Create temp mapping files
  std::filesystem::path const tempDir = std::filesystem::temp_directory_path() / "warpo_ut_trace_mapping";
  std::filesystem::create_directories(tempDir);

  std::filesystem::path const map1 = tempDir / "map1.txt";
  std::filesystem::path const map2 = tempDir / "map2.txt";
  std::ofstream(map1) << "1 module1_func\n";
  std::ofstream(map2) << "1 module2_func\n";

  // Test standard array of objects format (use generic_string() for cross-platform JSON path escaping)
  {
    std::string const jsonStr = fmt::format(
        R"([
          {{
            "moduleId": 1,
            "moduleName": "MyModule1",
            "mappingFile": "{}"
          }},
          {{
            "moduleId": "0x10",
            "moduleName": "MyModule16",
            "mappingFile": "{}"
          }}
        ])",
        map1.generic_string(), map2.generic_string());

    auto const modules = parseMappingJson(jsonStr, tempDir);
    EXPECT_EQ(modules.size(), 2U);
    ASSERT_TRUE(modules.count(1ULL) != 0U);
    EXPECT_EQ(modules.at(1ULL).name, "MyModule1");
    EXPECT_EQ(modules.at(1ULL).functionIndexes.at(1), "module1_func");

    ASSERT_TRUE(modules.count(16ULL) != 0U);
    EXPECT_EQ(modules.at(16ULL).name, "MyModule16");
    EXPECT_EQ(modules.at(16ULL).functionIndexes.at(1), "module2_func");
  }

  // Test optional moduleName
  {
    std::string const jsonStr = fmt::format(
        R"([
          {{
            "moduleId": 1,
            "mappingFile": "{}"
          }}
        ])",
        map1.generic_string());

    auto const modules = parseMappingJson(jsonStr, tempDir);
    EXPECT_EQ(modules.size(), 1U);
    EXPECT_EQ(modules.at(1ULL).name, "Module 1");
  }

  // Test invalid json error handling
  EXPECT_THROW((void)parseMappingJson("INVALID_JSON", tempDir), std::runtime_error);
  EXPECT_THROW((void)parseMappingJson(R"({"1": "map.txt"})", tempDir), std::runtime_error);
  EXPECT_THROW((void)parseMappingJson(R"([{"mappingFile": "map.txt"}])", tempDir), std::runtime_error);
  EXPECT_THROW((void)parseMappingJson(R"([{"moduleId": "not_a_num", "mappingFile": "map.txt"}])", tempDir),
               std::runtime_error);
  EXPECT_THROW((void)parseMappingJson(R"([{"moduleId": 1}])", tempDir), std::runtime_error);
  EXPECT_THROW((void)parseMappingJson(R"(["just_a_string"])", tempDir), std::runtime_error);

  std::filesystem::remove_all(tempDir);
}

TEST(TraceVisualizerTest, SingleModuleTraceProcessing) {
  std::unordered_map<int32_t, std::string> const defaultFunctions = {
      {1, "main"},
      {2, "compute"},
  };

  std::string const binData = makeTraceRecordBinary({
      {1ULL, 100U, 1},  // begin main
      {1ULL, 200U, 2},  // begin compute
      {1ULL, 300U, -2}, // end compute
      {1ULL, 400U, -1}, // end main
  });

  auto reader = std::make_unique<RecordReader>(std::make_unique<std::istringstream>(binData), 1.0);
  TraceBuilder builder(defaultFunctions, std::move(reader));
  builder.process();

  auto const packets = parseProtobufPackets(builder.writer_.data_);
  ASSERT_GE(packets.size(), 5U);

  // Packet 0: TrackDescriptor for single module
  EXPECT_EQ(packets[0].trackDescUuid.value_or(0ULL), 1ULL);
  EXPECT_EQ(packets[0].trackDescName.value_or(""), "Wasm Module");

  // Packet 1: begin main
  EXPECT_EQ(packets[1].timestamp, 100U);
  EXPECT_EQ(packets[1].trackEventType.value_or(0), static_cast<int32_t>(TraceEventWriter::Type::TYPE_SLICE_BEGIN));
  EXPECT_EQ(packets[1].trackEventName.value_or(""), "main");

  // Packet 2: begin compute
  EXPECT_EQ(packets[2].timestamp, 200U);
  EXPECT_EQ(packets[2].trackEventType.value_or(0), static_cast<int32_t>(TraceEventWriter::Type::TYPE_SLICE_BEGIN));
  EXPECT_EQ(packets[2].trackEventName.value_or(""), "compute");

  // Packet 3: end compute
  EXPECT_EQ(packets[3].timestamp, 300U);
  EXPECT_EQ(packets[3].trackEventType.value_or(0), static_cast<int32_t>(TraceEventWriter::Type::TYPE_SLICE_END));

  // Packet 4: end main
  EXPECT_EQ(packets[4].timestamp, 400U);
  EXPECT_EQ(packets[4].trackEventType.value_or(0), static_cast<int32_t>(TraceEventWriter::Type::TYPE_SLICE_END));
}

TEST(TraceVisualizerTest, SingleModuleMultipleModulesInTraceFails) {
  std::unordered_map<int32_t, std::string> const defaultFunctions = {
      {1, "main"},
  };

  // Trace file contains records from two different modules (uuid 1 and uuid 2)
  std::string const binData = makeTraceRecordBinary({
      {1ULL, 100U, 1},
      {2ULL, 200U, 1},
  });

  auto reader = std::make_unique<RecordReader>(std::make_unique<std::istringstream>(binData), 1.0);
  TraceBuilder builder(defaultFunctions, std::move(reader));
  EXPECT_THROW((void)builder.process(), std::runtime_error);
}

TEST(TraceVisualizerTest, MultiModuleInterleavedTraceProcessing) {
  std::unordered_map<uint64_t, ModuleConfig> modules;
  modules[10ULL] = ModuleConfig{
      .name = "ModuleA",
      .functionIndexes = {{1, "moduleA_task"}},
  };
  modules[20ULL] = ModuleConfig{
      .name = "ModuleB",
      .functionIndexes = {{1, "moduleB_worker"}},
  };

  // Interleaved trace records from two modules
  std::string const binData = makeTraceRecordBinary({
      {10ULL, 100U, 1},  // Mod A: begin task
      {20ULL, 150U, 1},  // Mod B: begin worker
      {10ULL, 250U, -1}, // Mod A: end task
      {20ULL, 300U, -1}, // Mod B: end worker
  });

  auto reader = std::make_unique<RecordReader>(std::make_unique<std::istringstream>(binData), 1.0);
  TraceBuilder builder(modules, std::move(reader));
  builder.process();

  auto const packets = parseProtobufPackets(builder.writer_.data_);
  ASSERT_GE(packets.size(), 6U);

  // First 2 packets: TrackDescriptors for ModuleA and ModuleB
  EXPECT_EQ(packets[0].trackDescUuid.value_or(0ULL), 10ULL);
  EXPECT_EQ(packets[0].trackDescName.value_or(""), "ModuleA");
  EXPECT_EQ(packets[1].trackDescUuid.value_or(0ULL), 20ULL);
  EXPECT_EQ(packets[1].trackDescName.value_or(""), "ModuleB");

  // Event 1: Mod A begin
  EXPECT_EQ(packets[2].timestamp, 100U);
  EXPECT_EQ(packets[2].trackEventUuid.value_or(0ULL), 10ULL);
  EXPECT_EQ(packets[2].trackEventName.value_or(""), "moduleA_task");
  EXPECT_EQ(packets[2].trackEventType.value_or(0), static_cast<int32_t>(TraceEventWriter::Type::TYPE_SLICE_BEGIN));

  // Event 2: Mod B begin
  EXPECT_EQ(packets[3].timestamp, 150U);
  EXPECT_EQ(packets[3].trackEventUuid.value_or(0ULL), 20ULL);
  EXPECT_EQ(packets[3].trackEventName.value_or(""), "moduleB_worker");
  EXPECT_EQ(packets[3].trackEventType.value_or(0), static_cast<int32_t>(TraceEventWriter::Type::TYPE_SLICE_BEGIN));

  // Event 3: Mod A end
  EXPECT_EQ(packets[4].timestamp, 250U);
  EXPECT_EQ(packets[4].trackEventUuid.value_or(0ULL), 10ULL);
  EXPECT_EQ(packets[4].trackEventType.value_or(0), static_cast<int32_t>(TraceEventWriter::Type::TYPE_SLICE_END));

  // Event 4: Mod B end
  EXPECT_EQ(packets[5].timestamp, 300U);
  EXPECT_EQ(packets[5].trackEventUuid.value_or(0ULL), 20ULL);
  EXPECT_EQ(packets[5].trackEventType.value_or(0), static_cast<int32_t>(TraceEventWriter::Type::TYPE_SLICE_END));
}

TEST(TraceVisualizerTest, MissingEndRecovery) {
  std::unordered_map<int32_t, std::string> const defaultFunctions = {
      {1, "func1"},
      {2, "func2"},
  };

  // func1 begins, then func2 begins, but end arrives for func1 (missing end for func2)
  std::string const binData = makeTraceRecordBinary({
      {1ULL, 100U, 1},  // begin func1
      {1ULL, 200U, 2},  // begin func2
      {1ULL, 300U, -1}, // end func1 (func2 end was missed)
  });

  auto reader = std::make_unique<RecordReader>(std::make_unique<std::istringstream>(binData), 1.0);
  TraceBuilder builder(defaultFunctions, std::move(reader));
  builder.process();

  auto const packets = parseProtobufPackets(builder.writer_.data_);
  // Should produce events including recovery
  bool hasLostDataEvent = false;
  for (auto const &pkt : packets) {
    if (pkt.trackEventName.has_value() && pkt.trackEventName.value().find("lose data") != std::string::npos) {
      hasLostDataEvent = true;
      break;
    }
  }
  EXPECT_TRUE(hasLostDataEvent);
}

TEST(TraceVisualizerTest, MaxSliceCountLimit) {
  std::unordered_map<int32_t, std::string> const defaultFunctions = {
      {1, "task"},
  };

  std::string const binData = makeTraceRecordBinary({
      {1ULL, 100U, 1},  // slice 1 begin
      {1ULL, 200U, -1}, // slice 1 end
      {1ULL, 300U, 1},  // slice 2 begin
      {1ULL, 400U, -1}, // slice 2 end
  });

  auto reader = std::make_unique<RecordReader>(std::make_unique<std::istringstream>(binData), 1.0);
  TraceBuilder builder(defaultFunctions, std::move(reader), 1U); // maxSliceCount = 1
  builder.process();

  auto const packets = parseProtobufPackets(builder.writer_.data_);
  // 1 TrackDesc + 1 slice begin + 1 slice end = 3 packets
  EXPECT_EQ(packets.size(), 3U);
  EXPECT_EQ(packets[1].timestamp, 100U);
  EXPECT_EQ(packets[2].timestamp, 200U);
}

} // namespace warpo::ut

#endif // WARPO_ENABLE_UNIT_TESTS
