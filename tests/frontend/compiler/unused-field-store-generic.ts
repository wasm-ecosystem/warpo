class Base<T> {
  forward!: T;
  reverse!: T;
  forwardUnused!: T;
  reverseUnused!: T;
}

class Derived<T> extends Base<T> {
  forward!: T;
  reverse!: T;
  forwardUnused!: T;
  reverseUnused!: T;
}

function writeBaseForward<T>(box: Base<T>, value: T): void {
  box.forward = value;
}

function readDerivedForward<T>(box: Derived<T>): T {
  return box.forward;
}

function writeDerivedReverse<T>(box: Derived<T>, value: T): void {
  box.reverse = value;
}

function readBaseReverse<T>(box: Base<T>): T {
  return box.reverse;
}

function writeBaseUnused<T>(box: Base<T>, value: T): void {
  box.forwardUnused = value;
}

function writeDerivedUnused<T>(box: Derived<T>, value: T): void {
  box.reverseUnused = value;
}

export function baseToDerived(box: Derived<i32>, value: i32): i32 {
  writeBaseForward<i32>(box, value);
  return readDerivedForward<i32>(box);
}

export function derivedToBase(box: Derived<i32>, value: i32): i32 {
  writeDerivedReverse<i32>(box, value);
  return readBaseReverse<i32>(box);
}

export function unusedBaseWrite(box: Derived<i32>, value: i32): void {
  writeBaseUnused<i32>(box, value);
}

export function unusedDerivedWrite(box: Derived<i32>, value: i32): void {
  writeDerivedUnused<i32>(box, value);
}
