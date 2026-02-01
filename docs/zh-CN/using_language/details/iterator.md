# iterators

<p style="display: flex; gap: 10px;">
	<img src="/version/2.3.0.svg" alt="2.3.0" />
	<img src="/stability/experimental.svg" alt="experimental" />
</p>

Iterator 提供了一种统一方式，以逐元素（one element at a time）遍历集合（数组、map、set、字符串）。在 AssemblyScript 中，它们与 TypeScript 的语义类似：iterator 对象暴露 `next()` 方法并返回 `IteratorResult<T>`；iterable 对象暴露 `[Symbol.iterator]()` 方法来生成 iterator。

这里有三类对象：

- 最上层是 `Iterable` 接口：提供 `[Symbol.iterator]` 方法返回一个 iterator。
  ```ts
  export interface Iterable<T> {
    [Symbol.iterator](): Iterator<T>;
  }
  ```
- 中间层是 `Iterator` 接口：提供 `next` 方法返回 iterator result。
  ```ts
  export interface Iterator<T> {
    next(): IteratorResult<T>;
  }
  ```
- 最底层是 `IteratorResult<T>` 类：提供两个只读字段 `done` 与 `value`。
  - `done`：boolean 标记。`false` 表示 iterator 还能继续产出值；`true` 表示迭代结束。一旦 done 为 true，消费者（例如 for...of）就会停止拉取。
  - `value`：当前步骤的 payload。当 `done` 为 `false` 时，它保存下一个元素；当 done 为 true 时，它是 undefined。
  ```ts
  declare class IteratorResult<T> {
    private constructor(value: T);
    get done(): boolean;
    get value(): T;
    static done<T>(): IteratorResult<T>;
    static fromValue<T>(value: T): IteratorResult<T>;
  }
  ```
  另外，AS 还提供了两个辅助静态函数，用于定义自定义 iterator：
  - `IteratorResult.done<T>()`：创建一个已结束（finished）的 `IteratorResult`，不包含任何 value。
  - `IteratorResult.fromValue<T>(value)`：创建一个未结束（unfinished）的 `IteratorResult`，带有 value。

### 最小可迭代对象示例

实现 `[Symbol.iterator]()`，即可让你的类型可用于 `for...of` 与 spread：

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

- 尽量让 iterator 保持无副作用且惰性（lazy）：仅在 `next()` 被调用时计算值。

借助这些构建块，你可以让领域对象在 TypeScript 的迭代语法下表现得更“原生”，从而编写更清晰、可组合的循环与变换。
