import { assertResult } from "./env";
import { MockFn, mockFunctionStatus } from "./mockInstrument";

export function describeImpl(
  description: string,
  testsFunction: () => void,
): void {
  assertResult.addDescription(description);
  testsFunction();
  assertResult.removeDescription();
}
export function testImpl(name: string, testFunction: () => void): void {
  assertResult.addDescription(name);
  assertResult.registerTestFunction(testFunction.index);
  assertResult.removeDescription();
}

export function beforeEachImpl(func: () => void): void {
  const result = assertResult.registerBeforeEachFunction(func.index);
  assert(result, "register setup function failed");
}

export function afterEachImpl(func: () => void): void {
  const result = assertResult.registerAfterEachFunction(func.index);
  assert(result, "register teardown function failed");
}

export function mockImpl<T extends Function>(
  originalFunction: T,
  mockFunction: T,
): MockFn {
  if (!isFunction<T>(originalFunction) || !isFunction<T>(mockFunction)) {
    ERROR("mock parameter must receive a function");
  }
  const mockFn = new MockFn(originalFunction.index, mockFunction.index);
  mockFunctionStatus.setMockFunction(
    originalFunction.index,
    mockFunction.index,
  );
  return mockFn;
}
export function unmockImpl<T extends Function>(originalFunction: T): void {
  mockFunctionStatus.setMockedFunctionIgnore(originalFunction.index, true);
}
export function remockImpl<T extends Function>(originalFunction: T): void {
  mockFunctionStatus.setMockedFunctionIgnore(originalFunction.index, false);
}
