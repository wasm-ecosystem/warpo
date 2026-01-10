export function meaning(): i32 {
  return 42;
}

export function _start(): void {
  assert(meaning() == 42);
  trace("asconfig ready");
}
