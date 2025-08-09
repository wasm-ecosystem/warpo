set -e

echo "build baseline"
cd ../assemblyscript
npm run build
cd -
node ../assemblyscript/bin/asc.js --config ../assemblyscript/src/asconfig.json --target release
