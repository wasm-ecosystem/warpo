rm assemblyscript/build/assemblyscript.warpo-test.*
rm assemblyscript/build/assemblyscript.warpo-test-bootstrap.*

set -e

echo "first build"
node assemblyscript/bin/asc.js --config assemblyscript/src/asconfig.json --target warpo-test --stackSize 262144
build/tools/optimizer/warpo --input assemblyscript/build/assemblyscript.warpo-test.wast --output assemblyscript/build/assemblyscript.warpo-test.wat

echo "second build"
node assemblyscript/bin/asc.js --config assemblyscript/src/asconfig.json --target warpo-test-bootstrap --wasm assemblyscript/build/assemblyscript.warpo-test.js --stackSize 262144
build/tools/optimizer/warpo --input assemblyscript/build/assemblyscript.warpo-test-bootstrap.wast --output assemblyscript/build/assemblyscript.warpo-test-bootstrap.wat

echo "third build"
node assemblyscript/bin/asc.js --config assemblyscript/src/asconfig.json --target warpo-test-bootstrap --wasm assemblyscript/build/assemblyscript.warpo-test-bootstrap.js --stackSize 262144
build/tools/optimizer/warpo --input assemblyscript/build/assemblyscript.warpo-test-bootstrap.wast --output assemblyscript/build/assemblyscript.warpo-test-bootstrap.wat

git --no-pager diff --no-index assemblyscript/build/assemblyscript.warpo-test.wast assemblyscript/build/assemblyscript.warpo-test-bootstrap.wast

echo "success"
