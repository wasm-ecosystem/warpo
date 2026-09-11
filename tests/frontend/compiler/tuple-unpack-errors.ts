export function missingInitializer(): void {
  let [a, b]: [i32, i32];
}

function noValue(): void {}

export function nonTupleInitializer(): void {
  let [a, b] = 1;
}

export function tupleLengthMismatch(): void {
  let [a, b]: [i32] = [1];
}

export function voidInitializer(): void {
  let [a] = noValue();
}

export function duplicateBindings(): void {
  var [a, a]: [i32, i32] = [1, 2];
}
