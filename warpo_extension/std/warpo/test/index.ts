// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { Value } from "./expect";
import { afterEachImpl, beforeEachImpl, describeImpl, mockImpl, remockImpl, testImpl, unmockImpl } from "./implement";
import { MockFn } from "./mockInstrument";
export { MockFn } from "./mockInstrument";

export function describe(description: string, testsFunction: () => void): void {
  describeImpl(description, testsFunction);
}

export function test(name: string, testFunction: () => void): void {
  testImpl(name, testFunction);
}

export function beforeEach(func: () => void): void {
  beforeEachImpl(func);
}

export function afterEach(func: () => void): void {
  afterEachImpl(func);
}

export function mock<T extends Function>(originalFunction: T, mockFunction: T): MockFn {
  return mockImpl<T>(originalFunction, mockFunction);
}

export function unmock<T extends Function>(originalFunction: T): void {
  unmockImpl(originalFunction);
}

export function remock<T extends Function>(originalFunction: T): void {
  remockImpl(originalFunction);
}

export function expect<T>(value: T): Value<T> {
  return new Value<T>(value);
}
