# Enum

<p style="display: flex; gap: 10px;">
  <img src="/version/2.2.3.svg" alt="2.2.3" />
  <img src="/stability/stable.svg" alt="2.2.3" />
</p>

## Basic Usage

Like TS, you can use `enum` to define enumeration values in WARPO.

```ts
enum Direction {
  Up,
  Down,
  Left,
  Right,
}
```

- enums with values

```ts
enum HttpStatus {
  Ok = 200,
  NotFound = 404,
  ServerError = 500,
}
```

- WARPO does not support string enums

```ts
enum Color {
  Red = "RED",
  Green = "GREEN",
  Blue = "BLUE",
}
```

- using enums

```ts
let direction: Direction = Direction.Up;
let status: HttpStatus = HttpStatus.Ok;
```

## Stringify

It is hard to maintain the mapping between enum value and enum name string.

In TS, when we defined an enum, actually 2 mapping will be created in JS, enum name to enum value and enum value to enum name. Then we can get the enum name by `E[e]`.
WARPO also supports this TS trick to get the name of enum value.

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
