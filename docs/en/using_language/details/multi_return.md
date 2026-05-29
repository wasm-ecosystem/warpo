# Multi Return

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

WARPO supports WebAssembly multi-value returns for imported functions.

## Scope

WebAssembly multi-value return is only applied to import functions.

## Declare an imported function

Use `ffi.MultiReturn<T>` as the return type of the imported function. `T` must be a tuple that describes the WebAssembly result list.

For example, `ffi.MultiReturn<[i32, i32]>` is compiled to a WebAssembly signature with `(result i32 i32)`.

```ts
import { ffi } from "warpo/ffi";

// @ts-ignore: decorator
@external("env", "multi_return_api")
declare function multi_return_api(): ffi.MultiReturn<[i32, i32]>;
```

## Consume the returned values

The only supported way to use `ffi.MultiReturn<T>` is to convert it to a tuple with the builtin function `ffi.multi_return_to_tuple`. All other usage of `ffi.MultiReturn<T>` such as declare a variable with this type is forbidden.

```ts
import { ffi } from "warpo/ffi";

// @ts-ignore: decorator
@external("env", "multi_return_api")
declare function multi_return_api(): ffi.MultiReturn<[i32, i32]>;

export function _start(): i32 {
  let result = ffi.multi_return_to_tuple<[i32, i32]>(multi_return_api());
  return result[0] + result[1];
}
```

Build with `warpo -o multi-return.wasm multi-return.ts`

Javascript launcher

```javascript
import { readFile } from "node:fs/promises";
import assert from "node:assert";

const utf16 = new TextDecoder("utf-16le");

function decodeString(memory, ptr) {
  if (!ptr) return "null";
  const view = memory instanceof Uint8Array ? memory : new Uint8Array(memory.buffer);
  const length = new DataView(view.buffer, view.byteOffset, view.byteLength).getUint32(ptr - 4, true) >>> 1;
  return utf16.decode(new Uint8Array(view.buffer, view.byteOffset + ptr, length << 1));
}

const intervalMap = new Map();
let intervalCounter = 0;

const binary = await readFile("multi-return.wasm");
let exportedMemory = null;

const imports = {
  env: {
    abort(msg, file, line, column) {
      throw new Error(
        `abort: ${decodeString(exportedMemory, msg)} at ${decodeString(exportedMemory, file)}:${line}:${column}`
      );
    },
    multi_return_api() {
      return [20, 22];
    },
    trace(msg) {
      console.log(decodeString(exportedMemory, msg));
    },
  },
};

const { instance } = await WebAssembly.instantiate(binary, imports);
exportedMemory = instance.exports.memory;
assert(typeof instance.exports._start === "function", "_start export not found");
const res = instance.exports._start();
console.log("Result:", res);
```

Run with node ./run.js
