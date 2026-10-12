# Tagged template literals

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

WARPO's tagged template types are closer to TypeScript:

1. **Typed tag argument.** A tag receives its template parts as `TemplateStringsArray`, never as `string[]`.
2. **Readonly template parts.** `TemplateStringsArray` implements `ReadonlyArray<string>`.
3. **Generic tags.** Generic tag functions can infer their type parameters from the template and its interpolated values.

## Tag argument

The template-array argument is always `TemplateStringsArray`; interpolated values follow it as normal arguments. The old `tag(parts: string[], ...)` form has been removed:

```ts
function tag(parts: TemplateStringsArray, value: i32): string {
  return parts[0] + value.toString() + parts[1];
}

assert(tag`Count: ${123}` == "Count: 123");
```

## `TemplateStringsArray` and `ReadonlyArray`

`TemplateStringsArray` implements `ReadonlyArray<string>`. A tagged-template function can use the read-only collection APIs for its literal parts, and its `raw` property is also a `ReadonlyArray<string>`:

```ts
function tag(parts: TemplateStringsArray): string {
  return parts.join("|") + ":" + parts.raw.join("|");
}

assert(tag`a${1}b` == "a|b:a|b");
```

## Generic tags

Generic type parameters can be inferred for tagged templates. The template array is included in inference even though it is supplied by the template-literal syntax rather than written as a normal argument:

```ts
function tagGeneric<T, U>(strings: T, value: U): string {
  assert(nameof<T>() == nameof<TemplateStringsArray>());
  assert(nameof<U>() == nameof<i32>());
  return "generic";
}

let count: i32 = 123;
assert(tagGeneric`Count: ${count}` == "generic");
```

## Template array identity

The `TemplateStringsArray` for a source site is allocated once and reused when that site is evaluated again. Different source sites have different template arrays.

```ts
function identity(parts: TemplateStringsArray): TemplateStringsArray {
  return parts;
}

let first: TemplateStringsArray | null = null;
for (let i = 0; i < 2; ++i) {
  let current = identity`identity`;
  if (first != null) assert(first === current);
  first = current;
}
```
