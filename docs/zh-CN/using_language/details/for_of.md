# `for ... of`

<p style="display: flex; gap: 10px;">
	<img src="/version/2.3.0.svg" alt="2.3.0" />
	<img src="/stability/experimental.svg" alt="experimental" />
</p>

`for...of` 语句依赖 [iterator](/zh-CN/using_language/details/iterator)。

编译期间，for...of 会使用 iterator 展开（desugar）。

```ts
for (const value of myIterable) {
}
```

等价于：

```ts
for (
  let it: MyIterator = myIterable[Symbol.iterator](), ret: IteratorResult<string> = it.next();
  !ret.done;
  ret = it.next()
) {
  const value = it.value;
}
```
