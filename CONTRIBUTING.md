# How to Contribution

## repo structure

### for dev

- include: header files exposed to other components.
- tests: e2e test cases and scripts.

### major logic

- assemblyscript: code base of assemblyscript, modify from https://github.com/AssemblyScript/assemblyscript/.
- warpo_extension: new functions for AS.
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
npm ci
cmake -S . -B build
cmake --build build --parallel
```

## Test

```bash
npm run test
```

WARPO relies on snapshot test. All of them can be updated by `-u` command line option.

## subtree management

### initialize

```bash
git remote add binaryen-origin https://github.com/WebAssembly/binaryen.git
git config --local remote.binaryen-origin.fetch +refs/heads/main:refs/remotes/binaryen-origin/main
git config remote.binaryen-origin.tagopt --no-tags

# git remote add binaryen-fork https://github.com/<fork_org>/binaryen.git
# git config remote.binaryen-fork.tagopt --no-tags

git fetch -p --all
```

### update

Don't use normal squash merge after bump the subtree!

It may disrupt subtree history tracking and make future updates to the subtree impossible.
You can use push after all CI passed to update main branch and close the PR. `git push origin bump:main`

```bash
# update the whole subtree
git subtree pull --prefix third_party/binaryen https://github.com/WebAssembly/binaryen.git main --squash
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

## How to Extend AssemblyScript Language Features

### Builtin Functions

1. In `warpo_extension/src/builtins.ts`, add

   ```ts
   namespace ExtNames {
     export const {{name}} = "~lib/{{filename}}/{{function_name}}";
   }

   function builtin_{{name}}(ctx: BuiltinFunctionContext): ExpressionRef {
     // ...
   }
   builtinFunctions.set(ExtNames.{{name}}, builtin_{{name}});
   ```

2. In `warpo_extension/std/`, create `{{filename}}.ts` and declare function with `@builtin`
3. In `warpo_extension/index.d.ts`, declare function manually.

### Builtin Class

1. In `warpo_extension/std/`, create `{{filename}}.ts` and implement class.
2. In `warpo_extension/index.d.ts`, declare class manually.
