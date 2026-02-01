# Tuple

<p style="display: flex; gap: 10px;">
	<img src="/version/2.4.0.svg" alt="2.4.0" />
	<img src="/stability/rc.svg" alt="rc" />
</p>

WARPO 支持 tuple 类型，用于描述定长、异构（heterogeneous）的值。

## 基本用法

```ts
let pair: [i32, string] = [1, "hello"];
let triple: [i32, f64, bool] = [1, 3.14, true];
```

tuple 字面量是 array 字面量，但会根据 tuple 类型进行上下文类型化（contextually typed）。由于 WARPO 不会推导 tuple 类型，你必须显式提供 tuple 类型或提供上下文类型。

## 元素访问

tuple 元素访问与数组使用相同的下标语法，但下标必须是编译期常量。

```ts
let pair: [i32, string] = [1, "hello"];
let id = pair[0];
let name = pair[1];

pair[0] = 2;
```

```ts
let pair: [i32, string] = [1, "hello"];
let i: i32 = 0;
let value = pair[i]; // error: index must be a compile-time constant
```

## 限制

tuple payload 大小限制为 $64 \times \text{sizeof}(usize)$ 字节。超过该限制的 tuple 会在编译期间被拒绝。

tuple 元素必须是有内存承载（memory-backed）的类型。不支持在 tuple 元素中使用 external references。
