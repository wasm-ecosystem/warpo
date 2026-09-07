// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <exception>
#include <filesystem>
#include <fmt/base.h>
#include <iostream>
#include <memory>
#include <stdexcept>

#include "TraceBuilder.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo {

static cli::Opt<std::filesystem::path> tracePointMappingFileOption{
    cli::Category::All,
    "--trace-point-mapping-file",
    [](argparse::Argument &arg) -> void { arg.help("File to read the trace point mapping."); },
};

static cli::Opt<std::filesystem::path> tracePointMappingJsonFileOption{
    cli::Category::All,
    "--trace-point-mapping-json-file",
    [](argparse::Argument &arg) -> void {
      arg.help("JSON file containing mapping between module id and trace point mapping file.");
    },
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

void traceVisualizerMain(int argc, char const **argv) {
  argparse::ArgumentParser program("warpo_trace_visualizer", "git@" GIT_COMMIT);
  cli::init(cli::Category::All, program, argc, argv);

  bool const hasSingleMapping = tracePointMappingFileOption.isSet();
  bool const hasJsonMapping = tracePointMappingJsonFileOption.isSet();

  if (!hasSingleMapping && !hasJsonMapping)
    throw std::runtime_error("Either --trace-point-mapping-file or --trace-point-mapping-json-file must be specified.");

  if (hasSingleMapping && hasJsonMapping)
    throw std::runtime_error("Cannot specify both --trace-point-mapping-file and --trace-point-mapping-json-file.");

  std::unique_ptr<TraceBuilder> builder;
  if (hasJsonMapping) {
    builder = std::make_unique<TraceBuilder>(TraceBuilder::MappingJsonTag{}, tracePointMappingJsonFileOption.get(),
                                             traceRecordFileOption.get(), countToPerfettoTimestampRateOption.get(),
                                             maxSliceCountOption.get());
  } else {
    builder = std::make_unique<TraceBuilder>(tracePointMappingFileOption.get(), traceRecordFileOption.get(),
                                             countToPerfettoTimestampRateOption.get(), maxSliceCountOption.get());
  }

  builder->process();
  warpo::writeBinaryFile(outputFileOption.get(), builder->writer_.data_);
  std::cout << "Trace written to " << outputFileOption.get() << std::endl;
  std::cout << "Open with https://ui.perfetto.dev." << std::endl;
}

} // namespace warpo

#ifndef WARPO_ENABLE_UNIT_TESTS
int main(int argc, char const **argv) {
  try {
    warpo::traceVisualizerMain(argc, argv);
  } catch (std::exception const &e) {
    fmt::println(stderr, "ERROR: {}", e.what());
    return 1;
  }
  return 0;
}
#endif
