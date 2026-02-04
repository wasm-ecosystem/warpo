/// <reference path="../std/index.d.ts" />

declare module "rt/index" {
  // allocate new object with size and rtid
  function __new(size: usize, id: u32): usize;
  // re-allocate a object
  function __renew(ptr: usize, size: usize): usize;
  // insert write barrier (only useful for incremental runtime)
  function __link(parentPtr: usize, childPtr: usize, expectMultiple: bool): void;
  // trigger full GC manually
  function __collect(): void;
  // pin an object to prevent being garbage collected
  function __pin(ptr: usize): usize;
  // cancel the pin operation
  function __unpin(ptr: usize): void;
}

declare module "warpo/utf8/const_str" {
  class ConstStr {
    toString(): string;
    get addr(): usize;
    get size(): u32;
  }
  function build(s: string): ConstStr;
}

declare module "warpo/test" {
  export class MockFn {
    constructor(originalFunctionIndex: u32, mockFunctionIndex: u32);
    get calls(): u32;
  }

  export class Value<T> {
    get not(): this;

    isNull(): this;
    notNull(): this;

    equal(checkValue: T): this;
    notEqual(checkValue: T): this;

    greaterThan(checkValue: T): this;
    greaterThanOrEqual(checkValue: T): this;
    lessThan(checkValue: T): this;
    lessThanOrEqual(checkValue: T): this;

    closeTo(checkValue: T, delta: number): this;

    isa<ExpectType>(): this;

    isExactly<ExpectType>(): this;
  }

  /**
   *  describe a test group
   * @param description common description of each test inside
   * @param testsFunction can call multi-time test
   */
  export function describe(description: string, testsFunction: () => void): void;

  /**
   *  run a test
   * @param name test name
   * @param testFunction main function of test
   */
  export function test(name: string, testFunction: () => void): void;

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
  export function beforeEach(func: () => void): void;

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
  export function afterEach(func: () => void): void;

  /**
   *  mock some function
   * @param originalFunction function you want to mock
   * @param mockFunction the new function.
   * @returns MockFn with call information (e.g. via its `calls` property)
   */
  export function mock<T extends Function>(originalFunction: T, mockFunction: T): MockFn;

  /**
   * unmock this function, can only be used in mocked function
   */
  export function unmock<T extends Function>(originalFunction: T): void;

  /**
   * remock this function, can only be used in mocked function. Pair of {unmock}
   */
  export function remock<T extends Function>(originalFunction: T): void;

  export function expect<T>(value: T): Value<T>;
}
