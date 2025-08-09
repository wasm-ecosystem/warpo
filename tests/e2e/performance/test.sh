rm assemblyscript/build/assemblyscript.debug.*

set -e

echo "build HIR"
node assemblyscript/bin/asc.js --config assemblyscript/src/asconfig.json --target debug
ls -l assemblyscript/build/assemblyscript.debug.wasm
echo "lower and emit"
build/tools/optimizer/warpo --input assemblyscript/build/assemblyscript.debug.wast --output assemblyscript/build/assemblyscript.debug.wat
ls -l assemblyscript/build/assemblyscript.debug.wasm

echo "\n\n\build test suite\n\n"
echo "warpo optimized bootstrap build time"
node assemblyscript/bin/asc.js --config ../assemblyscript/src/asconfig.json --target debug --wasm assemblyscript/build/assemblyscript.debug.js 2>&1 | grep "│ compile"
echo "normal release bootstrap build time"
node ../assemblyscript/bin/asc.js --config ../assemblyscript/src/asconfig.json --target debug --wasm ../assemblyscript/build/assemblyscript.release.js 2>&1 | grep "│ compile"
