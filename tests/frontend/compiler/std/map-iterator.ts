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

export function map_iterator_rehash_after_delete(): void {
  const m = new Map<i32, i32>();
  m.set(1, 10).set(2, 20).set(3, 30).set(4, 40);
  const it = m[Symbol.iterator]();
  let kv = it.next().value;
  assert(kv[0] == 1 && kv[1] == 10);
  m.delete(1);
  m.set(5, 50);
  kv = it.next().value;
  assert(kv[0] == 2 && kv[1] == 20);
  kv = it.next().value;
  assert(kv[0] == 3 && kv[1] == 30);
  kv = it.next().value;
  assert(kv[0] == 4 && kv[1] == 40);
  kv = it.next().value;
  assert(kv[0] == 5 && kv[1] == 50);
  assert(it.next().done);
}
map_iterator_rehash_after_delete();

export function map_iterator_multiple_rehashes(): void {
  const m = new Map<i32, i32>();
  m.set(1, 10).set(2, 20).set(3, 30).set(4, 40);
  const it = m[Symbol.iterator]();
  let kv = it.next().value;
  assert(kv[0] == 1 && kv[1] == 10);
  m.delete(1);
  m.set(5, 50);
  m.delete(2);
  m.set(6, 60);
  __collect();
  kv = it.next().value;
  assert(kv[0] == 3 && kv[1] == 30);
  kv = it.next().value;
  assert(kv[0] == 4 && kv[1] == 40);
  kv = it.next().value;
  assert(kv[0] == 5 && kv[1] == 50);
  kv = it.next().value;
  assert(kv[0] == 6 && kv[1] == 60);
  assert(it.next().done);
}
map_iterator_multiple_rehashes();

export function map_iterator_multiple_iterators(): void {
  const m = new Map<i32, i32>();
  m.set(1, 10).set(2, 20).set(3, 30).set(4, 40);
  const first = m[Symbol.iterator]();
  const second = m[Symbol.iterator]();
  assert(first.next().value[0] == 1);
  assert(first.next().value[0] == 2);
  assert(second.next().value[0] == 1);
  m.delete(1);
  m.set(5, 50);
  assert(first.next().value[0] == 3);
  assert(second.next().value[0] == 2);
}
map_iterator_multiple_iterators();

export function map_iterator_delete_and_reinsert(): void {
  const m = new Map<i32, i32>();
  m.set(1, 10).set(2, 20).set(3, 30);
  const it = m[Symbol.iterator]();
  let kv = it.next().value;
  assert(kv[0] == 1 && kv[1] == 10);
  m.delete(2);
  m.set(2, 22);
  kv = it.next().value;
  assert(kv[0] == 3 && kv[1] == 30);
  kv = it.next().value;
  assert(kv[0] == 2 && kv[1] == 22);
  assert(it.next().done);
}
map_iterator_delete_and_reinsert();

class MapIteratorBox {
  constructor(readonly value: i32) {}
}

export function map_iterator_managed_entries(): void {
  const m = new Map<MapIteratorBox, MapIteratorBox>();
  const keys = [new MapIteratorBox(1), new MapIteratorBox(2), new MapIteratorBox(3), new MapIteratorBox(4)];
  m.set(keys[0], new MapIteratorBox(10));
  m.set(keys[1], new MapIteratorBox(20));
  m.set(keys[2], new MapIteratorBox(30));
  m.set(keys[3], new MapIteratorBox(40));
  const it = m[Symbol.iterator]();
  let kv = it.next().value;
  assert(kv[0].value == 1 && kv[1].value == 10);
  m.delete(keys[0]);
  m.set(new MapIteratorBox(5), new MapIteratorBox(50));
  __collect();
  kv = it.next().value;
  assert(kv[0].value == 2 && kv[1].value == 20);
  kv = it.next().value;
  assert(kv[0].value == 3 && kv[1].value == 30);
  kv = it.next().value;
  assert(kv[0].value == 4 && kv[1].value == 40);
  kv = it.next().value;
  assert(kv[0].value == 5 && kv[1].value == 50);
  assert(it.next().done);
}
map_iterator_managed_entries();

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

export function map_iterator_clear_and_add(): void {
  const m = new Map<i32, i32>();
  m.set(1, 10).set(2, 20);
  const it = m[Symbol.iterator]();
  let kv = it.next().value;
  assert(kv[0] == 1 && kv[1] == 10);
  m.clear();
  m.set(3, 30);
  kv = it.next().value;
  assert(kv[0] == 3 && kv[1] == 30);
  assert(it.next().done);
}
map_iterator_clear_and_add();
