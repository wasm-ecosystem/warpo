# How to Contribution

## build

### C++

```bash
git clone git@github.com:wasm-ecosystem/warpo.git
cd warpo
git submodule update --init --depth=1
cmake -S . -B build
cmake --build build --parallel
```

### AS

```bash
npm ci
cd assemblyscript
npm ci
npm run build
cd ..
npm run watch
```

## Test

```bash
./build/passes/warpo_passes_test
./build/support/warpo_support_test
node tests/snapshot.mjs
tests/e2e/bootstrap/test.sh
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
