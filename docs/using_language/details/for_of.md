# `for ... of`

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

`for...of` statement rely on [iterator](/using_language/details/iterator).

During compilation, the for...of statement is expanded using an iterator.

```ts
for (const value of myIterable) {
}
```

is equivalent to

```ts
for (
  let it: MyIterator = myIterable[Symbol.iterator](), ret: IteratorResult<string> = it.next();
  !ret.done;
  ret = it.next()
) {
  const value = it.value;
}
```
