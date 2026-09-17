// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { Array } from "./array";
import { ReadonlyArray } from "./readonlyarray";

export class TemplateStringsArray implements ReadonlyArray<string> {
  [key: i32]: string;

  private values: Array<string>;
  readonly raw: ReadonlyArray<string>;

  constructor(values: Array<string>, raw: ReadonlyArray<string>) {
    this.values = values;
    this.raw = raw;
  }


  @operator("[]") private __get(index: i32): string {
    return this.values[index];
  }


  @unsafe @operator("{}") private __uget(index: i32): string {
    return unchecked(this.values[index]);
  }

  get length(): i32 {
    return this.values.length;
  }

  at(index: i32): string {
    return this.values.at(index);
  }

  findIndex(fn: (value: string, index: i32, array: ReadonlyArray<string>) => bool): i32 {
    return this.values.findIndex(fn);
  }

  findLastIndex(fn: (value: string, index: i32, array: ReadonlyArray<string>) => bool): i32 {
    return this.values.findLastIndex(fn);
  }

  includes(value: string, fromIndex: i32 = 0): bool {
    return this.values.includes(value, fromIndex);
  }

  indexOf(value: string, fromIndex: i32 = 0): i32 {
    return this.values.indexOf(value, fromIndex);
  }

  lastIndexOf(value: string, fromIndex: i32 = i32.MAX_VALUE): i32 {
    return this.values.lastIndexOf(value, fromIndex);
  }

  forEach(fn: (value: string, index: i32, array: ReadonlyArray<string>) => void): void {
    this.values.forEach(fn);
  }

  map<U>(fn: (value: string, index: i32, array: ReadonlyArray<string>) => U): Array<U> {
    return this.values.map<U>(fn);
  }

  filter(fn: (value: string, index: i32, array: ReadonlyArray<string>) => bool): Array<string> {
    return this.values.filter(fn);
  }

  reduce<U>(
    fn: (previousValue: U, currentValue: string, currentIndex: i32, array: ReadonlyArray<string>) => U,
    initialValue: U
  ): U {
    return this.values.reduce<U>(fn, initialValue);
  }

  reduceRight<U>(
    fn: (previousValue: U, currentValue: string, currentIndex: i32, array: ReadonlyArray<string>) => U,
    initialValue: U
  ): U {
    return this.values.reduceRight<U>(fn, initialValue);
  }

  every(fn: (value: string, index: i32, array: ReadonlyArray<string>) => bool): bool {
    return this.values.every(fn);
  }

  some(fn: (value: string, index: i32, array: ReadonlyArray<string>) => bool): bool {
    return this.values.some(fn);
  }

  concat(other: Array<string>): Array<string> {
    return this.values.concat(other);
  }

  slice(start: i32 = 0, end: i32 = i32.MAX_VALUE): Array<string> {
    return this.values.slice(start, end);
  }

  join(separator: string = ","): string {
    return this.values.join(separator);
  }

  flat(): string {
    return this.values.flat();
  }

  toString(): string {
    return this.values.toString();
  }

  [Symbol.iterator](): Iterator<string> {
    return this.values[Symbol.iterator]();
  }
}
