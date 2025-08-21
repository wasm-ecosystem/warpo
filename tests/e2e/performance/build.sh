rm assemblyscript/build/assemblyscript.debug.*

set -e

echo "build HIR"
node assemblyscript/bin/asc.js --config assemblyscript/src/asconfig.json --target debug

echo ""
echo ""
echo "lower and emit"

build/warpo-main --input assemblyscript/build/assemblyscript.debug.wast --output assemblyscript/build/assemblyscript.debug.main.wasm
build/tools/optimizer/warpo --input assemblyscript/build/assemblyscript.debug.wast --output assemblyscript/build/assemblyscript.debug.dev.wasm
ls -l assemblyscript/build/assemblyscript.debug.*.wasm
