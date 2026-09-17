# Tagged template literals

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

WARPO 的 tagged template 类型行为与 TypeScript 更一致：

1. **类型化的 tag 参数。** tag 函数接收的模板部分类型是 `TemplateStringsArray`，不再是 `string[]`。
2. **只读的模板部分。** `TemplateStringsArray` 实现了 `ReadonlyArray<string>` 接口。
3. **支持泛型 tag。** 泛型 tag 函数可以从模板和插值表达式中推导类型参数。

## Tag 参数

模板数组参数固定为 `TemplateStringsArray`；插值表达式的值会作为普通参数传入。旧的 `tag(parts: string[], ...)` 形式已移除：

```ts
function tag(parts: TemplateStringsArray, value: i32): string {
  return parts[0] + value.toString() + parts[1];
}

assert(tag`Count: ${123}` == "Count: 123");
```

## `TemplateStringsArray` 与 `ReadonlyArray`

`TemplateStringsArray` 实现了 `ReadonlyArray<string>`。因此，tag 函数可以对模板的字面量部分使用只读集合 API，并且它的 `raw` 属性也是 `ReadonlyArray<string>`：

```ts
function tag(parts: TemplateStringsArray): string {
  return parts.join("|") + ":" + parts.raw.join("|");
}

assert(tag`a${1}b` == "a|b:a|b");
```

## Generic tag

tagged template 可以推导泛型参数。虽然模板数组是由模板字面量语法提供的，而不是普通参数表达式，但它仍然会参与泛型推导：

```ts
function tagGeneric<T, U>(strings: T, value: U): string {
  assert(nameof<T>() == nameof<TemplateStringsArray>());
  assert(nameof<U>() == nameof<i32>());
  return "generic";
}

let count: i32 = 123;
assert(tagGeneric`Count: ${count}` == "generic");
```

## 模板数组的对象标识

同一个源码位置的 `TemplateStringsArray` 只分配一次；再次执行该位置时会复用同一个对象。不同源码位置对应不同的模板数组。

```ts
function identity(parts: TemplateStringsArray): TemplateStringsArray {
  return parts;
}

let first: TemplateStringsArray | null = null;
for (let i: i32 = 0; i < 2; ++i) {
  let current = identity`identity`;
  if (first != null) assert(first === current);
  first = current;
}
```
