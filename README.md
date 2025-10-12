# WARPO

next generation assemblyscript compiler

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

## language

- [Assemblyscript](https://www.assemblyscript.org/)
- warpo new features: WIP
- [warpo optimization](https://wasm-ecosystem.github.io/warpo/)

## developer

see [CONTRIBUTING](./CONTRIBUTING.md)
