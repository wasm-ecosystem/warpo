// Captured reads need a getter, but raw call_indirect does not emit a setter.
// Keep helper imports until later passes prove them unused.
// FFI callbacks without an environment setter are a subset of this case.
function use(value: string): void {}

export function _start(): void {
  let u = "abc";
  const callback: () => void = () => {
    use(u);
  };
  const functionIndex: i32 = changetype<i32>(callback.index);
  call_indirect<void>(functionIndex);
}
