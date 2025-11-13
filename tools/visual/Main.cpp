#include <array>
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <iostream>
#include <map>
#include <protozero/pbf_writer.hpp>
#include <ranges>
#include <string>
#include <utility>
#include <vector>

#include "warpo/support/FileSystem.hpp"

const std::string TRACE_POINT_MAPPING_FILE = "tmp/perf/trace_points.txt";
const std::string TRACE_RECORD_FILE = "tmp/perf/trace_record.bin";
const std::string OUTPUT_PF_TRACE_FILE = "tmp/perf/output.pftrace";

const double RATE = 1.0 / (200 * 1000000);
const int TOTAL_SLICE_COUNT = 1000;

struct TraceEventWriter {
  protozero::pbf_writer pbf_;
  enum class Type : int32_t {
    TYPE_SLICE_BEGIN = 1,
    TYPE_SLICE_END = 2,
  };
  inline static constexpr protozero::pbf_tag_type type_tag = 9U;        // optional Type type
  inline static constexpr protozero::pbf_tag_type track_uuid_tag = 11U; // optional uint64 track_uuid
  // oneof name_field {
  //   string name
  // }
  inline static constexpr protozero::pbf_tag_type name_tag = 23U;

  void writeType(Type type) { pbf_.add_int32(type_tag, static_cast<int32_t>(type)); }
  void writeTrackUuid(uint64_t uuid) { pbf_.add_uint64(track_uuid_tag, uuid); }
  void writeName(std::string const &name) { pbf_.add_string(name_tag, name); }
};

struct TracePacketWriter {
  protozero::pbf_writer pbf_;
  inline static constexpr protozero::pbf_tag_type timestamp_tag = 8; // optional uint64 timestamp
  // oneof optional_trusted_packet_sequence_id {
  //   uint32 trusted_packet_sequence_id
  // }
  inline static constexpr protozero::pbf_tag_type trusted_packet_sequence_id_tag = 10;
  // oneof data {
  //   TrackEvent track_event
  // }
  inline static constexpr protozero::pbf_tag_type track_event_tag = 11;

  void writeTimestamp(uint64_t timestamp) { pbf_.add_uint64(timestamp_tag, timestamp); }
  void writeTrustedPacketSequenceId(uint32_t id) { pbf_.add_uint32(trusted_packet_sequence_id_tag, id); }
  void writeTrackEvent(std::function<void(TraceEventWriter &)> const &writeTraceEvent) {
    TraceEventWriter trackEventWriter{.pbf_ = protozero::pbf_writer{pbf_, track_event_tag}};
    writeTraceEvent(trackEventWriter);
  }
};

struct TraceWriter {
  inline static constexpr protozero::pbf_tag_type packet_tag = 1; // repeated TracePacket packet
  std::string data_;
  protozero::pbf_writer pbf_{data_};

  void writeTracePacket(std::function<void(TracePacketWriter &)> const &writePacket) {
    TracePacketWriter tracePacketWriter{.pbf_ = protozero::pbf_writer{pbf_, packet_tag}};
    writePacket(tracePacketWriter);
  }
};

class TraceBuilder {
public:
  TraceWriter writer_;

  void createTraceData();

private:
  void addBeginEvent(uint64_t uuid, uint64_t timestamp, std::string const &functionName) {
    writer_.writeTracePacket([&](TracePacketWriter &tracePacketWriter) -> void {
      tracePacketWriter.writeTimestamp(timestamp);
      tracePacketWriter.writeTrustedPacketSequenceId(1U);
      tracePacketWriter.writeTrackEvent([&](TraceEventWriter &traceEventWriter) -> void {
        traceEventWriter.writeTrackUuid(uuid);
        traceEventWriter.writeName(functionName);
        traceEventWriter.writeType(TraceEventWriter::Type::TYPE_SLICE_BEGIN);
      });
    });
  }
  void addEndEvent(uint64_t uuid, uint64_t timestamp) {
    writer_.writeTracePacket([&](TracePacketWriter &tracePacketWriter) -> void {
      tracePacketWriter.writeTimestamp(timestamp);
      tracePacketWriter.writeTrustedPacketSequenceId(1U);
      tracePacketWriter.writeTrackEvent([&](TraceEventWriter &traceEventWriter) -> void {
        traceEventWriter.writeTrackUuid(uuid);
        traceEventWriter.writeType(TraceEventWriter::Type::TYPE_SLICE_END);
      });
    });
  }
};

void TraceBuilder::createTraceData() {
  std::map<int, std::string> functionIndexes;
  std::ifstream mappingFile(TRACE_POINT_MAPPING_FILE);
  std::string line;
  while (std::getline(mappingFile, line)) {
    size_t index = line.find(' ');
    if (index != std::string::npos) {
      int fnId = std::stoi(line.substr(0, index));
      functionIndexes[fnId] = line.substr(index + 1);
    }
  }

  std::ifstream recordFile(TRACE_RECORD_FILE, std::ios::binary);
  std::string magic(16, '\0');
  recordFile.read(magic.data(), 16);
  if (magic != "___WARP_TRACE___")
    throw std::runtime_error("Invalid trace record file");

  std::vector<int32_t> pendingSlice;
  uint64_t slice_count = UINT64_MAX;
  uint64_t lastTs = 0U;
  uint64_t overflowCount = 0U;

  while (true) {
    if (pendingSlice.empty()) {
      slice_count++;
      if (slice_count >= TOTAL_SLICE_COUNT)
        break;
    }
    std::array<uint8_t, 16U> data{};
    recordFile.read(reinterpret_cast<char *>(data.data()), data.size());
    if (recordFile.gcount() < 16)
      break;

    uint64_t uuid;
    std::memcpy(&uuid, &data[0], sizeof(uuid));
    uint32_t time;
    std::memcpy(&time, &data[8], sizeof(time));
    int32_t fnId;
    std::memcpy(&fnId, &data[12], sizeof(fnId));

    uint64_t refinedTime = time;
    refinedTime += (1ULL << 32ULL) * overflowCount;
    if (lastTs > refinedTime)
      overflowCount++;
    refinedTime += 1ULL << 32ULL;
    lastTs = refinedTime;

    uint32_t scaledTime = static_cast<uint32_t>(static_cast<double>(refinedTime) * RATE);

    assert(fnId != 0);
    if (fnId > 0) {
      auto it = functionIndexes.find(fnId);
      std::string const functionName =
          (it != functionIndexes.end()) ? it->second : "unknown function " + std::to_string(fnId);
      addBeginEvent(uuid, scaledTime, functionName);
      pendingSlice.push_back(fnId);
    } else {
      size_t popCount = 0;
      for (int32_t it : std::ranges::reverse_view(pendingSlice)) {
        popCount++;
        if (it == -fnId)
          break;
      }
      if (popCount == pendingSlice.size()) {
        std::cerr << "warning: No matching begin for end event " << fnId << std::endl;
        continue;
      }
      for (size_t i = 0; i < popCount; ++i) {
        if (popCount != i + 1)
          std::cerr << "warning: No matching end for begin event " << pendingSlice.back() << std::endl;
        pendingSlice.pop_back();
        addEndEvent(uuid, scaledTime);
      }
    }
  }
}

int main() {
  TraceBuilder builder;
  builder.createTraceData();
  warpo::writeBinaryFile(OUTPUT_PF_TRACE_FILE, builder.writer_.data_);
  std::cout << "Trace written to " << OUTPUT_PF_TRACE_FILE << std::endl;
  std::cout << "Open with https://ui.perfetto.dev." << std::endl;
  return 0;
}
