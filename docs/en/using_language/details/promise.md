# Promise

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

WARPO supports `Promise` with an API similar to TypeScript, but there are several key differences due to AssemblyScript's type system constraints. AssemblyScript does not support union types or `unknown`, `any`, so the internal `Promise` implementation uses `Object | null` as the common type for resolved values and rejected reasons. This means only reference types can be used, and type information is lost when combining multiple promises.

## Basic Usage

```ts
const p = new Promise<string>((resolve, reject) => {
  resolve("hello");
});

p.then<string>((value: string | null): Object | null => {
  return Promise.resolve<string>(value as string);
}, null).then<Object>((value: string | null): Object | null => {
  trace(value as string);
  return null;
}, null);
```

## Differences from TypeScript Promise

### Only Reference Types Are Supported

AssemblyScript's type system requires that generic type parameters used with `Promise` must be reference types (i.e., objects). Basic value types such as `i32`, `f32`, `u8`, `bool`, etc. **cannot** be used directly as the type parameter of a `Promise`.

```ts
// Not supported
const p = new Promise<i32>((resolve, reject) => {
  resolve(42);
});
```

### `Promise.all` Erases Result Types

In TypeScript, `Promise.all` preserves the type of each element in the result array. In WARPO, `Promise.all` returns `Promise<(Object | null)[]>`, meaning all result types are erased to `Object | null`. You need to cast the results back to the expected types manually.

```ts
// TypeScript: result is [string, number]
// WARPO: result is (Object | null)[]

const p1 = Promise.resolve<string>("hello");
const p2 = Promise.resolve<string>("world");

Promise.all([p1, p2]).then<void>((values: (Object | null)[] | null): Object | null => {
  if (values) {
    const v0 = values[0] as string; // manual cast required
    const v1 = values[1] as string;
  }
  return null;
}, null);
```

### `then` Callback Return Types Are Narrower Than TypeScript

TypeScript models `then` returns as `U | PromiseLike<U>`. AssemblyScript cannot express that cleanly here, so WARPO uses `Object | null`.

In practice, prefer returning a `Promise` to continue the chain or `null` to end it. Returning a plain reference value still works, but its type is erased.

### `Promise.any` Erases Result Types

Similar to `Promise.all`, `Promise.any` returns `Promise<Object | null>` instead of preserving the resolved type. You need to cast the result back manually.

```ts
const p1 = Promise.resolve<string>("hello");
const p2 = Promise.resolve<string>("world");

Promise.any([p1, p2]).then<void>((value: Object | null): Object | null => {
  const str = value as string; // manual cast required
  return null;
}, null);
```

Example

```typescript
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

  const p = new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
    setTimeout_wrapper(() => {
      trace("timeout reached");
      resolve("resolve 1");
    }, 1);
  }).then<Object>((value: string | null) => {
    trace(`then value: ${value}`);
    return null;
  });
}
```
