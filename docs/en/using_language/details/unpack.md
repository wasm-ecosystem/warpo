# Unpack

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

WARPO supports unpacking array binding patterns from tuple and array values. An unpack declaration must have an initializer.

## Unpack a tuple

Tuple element types are taken from the tuple type of the initializer.

```ts
function makePair(): [i32, string] {
  return [1, "hello"];
}

let [number, text] = makePair();
```

A type annotation applies to the whole binding pattern when one is needed:

```ts
let pair: [i32, string] = [1, "hello"];
let [number, text]: [i32, string] = pair;
```

## Unpack an array

Array element types are taken from the array type of the initializer. The initializer is evaluated once.

```ts
let values: i32[] = [10, 20, 30];
let [first, second] = values;
```

The binding pattern contains identifiers for the elements to unpack. Type annotations on individual bindings are not supported; use a type annotation on the whole pattern instead.
