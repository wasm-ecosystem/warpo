rm -rf assemblyscript/build

set -e

echo "first build"
node assemblyscript/bin/asc.js --config assemblyscript/src/asconfig.json --target debug --stackSize 262144
build/tools/optimizer/warpo --input assemblyscript/build/assemblyscript.debug.wast --output assemblyscript/build/assemblyscript.debug.wat

echo "second build"
node assemblyscript/bin/asc.js --config assemblyscript/src/asconfig.json --target debug-bootstrap --wasm assemblyscript/build/assemblyscript.debug.js --stackSize 262144
build/tools/optimizer/warpo --input assemblyscript/build/assemblyscript.debug-bootstrap.wast --output assemblyscript/build/assemblyscript.debug-bootstrap.wat

echo "third build"
node assemblyscript/bin/asc.js --config assemblyscript/src/asconfig.json --target debug-bootstrap --wasm assemblyscript/build/assemblyscript.debug-bootstrap.js --stackSize 262144
build/tools/optimizer/warpo --input assemblyscript/build/assemblyscript.debug-bootstrap.wast --output assemblyscript/build/assemblyscript.debug-bootstrap.wat

git --no-pager diff --no-index assemblyscript/build/assemblyscript.debug.wast assemblyscript/build/assemblyscript.debug-bootstrap.wast

echo "success"
