# `ReadonlyArray<T>`

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

`ReadonlyArray<T>` 是面向数组类值的只读集合接口。它支持下标读取、迭代、查找和常见集合操作，但不提供 `push`、`pop` 等数组修改方法。

`Array<T>` 实现了 `ReadonlyArray<T>`，因此可以把可变数组传给只需要读取数据的函数：

```ts
function joinValues(values: ReadonlyArray<string>): string {
  return values.join(",");
}

let values = new Array<string>();
values.push("a");
values.push("b");
assert(joinValues(values) == "a,b");
```

该接口包括下标访问、`length`、`at`、`includes` 和 `indexOf` 等查找方法、`forEach`、`every` 和 `some` 等迭代方法，以及 `filter`、`slice`、`join` 和 `toString` 等集合方法。创建新集合的操作会返回新的 `Array<T>`。

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
