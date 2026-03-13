## quick start

config `tsconfig.json` like below.

```json
{
  "extends": "warpo/tsconfig-warpo.json",
  "include": ["./**/*.ts"]
}
```

write ts code in `assembly/index.ts`

```ts
export function add(a: i32, b: i32): i32 {
  return a + b;
}
```

build and test with the recommended project workflow:

```bash
npx warpo -h
npx warpo build
npx warpo build --target debug
npx warpo build --target release
npx warpo test
```

For a detailed introduction to the latest CLI workflow, see [build and test with WARPO CLI](/en/using_compiler/build_and_test).

The legacy direct compiler invocation is still available:

```bash
npx warpo assembly/index.ts -o build/debug.wat
```

## debug build

use `--debug` to generate debug symbol.
For debugger developers, refer to [detailed debug symbol design](/tech/debug_symbol/index.md)
