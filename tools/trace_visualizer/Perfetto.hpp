// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>
#include <functional>
#include <protozero/pbf_writer.hpp>
#include <string>

namespace warpo {

struct TraceEventWriter {
  protozero::pbf_writer pbf_;
  enum class Type : int32_t {
    TYPE_SLICE_BEGIN = 1,
    TYPE_SLICE_END = 2,
  };
  inline static constexpr protozero::pbf_tag_type type_tag = 9U;        // optional Type type
  inline static constexpr protozero::pbf_tag_type track_uuid_tag = 11U; // optional uint64 track_uuid
  inline static constexpr protozero::pbf_tag_type name_tag = 23U;       // optional string name

  void writeType(Type type) { pbf_.add_int32(type_tag, static_cast<int32_t>(type)); }
  void writeTrackUuid(uint64_t uuid) { pbf_.add_uint64(track_uuid_tag, uuid); }
  void writeName(std::string const &name) { pbf_.add_string(name_tag, name); }
};

struct TrackDescriptorWriter {
  protozero::pbf_writer pbf_;
  inline static constexpr protozero::pbf_tag_type uuid_tag = 1U; // optional uint64 uuid
  inline static constexpr protozero::pbf_tag_type name_tag = 2U; // optional string name

  void writeUuid(uint64_t uuid) { pbf_.add_uint64(uuid_tag, uuid); }
  void writeName(std::string const &name) { pbf_.add_string(name_tag, name); }
};

struct TracePacketWriter {
  protozero::pbf_writer pbf_;
  inline static constexpr protozero::pbf_tag_type timestamp_tag = 8U; // optional uint64 timestamp
  inline static constexpr protozero::pbf_tag_type trusted_packet_sequence_id_tag =
      10U;                                                               // optional uint32 trusted_packet_sequence_id
  inline static constexpr protozero::pbf_tag_type track_event_tag = 11U; // TrackEvent
  inline static constexpr protozero::pbf_tag_type track_descriptor_tag = 60U; // TrackDescriptor

  void writeTimestamp(uint64_t timestamp) { pbf_.add_uint64(timestamp_tag, timestamp); }
  void writeTrustedPacketSequenceId(uint32_t id) { pbf_.add_uint32(trusted_packet_sequence_id_tag, id); }
  void writeTrackEvent(std::function<void(TraceEventWriter &)> const &writeTraceEvent) {
    TraceEventWriter trackEventWriter{.pbf_ = protozero::pbf_writer{pbf_, track_event_tag}};
    writeTraceEvent(trackEventWriter);
  }
  void writeTrackDescriptor(std::function<void(TrackDescriptorWriter &)> const &writeTrackDescriptor) {
    TrackDescriptorWriter trackDescriptorWriter{.pbf_ = protozero::pbf_writer{pbf_, track_descriptor_tag}};
    writeTrackDescriptor(trackDescriptorWriter);
  }
};

struct TraceWriter {
  inline static constexpr protozero::pbf_tag_type packet_tag = 1U; // repeated TracePacket packet
  std::string data_;
  protozero::pbf_writer pbf_{data_};

  void writeTracePacket(std::function<void(TracePacketWriter &)> const &writePacket) {
    TracePacketWriter tracePacketWriter{.pbf_ = protozero::pbf_writer{pbf_, packet_tag}};
    writePacket(tracePacketWriter);
  }
};

} // namespace warpo