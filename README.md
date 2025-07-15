# WARPO

wasm optimizer designed for warp

## dependencies

- [binaryen](https://github.com/WebAssembly/binaryen)
- [fmt](https://github.com/fmtlib/fmt)
- [argparse](http://github.com/p-ranav/argparse)

## Interesting TODO Topic

1. Should assign const 0 to local sync to shadowstack?
2. How to compare the differences between two tree?

## Manage GIT subtree

WARPO use git subtree to manage major dependencies `AssemblyScript` and `binaryen` because we need to modify the code in these repo and third party will increase the complexity when working cross multiple repo.

### about upstream

WARPO could be the first step to develop some interesting optimizations based on AssemblyScript and binaryen. But I still prefer to upstream changing to open source communities instead of creating PR for WARPO.

when not to create PR and to upstream:

- It is positive in most cases and is applicable to most scenarios.

when to create PR and not to upstream:

- For binaryen optimization, the change is limited in AS frontend.
- For binaryen optimization, the change is limited in WARP backend.
- For AS, the change is depended on WARPO to lower.
- The change is aimed to special case in CDC.
- The change is based on special assumptions in CDC.

when to create PR and upstream:

- The benefit of changing is big enough and expected significant review time during upstream.

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
