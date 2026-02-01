# Enum

<p style="display: flex; gap: 10px;">
	<img src="/version/2.2.3.svg" alt="2.2.3" />
	<img src="/stability/stable.svg" alt="stable" />
</p>

## 基本用法

与 TS 类似，你可以在 WARPO 中使用 `enum` 定义枚举值。

```ts
enum Direction {
  Up,
  Down,
  Left,
  Right,
}
```

- 带显式值的枚举

```ts
enum HttpStatus {
  Ok = 200,
  NotFound = 404,
  ServerError = 500,
}
```

- WARPO 不支持 string enums

```ts
enum Color {
  Red = "RED",
  Green = "GREEN",
  Blue = "BLUE",
}
```

- 使用枚举

```ts
let direction: Direction = Direction.Up;
let status: HttpStatus = HttpStatus.Ok;
```

## 字符串化（Stringify）

维护 enum value 与 enum name string 之间的映射往往比较麻烦。

在 TS 中，当我们定义一个 enum 时，JS 实际上会创建两份映射：enum name -> enum value 与 enum value -> enum name。这样我们就能通过 `E[e]` 获取枚举值对应的名字。
WARPO 也支持这一 TS 小技巧，用于从枚举值获取其名字。

```ts
enum E {
  E0,
  E1,
  E2,
}
function foo(e: E): void {
  trace(E[e]);
}

function _start(): void {
  trace(E[E.E0]); // TRACE: E0
  foo(E.E2); // TRACE: E2
}
```
