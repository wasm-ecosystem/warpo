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
  return value;
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
