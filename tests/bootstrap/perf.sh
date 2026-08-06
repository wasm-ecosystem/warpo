rm -rf tests/bootstrap/tmp/perf
mkdir -p tests/bootstrap/tmp/perf
set -e

echo "build with trace points"
./build/warpo/warpo_asc assemblyscript/src/glue/wasm/index.ts assemblyscript/src/index-wasm.ts \
  --stats \
  --optimizeLevel 3 --shrinkLevel 2 \
  --disable-feature nontrapping-f2i \
  --initialMemory 768 \
  --exportStart _initialize --exportRuntime --exportTable \
  --trace-point-mapping-file tests/bootstrap/tmp/perf/trace_points.txt \
  -o tests/bootstrap/tmp/perf/assemblyscript.warpo-trace-point.wasm

echo "tracing"
export WARP_TRACING_RECORDER_FILE=tests/bootstrap/tmp/perf/record.bin

./build/warpo/warpo_asc assemblyscript/src/glue/wasm/index.ts assemblyscript/src/index-wasm.ts \
  --stats \
  --optimizeLevel 3 --shrinkLevel 2 \
  --disable-feature nontrapping-f2i \
  --initialMemory 768 \
  --exportStart _initialize --exportRuntime --exportTable \
  --asc-wasm tests/bootstrap/tmp/perf/assemblyscript.warpo-trace-point.wasm \
  -o tests/bootstrap/tmp/perf/assemblyscript.wasm

echo "visualizing trace"
./build/warpo/warpo_trace_visualizer \
  --trace-point-record-file tests/bootstrap/tmp/perf/record.bin \
  --trace-point-mapping-file tests/bootstrap/tmp/perf/trace_points.txt \
  --output-pftrace-file tests/bootstrap/tmp/perf/trace.pftrace
