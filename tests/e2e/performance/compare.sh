echo "\nbuild time comparison"

echo "normal release bootstrap build time"
node ../assemblyscript/bin/asc.js --config ../assemblyscript/src/asconfig.json --target debug --wasm ../assemblyscript/build/assemblyscript.release.js 2>&1 | grep "│ compile"

echo "warpo optimized bootstrap build time [dev]"
cp assemblyscript/build/assemblyscript.debug.dev.wasm assemblyscript/build/assemblyscript.debug.wasm
node assemblyscript/bin/asc.js --config ../assemblyscript/src/asconfig.json --target debug --wasm assemblyscript/build/assemblyscript.debug.js 2>&1 | grep "│ compile"

echo "warpo optimized bootstrap build time [main]"
cp assemblyscript/build/assemblyscript.debug.main.wasm assemblyscript/build/assemblyscript.debug.wasm
node assemblyscript/bin/asc.js --config ../assemblyscript/src/asconfig.json --target debug --wasm assemblyscript/build/assemblyscript.debug.js 2>&1 | grep "│ compile"
