# 类对象字面量的初始化顺序

<p style="display: flex; gap: 10px;">
	<img src="/version/nightly.svg" alt="nightly" />
	<img src="/stability/experimental.svg" alt="experimental" />
</p>

WARPO 与 AssemblyScript 都支持类对象字面量的初始化，WARPO 修复了 AssemblyScript 的bug，同时改变了初始化顺序，是一个break fix。

## 执行顺序

创建实例时，WARPO 按以下顺序执行：

1. 分配实例并运行生成的构造函数，完成类字段的声明初始化器。
2. 为没有声明初始化器且未在字面量中提供的字段补充默认值；例如数值字段为零。
3. 按字面量中的书写顺序，逐项求值并立即写入字段或调用 setter。
4. 返回初始化后的实例。

例如：

```ts
class Record {
  field: i32;
  defaultField: i32 = 7;
  private stored: i32 = 0;

  set value(next: i32) {
    this.stored = next + this.defaultField;
    this.field = next;
  }

  get value(): i32 {
    return this.stored;
  }
}

let record = { value: 2, defaultField: 20, field: 3 } as Record;
```

`value` setter 执行时，`defaultField` 仍为声明的默认值 `7`，因此 `stored` 被设为 `9`，`field` 被设为 `2`。随后字面量继续执行 `defaultField: 20` 和 `field: 3`，所以最终 `record.value == 9`、`record.defaultField == 20`、`record.field == 3`。

setter 的副作用会在求值下一项之前完成。因此后续值表达式可以观察到前一个 setter 的修改；后续显式字段也可能覆盖 setter 之前写入的字段。
