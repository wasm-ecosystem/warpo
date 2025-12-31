# iterators

<p style="display: flex; gap: 10px;">
  <img src="/version/2.3.0.svg" alt="2.3.0" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

Iterators provide a uniform way to step through collections (arrays, maps, sets, strings) one element at a time. In AssemblyScript they are similar as TypeScript: an object exposes a `next()` method that returns `IteratorResult<T>`, and an iterable exposes `[Symbol.iterator]()` that produces such an iterator.

There are 3 kinds of object.

- The upper layer is `Iterable` interface. It should provide `[Symbol.iterator]` method to return an iterator.
  ```ts
  export interface Iterable<T> {
    [Symbol.iterator](): Iterator<T>;
  }
  ```
- The middle layer is `Iterator` interface. It should provide `next` method to return an iterator result.
  ```ts
  export interface Iterator<T> {
    next(): IteratorResult<T>;
  }
  ```
- The lower layer is `IteratorResult<T>` class. It provides 2 readonly fields, `done` and `value`.
  - `done`: boolean flag. `false` means the iterator can still yield more items; `true` marks iteration is finished. Once done is true, consumers (e.g., for...of) stop pulling values.
  - `value`: payload for the current step. When `done` is `false`, it holds the next item. When done is true, it’s undefined.
  ```ts
  declare class IteratorResult<T> {
    private constructor(value: T);
    get done(): boolean;
    get value(): T;
    static done<T>(): IteratorResult<T>;
    static fromValue<T>(value: T): IteratorResult<T>;
  }
  ```
  Additional, AS provide 2 helper static functions to define custom iterator.
  - `IteratorResult.done<T>()` to create a finished `IteratorResult` without any value.
  - `IteratorResult.fromValue<T>(value)` to create a unfinished `IteratorResult` with value.

### Minimal custom iterable

Implement `[Symbol.iterator]()` to make your type usable with `for...of` and spread:

```ts
class MyIterator implements Iterator<string> {
  private index: i32 = 0;
  constructor(private items: string[]) {}
  next(): IteratorResult<string> {
    if (this.index < this.items.length) {
      return IteratorResult.fromValue<string>(this.items[this.index++]);
    } else {
      return IteratorResult.done<string>();
    }
  }
}
class MyIterable implements Iterable<string> {
  private items: string[] = ["a", "b", "c"];
  [Symbol.iterator](): MyIterator {
    return new MyIterator(this.items);
  }
}

export function _start(): void {
  const myIterable = new MyIterable();
  for (const value of myIterable) {
    trace(`value = ${value}`);
    // trace: value = a
    // trace: value = b
    // trace: value = c
  }
}
```

### Tips

- Keep iterators side-effect free and lazy: compute values only when `next()` is called.

With these building blocks you can make your domain objects feel native to TypeScript’s iteration syntax, enabling clean, composable loops and transformations.
