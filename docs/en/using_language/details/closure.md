# Closure

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

WARPO supports closures — functions that capture variables from their enclosing scope.

## Basic usage

Inner functions can read and write variables from outer scopes:

```ts
function outer(): i32 {
  let x: i32 = 41;
  function inner(): i32 {
    x = x + 1;
    return x;
  }
  return inner();
}

assert(outer() == 42);
```

Arrow functions work the same way, and also capture `this`:

```ts
class Counter {
  count: i32 = 0;

  increment(): () => i32 {
    return (): i32 => {
      this.count += 1;
      return this.count;
    };
  }
}
```

## Current limitation: self-reference during initialization

WARPO closures currently cannot reference a variable from inside the same variable's
initializer expression.

This pattern is not supported:

```ts
// Not supported: `stop` is referenced while `stop` is still being initialized.
let stop = register((): void => {
  stop();
});
```

Use a two-phase pattern instead: declare first, assign later.

```ts
type StopFn = () => void;

let stop: StopFn | null = null;

const onEvent = (): void => {
  if (stop) {
    stop();
  }
};

stop = register(onEvent);
```

Why this works: the closure captures a stable outer binding (`stop`), and the binding is
assigned after the closure is created.

## Closure with FFI

When passing a closure to a host function (e.g. `setTimeout`, `setInterval`), extra steps are required because the host cannot call closures directly. You need to:

1. Compile with `--exportTable` so the WebAssembly function table is exposed to the host.
2. Import `ffi` from `"warpo/ffi"` and call `ffi.set_ffi_closure_env(userData)` as the **first statement** in the callback.
3. Pin the closure environment with `__pin` before passing it to the host.
4. Unpin with `__unpin` when the closure is no longer needed.

::: tip
Always pass `--exportTable` when compiling modules that use FFI closures:

```sh
warpo --exportTable input.ts -o output.wasm
```

:::

::: warning
`ffi.set_ffi_closure_env(userData)` **must** be the first statement in every FFI callback closure. Omitting it will cause the closure to lose access to its captured variables.
:::

### One-shot callback

For callbacks that fire once (e.g. `setTimeout`), unpin inside the callback:

```ts
import { __pin, __unpin } from "rt/index";
import { ffi } from "warpo/ffi";

// @ts-ignore: decorator
@external("env", "setTimeout")
declare function setTimeout(timeout: i32, functionIndex: i32, userData: i32): void;

function setTimeout_wrapper(cb: () => void, timeout: i32): void {
  const wrapper = (userData: i32): void => {
    ffi.set_ffi_closure_env(userData);
    __unpin(userData);
    return cb();
  };
  __pin(wrapper.env);
  setTimeout(timeout, wrapper.index, wrapper.env);
}

export function _start(): void {
  let x: i32 = 0;
  function tick(): void {
    x = x + 1;
    trace(`tick: x = ${x}`);
  }
  setTimeout_wrapper(tick, 100);
}
```

### Repeating callback

For callbacks that fire multiple times (e.g. `setInterval`), keep the environment pinned and unpin when you clear it.
Also follow the two-phase pattern above: declare the handle variable first, then assign it.

**WebAssembly side (`counter.ts`)**

```ts
import { __pin, __unpin } from "rt/index";
import { ffi } from "warpo/ffi";

// @ts-ignore: decorator
@external("env", "setInterval")
declare function setInterval(timeout: i32, functionIndex: i32, userData: i32): i32;

// @ts-ignore: decorator
@external("env", "clearInterval")
declare function clearInterval(intervalId: i32): void;

class IntervalInfo {
  id: i32 = 0;
  env: usize = 0;
}

function setInterval_wrapper(cb: () => void): IntervalInfo {
  const wrapper = (userData: i32): void => {
    ffi.set_ffi_closure_env(userData);
    return cb();
  };
  __pin(wrapper.env);
  const id = setInterval(1000, wrapper.index, wrapper.env);
  const info = new IntervalInfo();
  info.id = id;
  info.env = wrapper.env;
  return info;
}

function clearInterval_wrapper(info: IntervalInfo): void {
  clearInterval(info.id);
  __unpin(info.env);
}

export function _start(): void {
  let x: i32 = 0;
  let intervalInfo: IntervalInfo | null = null;

  function tick(): void {
    x = x + 1;
    trace(`tick: x = ${x}`);
    if (x >= 3) {
      if (intervalInfo) {
        clearInterval_wrapper(intervalInfo);
      }
    }
  }

  intervalInfo = setInterval_wrapper(tick);
}
```

**Host side (`host.mjs`)**

```js
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

const binary = await readFile("counter.wasm");
let exportedMemory = null;

const imports = {
  env: {
    abort(msg, file, line, column) {
      throw new Error(
        `abort: ${decodeString(exportedMemory, msg)} at ${decodeString(exportedMemory, file)}:${line}:${column}`
      );
    },
    trace(msg) {
      console.log(decodeString(exportedMemory, msg));
    },
    setInterval(timeout, callbackIndex, userData) {
      const handle = global.setInterval(() => {
        const table = instance.exports.table;
        const fn = table.get(callbackIndex);
        fn(userData);
      }, timeout);
      const intervalId = intervalCounter;
      intervalMap.set(intervalId, handle);
      intervalCounter++;
      return intervalId;
    },
    clearInterval(intervalId) {
      const handle = intervalMap.get(intervalId);
      if (handle) {
        global.clearInterval(handle);
        intervalMap.delete(intervalId);
      }
    },
    setTimeout(delay, callbackIndex, userData) {
      const id = intervalCounter;
      const handle = global.setTimeout(() => {
        intervalMap.delete(id);
        const table = instance.exports.table;
        const fn = table.get(callbackIndex);
        fn(userData);
      }, delay);
      intervalMap.set(id, handle);
      intervalCounter++;
      return id;
    },
  },
};

const { instance } = await WebAssembly.instantiate(binary, imports);
exportedMemory = instance.exports.memory;
assert(typeof instance.exports._start === "function", "_start export not found");
instance.exports._start();
```

The host stores `callbackIndex` (a WebAssembly table index) and `userData` (the closure environment pointer). When the timer fires, it retrieves the wrapper function from the table and calls it with `userData`, which `ffi.set_ffi_closure_env` uses to restore the captured variables.
