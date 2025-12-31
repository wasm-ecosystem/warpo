export function set_iterator_add(): void {
  const s = new Set<i32>();
  s.add(1).add(3).add(2);
  const it = s[Symbol.iterator]();
  assert(it.next().value == 1);
  assert(it.next().value == 3);
  s.add(4);
  assert(it.next().value == 2);
  assert(it.next().value == 4);
  assert(it.next().done);
}
set_iterator_add();

export function set_iterator_del(): void {
  const s = new Set<i32>();
  s.add(1).add(3).add(2);
  const it = s[Symbol.iterator]();
  assert(it.next().value == 1);
  assert(it.next().value == 3);
  s.delete(2);
  assert(it.next().done);
}
set_iterator_del();

export function set_iterator_reassign(): void {
  let s = new Set<i32>();
  s.add(1).add(3).add(2);
  const it = s[Symbol.iterator]();
  s = new Set<i32>();
  assert(it.next().value == 1);
  assert(it.next().value == 3);
  assert(it.next().value == 2);
  assert(it.next().done);
}
set_iterator_reassign();

export function set_iterator_clear(): void {
  const s = new Set<i32>();
  s.add(1).add(3).add(2);
  const it = s[Symbol.iterator]();
  s.clear();
  assert(it.next().done);
}
set_iterator_clear();
