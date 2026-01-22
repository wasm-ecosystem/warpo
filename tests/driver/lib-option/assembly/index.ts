///<reference path="./index.d.ts" />

export function _start(): void {
  assert(import_lib.sum(lib1.f(), lib2.f()) == 1);
  trace(`lib option success`);
}
