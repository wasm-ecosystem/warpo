# `ReadonlyArray<T>`

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

`ReadonlyArray<T>` is the read-only collection interface for array-like values. It supports indexed reads, iteration, searching, and common collection operations without exposing array mutation methods such as `push` or `pop`.

`Array<T>` implements `ReadonlyArray<T>`, so a mutable array can be passed to a function that only needs to read it:

```ts
function joinValues(values: ReadonlyArray<string>): string {
  return values.join(",");
}

let values = new Array<string>();
values.push("a");
values.push("b");
assert(joinValues(values) == "a,b");
```

The interface includes indexed access, `length`, `at`, search methods such as `includes` and `indexOf`, iteration methods such as `forEach`, `every`, and `some`, and collection methods such as `filter`, `slice`, `join`, and `toString`. Operations that create a collection return a new `Array<T>`.

```ts
function firstAndLast(values: ReadonlyArray<i32>): i32 {
  assert(values.length > 0);
  return values[0] + values.at(-1);
}

let numbers = new Array<i32>();
numbers.push(10);
numbers.push(20);
assert(firstAndLast(numbers) == 30);
```
