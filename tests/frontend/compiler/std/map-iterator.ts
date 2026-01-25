export function map_iterator_add(): void {
  const m = new Map<i32, i32>();
  m.set(1, 10).set(3, 30).set(2, 20);
  const it = m[Symbol.iterator]();
  let kv = it.next().value;
  assert(kv[0] == 1 && kv[1] == 10);
  kv = it.next().value;
  assert(kv[0] == 3 && kv[1] == 30);
  m.set(4, 40);
  kv = it.next().value;
  assert(kv[0] == 2 && kv[1] == 20);
  kv = it.next().value;
  assert(kv[0] == 4 && kv[1] == 40);
  assert(it.next().done);
}
map_iterator_add();

export function map_iterator_del(): void {
  const m = new Map<i32, i32>();
  m.set(1, 10).set(3, 30).set(2, 20);
  const it = m[Symbol.iterator]();
  let kv = it.next().value;
  assert(kv[0] == 1 && kv[1] == 10);
  kv = it.next().value;
  assert(kv[0] == 3 && kv[1] == 30);
  m.delete(2);
  assert(it.next().done);
}
map_iterator_del();

export function map_iterator_reassign(): void {
  let m = new Map<i32, i32>();
  m.set(1, 10).set(3, 30).set(2, 20);
  const it = m[Symbol.iterator]();
  m = new Map<i32, i32>();
  let kv = it.next().value;
  assert(kv[0] == 1 && kv[1] == 10);
  kv = it.next().value;
  assert(kv[0] == 3 && kv[1] == 30);
  kv = it.next().value;
  assert(kv[0] == 2 && kv[1] == 20);
  assert(it.next().done);
}
map_iterator_reassign();

export function map_iterator_clear(): void {
  const m = new Map<i32, i32>();
  m.set(1, 10).set(3, 30).set(2, 20);
  const it = m[Symbol.iterator]();
  m.clear();
  assert(it.next().done);
}
map_iterator_clear();
