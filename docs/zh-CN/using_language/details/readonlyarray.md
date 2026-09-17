# `ReadonlyArray<T>`

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

`ReadonlyArray<T>` 是只读数组接口，旨在表达不可变（immutable）或仅供读取的数据视图。它只包含读取与非就地变换方法，不包含任何诸如 `push`、`pop`、`shift`、`unshift` 等变异方法，也不支持通过下标进行赋值写入。

## 保证只读与防止意外修改

将参数声明为 `ReadonlyArray<T>` 可以防止被调函数对传入的数组做原地修改：

```ts
function printSummary(data: ReadonlyArray<i32>): void {
  // 只读访问与方法均可正常使用
  let len = data.length;
  let first = data[0];
  let last = data.at(-1);

  // 编译错误：ReadonlyArray 不支持写入或变异方法
  // data[0] = 999;     // ERROR: 没有索引设置器
  // data.push(100);    // ERROR: 属性不存在
  // data.pop();        // ERROR: 属性不存在
}

let numbers: Array<i32> = [1, 2, 3];
printSummary(numbers); // Array<T> 实现了 ReadonlyArray<T>，可以直接传入
```

## 隐式向上类型转换（Upcasting）

标准库中的 `Array<T>` 实现了 `ReadonlyArray<T>` 接口，因此任何普通的 `Array<T>` 实例都可以无缝赋值给 `ReadonlyArray<T>` 类型的变量或参数：

```ts
let list: Array<string> = ["apple", "banana", "cherry"];

// 转换为只读视图
let readonlyList: ReadonlyArray<string> = list;

assert(readonlyList.length == 3);
assert(readonlyList[0] == "apple");
assert(readonlyList.includes("banana"));

// 不能再通过只读变量修改底层数组
// readonlyList.push("date"); // 编译报错
```

## 非破坏性变换方法

`ReadonlyArray<T>` 上的查询与变换方法不会修改原始数组本身，若产生新的集合，则返回全新的 `Array<T>` 实例：

```ts
let values: ReadonlyArray<i32> = [1, 2, 3, 4, 5];

// 遍历与查找
let hasEven = values.some((v) => v % 2 == 0); // true
let allPositive = values.every((v) => v > 0); // true

// 生成新的数组副本，原数组保持不变
let evens: Array<i32> = values.filter((v) => v % 2 == 0);
let sub: Array<i32> = values.slice(1, 3);

// 转换为字符串
let text: string = values.join(" - "); // "1 - 2 - 3 - 4 - 5"
```
