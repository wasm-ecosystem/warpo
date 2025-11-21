# How to Contribution

## repo structure

### for dev

- include: header files exposed to other components.
- tests: e2e test cases and scripts.

### major logic

- assemblyscript: code base of assemblyscript, modify from https://github.com/AssemblyScript/assemblyscript/.
- assemblyscript_extension: experimental functions for AS.
- common: function related common code, most of them are cli options.
- frontend: assemblyscript frontend compiler.
- passes: additional optimization passes.
  - passes/GC: lowering passes for GC related operation.
  - passes/helper: compilation and optimization related algorithm.
  - unittests: useful functions for ut.
- support: wasm unrelated common code, contains algorithm, ADT, os abstract layer...

## build

### C++

```bash
git clone git@github.com:wasm-ecosystem/warpo.git
cd warpo

cd assemblyscript
npm ci
cd -
npm ci

cmake -S . -B build
cmake --build build --parallel
```

## Test

```bash
npm run test
```

## subtree management

### initialize

```bash
git remote add binaryen-origin https://github.com/WebAssembly/binaryen.git
git config --local remote.binaryen-origin.fetch +refs/heads/main:refs/remotes/binaryen-origin/main
git config remote.binaryen-origin.tagopt --no-tags

# git remote add binaryen-fork https://github.com/<fork_org>/binaryen.git
# git config remote.binaryen-fork.tagopt --no-tags

git remote add assemblyscript-origin https://github.com/AssemblyScript/assemblyscript.git
git config --local remote.assemblyscript-origin.fetch +refs/heads/main:refs/remotes/assemblyscript-origin/main
git config remote.assemblyscript-origin.tagopt --no-tags

# git remote add binaryen-fork https://github.com/<fork_org>/assemblyscript.git
# git config remote.assemblyscript-fork.tagopt --no-tags

git fetch -p --all
```

### update

```bash
# update the whole subtree
git subtree pull --prefix third_party/binaryen https://github.com/WebAssembly/binaryen.git main --squash
git subtree pull --prefix assemblyscript https://github.com/AssemblyScript/assemblyscript.git main --squash
# update special PR
git -C ../assemblyscript diff main ./src | git am -3 --directory=assemblyscript
```

### backport

```bash
git subtree split --prefix=third_party/binaryen -b binaryen-backport-1
git checkout -b binaryen-backport binaryen-origin/main
git cherry-pick binaryen-backport-1~1..binaryen-backport-1
git checkout main # back to current branch
git branch -D binaryen-backport-1
git push binaryen-fork binaryen-backport -u
```

## How to Extend Assemblyscript Language Features

### Builtin Functions

1. In `assemblyscript_extension/src/builtins.ts`, add

   ```ts
   namespace ExtNames {
     export const {{name}} = "~lib/{{filename}}/{{function_name}}";
   }

   function builtin_{{name}}(ctx: BuiltinFunctionContext): ExpressionRef {
     // ...
   }
   builtinFunctions.set(ExtNames.{{name}}, builtin_{{name}});
   ```

2. In `assemblyscript_extension/std/`, create `{{filename}}.ts` and declare function with `@builtin`
3. In `assemblyscript_extension/index.d.ts`, declare function manually.

### Builtin Class

1. In `assemblyscript_extension/std/`, create `{{filename}}.ts` and implement class.
2. In `assemblyscript_extension/index.d.ts`, declare class manually.
