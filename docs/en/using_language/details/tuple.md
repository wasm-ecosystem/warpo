# Tuple

<p style="display: flex; gap: 10px;">
  <img src="/version/2.4.0.svg" alt="2.4.0" />
  <img src="/stability/rc.svg" alt="rc" />
</p>

WARPO supports tuple types to describe fixed-length, heterogeneous values.

## Basic usage

```ts
let pair: [i32, string] = [1, "hello"];
let triple: [i32, f64, bool] = [1, 3.14, true];
```

Tuple literals are array literals that are contextually typed by a tuple type. Because WARPO does not infer tuple types, you must provide an explicit tuple type or a contextual type.

## Element access

Tuple element access uses the same index syntax as arrays, but the index must be a compile-time constant.

```ts
let pair: [i32, string] = [1, "hello"];
let id = pair[0];
let name = pair[1];

pair[0] = 2;
```

```ts
let pair: [i32, string] = [1, "hello"];
let i: i32 = 0;
let value = pair[i]; // error: index must be a compile-time constant
```

## Limits

Tuple payload size is limited to $64 \times \text{sizeof}(usize)$ bytes. Tuples that exceed this limit are rejected during compilation.

Tuple elements must be memory-backed types. External references are not supported in tuple elements.
