#! /usr/bin/env bash

echo "start archive" &&
    git submodule deinit --all &&
    git submodule update --init --depth=1 thirdparty/json thirdparty/berkeley-softfloat-3 &&
    git ls-files --recurse-submodules | tar caf $([[ -z $package_name ]] && echo wasm-compiler-$(git describe --tags --exact-match HEAD || git rev-parse HEAD).tar.gz || echo $package_name) -T-
