
@final export class IteratorResult<T> {
  constructor(public value: T) {}


  @inline
  get done(): boolean {
    return 0 == changetype<usize>(this);
  }
  static done<T>(): IteratorResult<T> {
    return changetype<IteratorResult<T>>(0);
  }
  static fromValue<T>(value: T): IteratorResult<T> {
    return new IteratorResult<T>(value);
  }
}

export interface Iterator<T> {
  next(): IteratorResult<T>;
}

export interface Iterable<T> {
  [Symbol.iterator](): Iterator<T>;
}
