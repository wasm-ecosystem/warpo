# Computed Property Names

Computed Property Names 是 TypeScript/JavaScript 的一个特性：允许我们在对象字面量中使用表达式来动态定义属性名。当你需要基于运行时条件动态创建方法时，这会非常有用。

在 AssemblyScript 中，一切都更偏向静态，这使得实现像 TypeScript 那样强大的计算属性名变得困难。<br/>
不过，我们可以将其与 symbol 结合使用，避免某些特殊函数出现重复的方法名问题。<br/>
这也为用户提供了构建自定义标准库的机会。

## 限制

在 AssemblyScript 中，我们希望一切是静态的；TS/JS 的计算属性名会破坏这一假设。因此我们会做一些限制以满足静态化需求。

- 计算属性名必须引用一个 const 全局变量。<br/>
  实际上，warpo 是根据该全局变量的唯一名字来实现计算属性名，而不是根据运行时的 value。<br/>
  例如，计算属性名引用了 `assembly/index.ts` 中的 `a`，它会被转换为唯一名字 `[assembly/index/a]`。

## 用法

### 将计算属性名用作方法名

<p style="display: flex; gap: 10px;">
	<img src="/version/2.3.0.svg" alt="2.3.0" />
	<img src="/stability/stable.svg" alt="stable" />
</p>

下面示例声明了接口 `IComputedPropertyFn`，要求实现一个特殊方法 `[computed_property_symbol]`。<br/>
`ComputedPropertyFn` 实现了 `IComputedPropertyFn`。<br/>
该方法只能通过 symbol 引用 `computed_property_symbol` 访问。

```ts
const computed_property_symbol = Symbol.for("fn");

interface IComputedPropertyFn {
  [computed_property_symbol](): string;
}
class ComputedPropertyFn implements IComputedPropertyFn {
  [computed_property_symbol](): string {
    return "Hello, World!";
  }
}
let f: IComputedPropertyFn = new ComputedPropertyFn();
assert(f[computed_property_symbol]() === "Hello, World!");
```

这对一些内部 API 很有用：方法名不应与其他代码发生冲突。

### 其他

尚未实现。
