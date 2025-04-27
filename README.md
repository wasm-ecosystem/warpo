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

### initialize

```bash
git remote add binaryen-origin https://github.com/WebAssembly/binaryen.git
git config --local remote.binaryen-origin.fetch +refs/heads/main:refs/remotes/binaryen-origin/main
git remote add binaryen-fork https://github.com/<fork_org>/binaryen.git
git fetch -p --all
```

### update

TODO

### backport

```bash
git subtree split --prefix=third_party/binaryen -b binaryen-backport-1
git checkout -b binaryen-backport binaryen-origin/main
git cherry-pick binaryen-backport-1~1..binaryen-backport-1
git checkout main # back to current branch
git branch -D binaryen-backport-1
git push binaryen-fork binaryen-backport -u
```
