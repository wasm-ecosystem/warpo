## quick start

config `tsconfig.json` like below.

```json
{
  "extends": "warpo/tsconfig-warpo.json",
  "include": ["./**/*.ts"]
}
```

write ts code in `assembly/index.ts`

```bash
export function add(a: i32, b: i32): i32 {
  return a + b;
}
```

```bash
node node_modules/.bin/warpo assembly/index.ts -o build/debug.wat
node node_modules/.bin/warpo assembly/index.ts -o build/release.wasm --optimizeLevel 3 --shrinkLevel 2
npx warpo assembly/index.ts -o build/debug.wat # simplify with npx
npx warpo -h # for more cli options
```

## debug build

use `--debug` to generate debug symbol.
For debugger developers, refer to [detailed debug symbol design](../tech/debug_symbol/index.md)
