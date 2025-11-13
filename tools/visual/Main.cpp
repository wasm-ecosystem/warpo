#include <array>
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <functional>
#include <iostream>
#include <map>
#include <ranges>
#include <string>
#include <utility>
#include <vector>

#include "pb_encode.h"
#include "protos/perfetto/trace/perfetto_trace.pb.h"
#include "warpo/support/FileSystem.hpp"

const std::string TRACE_POINT_MAPPING_FILE = "tmp/perf/trace_points.txt";
const std::string TRACE_RECORD_FILE = "tmp/perf/trace_record.bin";
const std::string OUTPUT_PF_TRACE_FILE = "tmp/perf/output.pftrace";

const double RATE = 1.0 / (200 * 1000000);
const int TOTAL_SLICE_COUNT = 1000;

perfetto_protos_Trace trace;

class TraceBuilder {
public:
  explicit TraceBuilder() {}

  std::vector<uint8_t> createTraceData();

private:
  template <class Fn> static pb_callback_t createCallOnce(Fn &&fn) {
    pb_callback_t callback = {.funcs = {.encode = nullptr}, .arg = nullptr};
    using FnWrapper = std::function<bool(pb_ostream_t * stream, const pb_field_t *field)>;
    FnWrapper *const ptr = new FnWrapper(std::forward<Fn>(fn));
    callback.arg = reinterpret_cast<void *>(ptr);
    callback.funcs.encode = [](pb_ostream_t *stream, const pb_field_t *field, void *const *arg) -> bool {
      FnWrapper *const func = static_cast<FnWrapper *>(*arg);
      bool const ret = (*func)(stream, field);
      // delete func;
      return ret;
    };
    return callback;
  }

  static pb_callback_t createString(std::string str) {
    return createCallOnce([str = std::move(str)](pb_ostream_t *stream, const pb_field_t *field) -> bool {
      assert(pb_encode_tag_for_field(stream, field));
      return pb_encode_string(stream, reinterpret_cast<pb_byte_t const *>(str.c_str()), str.size());
    });
  }

  static perfetto_protos_TracePacket addBeginEvent(uint64_t uuid, uint64_t timestamp, std::string const &functionName) {
    perfetto_protos_TracePacket packet = perfetto_protos_TracePacket_init_default;
    packet.has_timestamp = true;
    packet.timestamp = timestamp;

    packet.which_optional_trusted_packet_sequence_id = perfetto_protos_TracePacket_trusted_packet_sequence_id_tag;
    packet.optional_trusted_packet_sequence_id.trusted_packet_sequence_id = 1;

    packet.which_data = perfetto_protos_TracePacket_track_event_tag;
    packet.data.track_event = perfetto_protos_TrackEvent_init_default;

    packet.data.track_event.has_track_uuid = true;
    packet.data.track_event.track_uuid = uuid;

    packet.data.track_event.has_type = true;
    packet.data.track_event.type = perfetto_protos_TrackEvent_Type_TYPE_SLICE_BEGIN;

    packet.data.track_event.which_name_field = perfetto_protos_TrackEvent_name_tag;
    packet.data.track_event.name_field.name = createString(functionName);

    return packet;
  }
  static perfetto_protos_TracePacket addEndEvent(uint64_t uuid, uint64_t timestamp) {
    perfetto_protos_TracePacket packet = perfetto_protos_TracePacket_init_default;
    packet.has_timestamp = true;
    packet.timestamp = timestamp;

    packet.which_optional_trusted_packet_sequence_id = perfetto_protos_TracePacket_trusted_packet_sequence_id_tag;
    packet.optional_trusted_packet_sequence_id.trusted_packet_sequence_id = 1;

    packet.which_data = perfetto_protos_TracePacket_track_event_tag;
    packet.data.track_event = perfetto_protos_TrackEvent_init_default;

    packet.data.track_event.has_track_uuid = true;
    packet.data.track_event.track_uuid = uuid;

    packet.data.track_event.has_type = true;
    packet.data.track_event.type = perfetto_protos_TrackEvent_Type_TYPE_SLICE_END;

    return packet;
  }
};

std::vector<uint8_t> TraceBuilder::createTraceData() {
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

  std::vector<perfetto_protos_TracePacket> packets;

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
      // packets.push_back(addBeginEvent(uuid, scaledTime, functionName));
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
        packets.push_back(addEndEvent(uuid, scaledTime));
      }
    }
  }

  perfetto_protos_Trace trace = perfetto_protos_Trace_init_default;
  trace.packet = createCallOnce([&packets](pb_ostream_t *stream, const pb_field_t *field) -> bool {
    for (perfetto_protos_TracePacket const &packet : packets) {
      assert(pb_encode_tag_for_field(stream, field));
      assert(pb_encode_submessage(stream, field->descriptor, &packet));
    }
    return true;
  });

  std::vector<uint8_t> buffer;
  size_t size;
  assert(pb_get_encoded_size(&size, perfetto_protos_Trace_fields, &trace));
  buffer.resize(size);
  pb_ostream_t stream = pb_ostream_from_buffer(reinterpret_cast<pb_byte_t *>(buffer.data()), buffer.size());
  pb_write(&stream, buffer.data(), buffer.size());
  return buffer;
}

int main() {
  TraceBuilder builder;
  std::vector<uint8_t> traceData = builder.createTraceData();
  warpo::writeBinaryFile(OUTPUT_PF_TRACE_FILE, traceData);
  std::cout << "Trace written to " << OUTPUT_PF_TRACE_FILE << std::endl;
  std::cout << "Open with https://ui.perfetto.dev." << std::endl;
  return 0;
}
