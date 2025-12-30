export function increase_arr_length(): void {
  const arr: Array<i32> = [1, 2, 3];
  const it = arr[Symbol.iterator]();
  assert(it.next().value == 1);
  assert(it.next().value == 2);
  assert(it.next().value == 3);
  arr.push(4);
  assert(it.next().value == 4);
  assert(it.next().done);
}
increase_arr_length();

export function reduce_arr_length(): void {
  const arr: Array<i32> = [1, 2, 3, 4];
  const it = arr[Symbol.iterator]();
  assert(it.next().value == 1);
  arr.splice(1, 1);
  assert(it.next().value == 3);
  assert(it.next().value == 4);
  assert(it.next().done);
}
reduce_arr_length();

export function replace_arr(): void {
  let arr: Array<i32> = [1, 2, 3];
  const it = arr[Symbol.iterator]();
  assert(it.next().value == 1);
  arr = [2, 3, 4];
  assert(it.next().value == 2);
  assert(it.next().value == 3);
}
replace_arr();
