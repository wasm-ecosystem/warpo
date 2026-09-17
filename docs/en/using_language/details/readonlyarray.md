# `ReadonlyArray<T>`

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

`ReadonlyArray<T>` is a read-only array interface representing an immutable or view-only sequence of items. It exposes reading and non-mutating transformation operations, but excludes any mutating operations such as `push`, `pop`, `shift`, or `unshift`, as well as indexed element assignments.

## Preventing Accidental Mutations

Declaring parameters as `ReadonlyArray<T>` ensures that the called function cannot mutate the provided array in-place:

```ts
function printSummary(data: ReadonlyArray<i32>): void {
  // Reading elements and properties works as expected
  let len = data.length;
  let first = data[0];
  let last = data.at(-1);

  // Compile error: ReadonlyArray does not support mutation or setters
  // data[0] = 999;     // ERROR: No index setter
  // data.push(100);    // ERROR: Property does not exist
  // data.pop();        // ERROR: Property does not exist
}

let numbers: Array<i32> = [1, 2, 3];
printSummary(numbers); // Array<T> implements ReadonlyArray<T>, so passing it is valid
```

## Upcasting to Readonly Views

`Array<T>` in the standard library implements `ReadonlyArray<T>`. Any mutable `Array<T>` can be assigned directly to a `ReadonlyArray<T>` variable or parameter:

```ts
let list: Array<string> = ["apple", "banana", "cherry"];

// Upcast to a readonly view
let readonlyList: ReadonlyArray<string> = list;

assert(readonlyList.length == 3);
assert(readonlyList[0] == "apple");
assert(readonlyList.includes("banana"));

// Mutating via the readonly reference is disallowed at compile time
// readonlyList.push("date"); // Compile error
```

## Non-Destructive Operations

Query and transformation methods on `ReadonlyArray<T>` never modify the original array. Any operation producing a new collection returns a new `Array<T>` instance:

```ts
let values: ReadonlyArray<i32> = [1, 2, 3, 4, 5];

// Querying and testing
let hasEven = values.some((v) => v % 2 == 0); // true
let allPositive = values.every((v) => v > 0); // true

// Methods producing new collections return fresh Array<T> instances
let evens: Array<i32> = values.filter((v) => v % 2 == 0);
let sub: Array<i32> = values.slice(1, 3);

// Conversion to string
let text: string = values.join(" - "); // "1 - 2 - 3 - 4 - 5"
```
