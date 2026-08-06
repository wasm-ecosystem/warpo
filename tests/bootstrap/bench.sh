rm -rf tests/bootstrap/tmp/bench

set -e

echo "=============origin asc build============="
./build/warpo/warpo_asc assemblyscript/src/glue/wasm/index.ts assemblyscript/src/index-wasm.ts \
  --stats \
  --optimizeLevel 3 --shrinkLevel 2 \
  --disable-feature nontrapping-f2i \
  --initialMemory 768 \
  --exportStart _initialize --exportRuntime \
  -o tests/bootstrap/tmp/bench/assemblyscript.warpo-test.wasm
echo "============================================"

echo "\n=============optimized build============="
./build/warpo/warpo_asc assemblyscript/src/glue/wasm/index.ts assemblyscript/src/index-wasm.ts \
  --stats \
  --optimizeLevel 3 --shrinkLevel 2 \
  --disable-feature nontrapping-f2i \
  --initialMemory 768 \
  --exportStart _initialize --exportRuntime \
  --asc-wasm tests/bootstrap/tmp/bench/assemblyscript.warpo-test.wasm \
  -o tests/bootstrap/tmp/bench/assemblyscript.warpo-test-bootstrap.wasm
echo "============================================"