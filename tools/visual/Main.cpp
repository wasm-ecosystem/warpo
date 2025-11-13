#include <array>
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <iostream>
#include <map>
#include <ranges>
#include <string>
#include <vector>

#include "protos/perfetto/trace/perfetto_trace.pb.h"
#include "warpo/support/FileSystem.hpp"

const std::string TRACE_POINT_MAPPING_FILE = "tmp/perf/trace_points.txt";
const std::string TRACE_RECORD_FILE = "tmp/perf/trace_record.bin";
const std::string OUTPUT_PF_TRACE_FILE = "tmp/perf/output.pftrace";

const double RATE = 1.0 / (200 * 1000000);
const int TOTAL_SLICE_COUNT = 1000;

std::vector<uint8_t> createTraceData() {
  std::map<int, std::string> functionIndexes;
  std::ifstream mapping_file(TRACE_POINT_MAPPING_FILE);
  std::string line;
  while (std::getline(mapping_file, line)) {
    size_t index = line.find(' ');
    if (index != std::string::npos) {
      int fn_id = std::stoi(line.substr(0, index));
      functionIndexes[fn_id] = line.substr(index + 1);
    }
  }

  std::ifstream record_file(TRACE_RECORD_FILE, std::ios::binary);
  std::string magic(16, '\0');
  record_file.read(magic.data(), 16);
  if (magic != "___WARP_TRACE___")
    throw std::runtime_error("Invalid trace record file");

  std::vector<int> pendingSlice;
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
    record_file.read(reinterpret_cast<char *>(data.data()), data.size());
    if (record_file.gcount() < 16)
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
      std::string name = (it != functionIndexes.end()) ? it->second : "unknown function " + std::to_string(fnId);
      add_event(uuid, scaledTime, perfetto::protos::TrackEvent::TYPE_SLICE_BEGIN, &name);
      pendingSlice.push_back(fnId);
    } else {
      size_t pop_count = 0;
      for (int &it : std::ranges::reverse_view(pendingSlice)) {
        pop_count++;
        if (it == -fnId)
          break;
      }
      if (pop_count == pendingSlice.size()) {
        std::cerr << "warning: No matching begin for end event " << fnId << std::endl;
        continue;
      }
      for (int i = 0; i < pop_count; ++i) {
        if (pop_count != i + 1) {
          std::cerr << "warning: No matching end for begin event " << pendingSlice.back() << std::endl;
        }
        pendingSlice.pop_back();
        add_event(uuid, scaledTime, perfetto::protos::TrackEvent::TYPE_SLICE_END);
      }
    }
  }
}

int main() {
  std::vector<uint8_t> traceData = createTraceData();
  warpo::writeBinaryFile(OUTPUT_PF_TRACE_FILE, traceData);
  std::cout << "Trace written to " << OUTPUT_PF_TRACE_FILE << std::endl;
  std::cout << "Open with https://ui.perfetto.dev." << std::endl;
  return 0;
}
