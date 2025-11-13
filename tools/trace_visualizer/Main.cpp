#include <array>
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <optional>
#include <protozero/pbf_writer.hpp>
#include <ranges>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo {

static cli::Opt<std::filesystem::path> tracePointMappingFileOption{
    cli::Category::All,
    "--trace-point-mapping-file",
    [](argparse::Argument &arg) -> void { arg.help("File to read the trace point mapping."); },
};

static cli::Opt<std::filesystem::path> traceRecordFileOption{
    cli::Category::All,
    "--trace-point-record-file",
    [](argparse::Argument &arg) -> void { arg.help("File to read the trace point record."); },
};

static cli::Opt<std::filesystem::path> outputFileOption{
    cli::Category::All,
    "--output-pftrace-file",
    [](argparse::Argument &arg) -> void { arg.help("File to write the Perfetto trace data."); },
};

const double RATE = 1.0 / (200 * 1000000);
const uint64_t TOTAL_SLICE_COUNT = UINT64_MAX;

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

  TraceBuilder() {
    std::ifstream mappingFile(tracePointMappingFileOption.get(), std::ios::in);
    std::string line;
    while (std::getline(mappingFile, line)) {
      size_t index = line.find(' ');
      if (index != std::string::npos) {
        int fnId = std::stoi(line.substr(0, index));
        functionIndexes_[fnId] = line.substr(index + 1);
      }
    }

    recordFile_ = std::ifstream{traceRecordFileOption.get(), std::ios::binary};
    std::string magic(16, '\0');
    recordFile_.read(magic.data(), 16);
    if (magic != "___WARP_TRACE___")
      throw std::runtime_error("Invalid trace record file");
  }

  void process() {
    uint64_t sliceCount = 0;
    uint32_t lastTime = 0U;

    while (true) {
      if (pendingSlice_.empty()) {
        if (sliceCount >= TOTAL_SLICE_COUNT)
          break;
        sliceCount++;
      }
      std::optional<Record> record = nextRecord();
      lastTime = record->time;
      // finish
      if (!record.has_value())
        break;

      if (record->fnId > 0) {
        pendingSlice_.push_back(record->fnId);
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
          if (!recoverFromMissingEnd(*record, popCount.additionalPopCount, lastTime))
            return;
          continue;
        }
        pendingSlice_.pop_back();
        addEndEvent(record->uuid, record->time);
      }
    }
  }

private:
  uint64_t lastTs_ = 0U;
  uint64_t overflowCount_ = 0U;
  std::vector<int32_t> pendingSlice_;
  std::map<int, std::string> functionIndexes_;
  std::ifstream recordFile_;

  struct Record {
    uint64_t uuid;
    uint32_t time;
    int32_t fnId;
  };
  std::optional<Record> nextRecord() {
    std::array<uint8_t, 16U> data{};
    recordFile_.read(reinterpret_cast<char *>(data.data()), data.size());
    if (recordFile_.gcount() < 16)
      return std::nullopt;

    uint64_t uuid;
    std::memcpy(&uuid, &data[0], sizeof(uuid));
    uint32_t time;
    std::memcpy(&time, &data[8], sizeof(time));
    int32_t fnId;
    std::memcpy(&fnId, &data[12], sizeof(fnId));

    uint64_t refinedTime = static_cast<uint64_t>(time) + (overflowCount_ << 32ULL);
    if (lastTs_ > refinedTime) {
      overflowCount_++;
      refinedTime += 1ULL << 32ULL;
    }
    assert(lastTs_ <= refinedTime);
    lastTs_ = refinedTime;

    uint32_t scaledTime = static_cast<uint32_t>(static_cast<double>(refinedTime) * RATE);

    assert(fnId != 0);
    return {{.uuid = uuid, .time = scaledTime, .fnId = fnId}};
  }

  struct PopCount {
    bool found = false;
    size_t additionalPopCount = 0;
  };
  PopCount getPopCount(Record const &record) {
    size_t popCount = 0;
    for (int32_t it : std::ranges::reverse_view(pendingSlice_)) {
      if (it == -record.fnId)
        return {.found = true, .additionalPopCount = popCount};
      popCount++;
    }
    return {.found = false, .additionalPopCount = 0U};
  }

  // true for recover successfully
  [[nodiscard]] bool recoverFromMissingBegin(Record const &missingBeginRecord) {
    while (true) {
      std::optional<Record> record = nextRecord();
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

  [[nodiscard]] bool recoverFromMissingEnd(Record const &record, size_t additionalPopCount, uint32_t lastTime) {
    for (size_t i = 0; i < additionalPopCount; ++i) {
      pendingSlice_.pop_back();
      addEndEvent(record.uuid, lastTime);
    }
    addFailedBeginEndEvent(record.uuid, lastTime, record.time);
    pendingSlice_.pop_back();
    addEndEvent(record.uuid, record.time);
    return true;
  }

  void addBeginEvent(uint64_t uuid, uint32_t time, int32_t fnId) {
    auto it = functionIndexes_.find(fnId);
    std::string const functionName =
        (it != functionIndexes_.end()) ? it->second : "unknown function " + std::to_string(fnId);
    addBeginEvent(uuid, time, functionName);
  }
  void addBeginEvent(uint64_t uuid, uint32_t time, std::string const &name) {
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
  void addEndEvent(uint64_t uuid, uint32_t time) {
    writer_.writeTracePacket([&](TracePacketWriter &tracePacketWriter) -> void {
      tracePacketWriter.writeTimestamp(time);
      tracePacketWriter.writeTrustedPacketSequenceId(1U);
      tracePacketWriter.writeTrackEvent([&](TraceEventWriter &traceEventWriter) -> void {
        traceEventWriter.writeTrackUuid(uuid);
        traceEventWriter.writeType(TraceEventWriter::Type::TYPE_SLICE_END);
      });
    });
  }
  void addFailedBeginEndEvent(uint64_t uuid, uint32_t startTime, uint32_t endTime) {
    addBeginEvent(uuid, startTime, "UNKNOWN [lose data]");
    addEndEvent(uuid, endTime);
  }
};

} // namespace warpo

int main(int argc, const char **argv) {
  using namespace warpo;
  argparse::ArgumentParser program("warpo_trace_visualizer", "git@" GIT_COMMIT);
  cli::init(cli::Category::All, program, argc, argv);
  TraceBuilder builder;
  builder.process();
  warpo::writeBinaryFile(outputFileOption.get(), builder.writer_.data_);
  std::cout << "Trace written to " << outputFileOption.get() << std::endl;
  std::cout << "Open with https://ui.perfetto.dev." << std::endl;
  return 0;
}
