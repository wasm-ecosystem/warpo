import { Value } from "./expect";
import {
  afterEachImpl,
  beforeEachImpl,
  describeImpl,
  mockImpl,
  remockImpl,
  testImpl,
  unmockImpl,
} from "./implement";
import { MockFn } from "./mockInstrument";
export { MockFn } from "./mockInstrument";

/**
 *  describe a test group
 * @param description common description of each test inside
 * @param testsFunction can call multi-time test
 */
export function describe(description: string, testsFunction: () => void): void {
  describeImpl(description, testsFunction);
}

/**
 *  run a test
 * @param name test name
 * @param testFunction main function of test
 */
export function test(name: string, testFunction: () => void): void {
  testImpl(name, testFunction);
}

/**
 * setup function before each test
 * must be called inside describe block
 * @example
 * ```ts
 * describe("test group", () => {
 *  beforeEach(() => {
 *    // setup code
 *  });
 *  test("test case", () => {
 *    // test code
 *  });
 * });
 */
export function beforeEach(func: () => void): void {
  beforeEachImpl(func);
}

/**
 * teardown function after each test
 * must be called inside describe block
 * @example
 * ```ts
 * describe("test group", () => {
 *  afterEach(() => {
 *    // teardown code
 *  });
 *  test("test case", () => {
 *    // test code
 *  });
 * });
 */
export function afterEach(func: () => void): void {
  afterEachImpl(func);
}

/**
 *  mock some function
 * @param originalFunction function you want to mock
 * @param mockFunction the new function.
 * @returns Mock Status { callTime : u32}
 */
export function mock<T extends Function>(
  originalFunction: T,
  mockFunction: T,
): MockFn {
  return mockImpl<T>(originalFunction, mockFunction);
}
/**
 * unmock this function, can only be used in mocked function
 */
export function unmock<T extends Function>(originalFunction: T): void {
  unmockImpl(originalFunction);
}
/**
 * remock this function, can only be used in mocked function. Pair of {unmock}
 */
export function remock<T extends Function>(originalFunction: T): void {
  remockImpl(originalFunction);
}

export function expect<T>(value: T): Value<T> {
  return new Value<T>(value);
}
