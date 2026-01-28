import { describe, expect, mock, remock, test, unmock } from "../../../../warpo_extension/std/warpo/test";
import { add, callee, caller, incr, MockClass, call_incr } from "./mockBaseFunc";

const mockReturnValue: i32 = 123;

describe("mock test", () => {
  test("call mock", () => {
    expect(add(1, 1)).notEqual(mockReturnValue);
    const mockFn = mock(add, (a, b) => {
      return mockReturnValue;
    });
    expect(add(1, 1)).equal(mockReturnValue);
    expect(mockFn.calls).equal(1);
    unmock(add);
    expect(add(1, 1)).notEqual(mockReturnValue);
    remock(add);
    expect(add(1, 1)).equal(mockReturnValue);
  });

  test("function with functionRef, but not mocked", () => {
    expect(add(1, 1)).equal(2);
  });

  test("call_indirect mock", () => {
    expect(caller(callee)).equal(100);
    const mockFn = mock(callee, () => {
      return mockReturnValue;
    });
    expect(caller(callee)).equal(mockReturnValue);
    expect(mockFn.calls).equal(1);
    unmock(callee);
    expect(caller(callee)).equal(100);
    remock(callee);
    expect(caller(callee)).equal(mockReturnValue);
  });

  test("class method call_indirect mock", () => {
    const mockClass = new MockClass();
    expect(mockClass.myLog("initial")).equal("mock class: [debug] initial");
  });

  // assemblyscript will compile function with default params to <functionName>@varargs
  test("default params function mock", () => {
    expect(incr(100)).equal(101);
    const mockFn = mock(incr, (value: u32, offset: u32 = 2) => {
      return value + offset;
    });
    expect(incr(100, 20)).equal(120);
    // This is a known issue, when we mock an function with default params, even we pass a new default value = 2,
    // It will still use the old default value = 1, when call incr.
    // Because assemblyscript load the params before called incr.
    expect(incr(100)).notEqual(102);
    expect(mockFn.calls).equal(2);
    unmock(incr);
    expect(incr(100)).equal(101);
    remock(incr);
    expect(incr(100, 50)).equal(150);
  });

  test("default params function call_indirect mock", () => {
    expect(call_incr(incr)).equal(221);
    const mockFn = mock(incr, (value: u32, offset: u32 = 2) => {
      return value - offset;
    });
    expect(call_incr(incr)).equal(180);
    expect(mockFn.calls).equal(2);
    unmock(incr);
    expect(call_incr(incr)).equal(221);
    remock(incr);
    expect(call_incr(incr)).equal(180);
  });
});
