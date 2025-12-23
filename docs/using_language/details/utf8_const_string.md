# utf8 const string

<p style="display: flex; gap: 10px;">
  <img src="/version/2.2.4.svg" alt="2.2.4" />
  <img src="/stability/rc.svg" alt="rc" />
</p>

## Basic Usage

In WARPO, string will be encoded to utf16 to ensure the same behavior with TS. But it is also a common requirement to use string in FFI.
In low level WebAssembly runtime, the native string most likely is utf8 encoded, for example rust or C++.

To use this feature, explicit import `warpo:utf8_const_str` from

```ts
import * as utf8 from "warpo/utf8/const_str";

let s = utf8.build("abcdef");
assert(s.size == 6);
assert(s.toString() == "abcdef");
```

## upgrade guideline from [assemblyscript-transform](https://github.com/wasm-ecosystem/assemblyscript-transform)

1. Removing transform script in command line options `--transform ./node_modules/@schleifner/assemblyscript-transform/dist/transformBuildUtf8ConstStr.mjs`.
2. When you never go back to assemblyscript, following the example code to replace the import statements.
3. When you want to keep flexibility between assemblyscript and warpo, creating shim and adding `create.ts` in project root.

   ```ts
   // lib/utf8-shim/as/utf8ConstStr.ts
   import * as utf8 from "warpo/utf8/const_str";
   export { utf8 };
   ```

   ```ts
   // create.ts
   import * as resolveModule from "warpo/create/resolveModule";
   import { __dirname } from "warpo/create";

   resolveModule.onModuleResolve((task: resolveModule.ModuleResolve): void => {
     if (task.packageName === "@schleifner/assemblyscript-transform") {
       task.setPackagePath(__dirname + "/lib/utf8-shim");
     }
   });
   ```
