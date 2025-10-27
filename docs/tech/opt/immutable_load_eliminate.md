During coding, there are always lots of never changed static data which is similar as .text section in ELF.

In AS, this type of immutable data mainly includes string literals and function object.

## Function Object

For function objects, if we can identify this kinds of data, we can simplify lots of indirect function call.

Considering below example for function object:

```ts
function v(fn: () => void): void {
  fn();
}
v(() => {});
```

Arrow function `() => {}` will be compiled as function object which stored in static data area with function index `I`.
The function `v` will accept a `ptr` which is pointing to the function object. During calling `fn`, the function index will be load from `ptr` and call arrow function by `call_indirect`.

After eliminate the load data from immutable data area, subsequence compilation optimization can infer the function index in `call_indirect` is never changed and simplify it as `call`.

## String Literal

not implement yet.

## How

Binaryen cannot optimize this cases directly because this semantics cannot be properly expressed in a wasm spec.

The pass rely on the additional information `ImmutableDataElementRanges` passed in `AsModule` which define the ranges of immutable data.

When load data inside this range, the load instruction will be replaced as const instruction.
