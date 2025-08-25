set -e

VERSION="1.235.0" 

if [ -f "wasm-tools-$VERSION-x86_64-linux.tar.gz" ]; then
  rm ./wasm-tools-$VERSION-x86_64-linux.tar.gz
fi
wget https://github.com/bytecodealliance/wasm-tools/releases/download/v$VERSION/wasm-tools-$VERSION-x86_64-linux.tar.gz

if [ -f "wasm-tools-$VERSION-x86_64-linux/wasm-tools" ]; then
  rm ./wasm-tools-$VERSION-x86_64-linux/wasm-tools
fi
tar -zxvf wasm-tools-$VERSION-x86_64-linux.tar.gz wasm-tools-$VERSION-x86_64-linux/wasm-tools -C wasm-tools11
mv ./wasm-tools-$VERSION-x86_64-linux ./wasm-tools

rm ./wasm-tools-$VERSION-x86_64-linux.tar.gz
