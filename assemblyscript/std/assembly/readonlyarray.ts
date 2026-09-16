// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { Array } from "./array";

export interface ReadonlyArray<T> extends Iterable<T> {
  [key: i32]: T;
  readonly length: i32;
  at(index: i32): T;
  findIndex(fn: (value: T, index: i32, array: ReadonlyArray<T>) => bool): i32;
  findLastIndex(fn: (value: T, index: i32, array: ReadonlyArray<T>) => bool): i32;
  includes(value: T, fromIndex: i32): bool;
  indexOf(value: T, fromIndex: i32): i32;
  lastIndexOf(value: T, fromIndex: i32): i32;
  forEach(fn: (value: T, index: i32, array: ReadonlyArray<T>) => void): void;
  filter(fn: (value: T, index: i32, array: ReadonlyArray<T>) => bool): Array<T>;
  every(fn: (value: T, index: i32, array: ReadonlyArray<T>) => bool): bool;
  some(fn: (value: T, index: i32, array: ReadonlyArray<T>) => bool): bool;
  concat(other: Array<T>): Array<T>;
  slice(start: i32, end: i32): Array<T>;
  join(separator: string): string;
  flat(): T;
  toString(): string;
}
