# 解包

<p style="display: flex; gap: 10px;">
	<img src="/version/nightly.svg" alt="nightly" />
	<img src="/stability/experimental.svg" alt="experimental" />
</p>

WARPO 支持使用数组绑定模式从 tuple 和数组值中解包。解包声明必须包含初始化表达式。

## 解包 tuple

tuple 元素的类型取自初始化表达式的 tuple 类型。

```ts
function makePair(): [i32, string] {
  return [1, "hello"];
}

let [number, text] = makePair();
```

如果需要类型注解，类型注解应写在整个绑定模式上：

```ts
let pair: [i32, string] = [1, "hello"];
let [number, text]: [i32, string] = pair;
```

## 解包数组

数组元素的类型取自初始化表达式的数组类型。初始化表达式只会执行一次。

```ts
let values: i32[] = [10, 20, 30];
let [first, second] = values;
```

绑定模式中的元素必须是标识符，不支持为单个绑定元素添加类型注解；如需类型注解，应将其写在整个绑定模式上。
