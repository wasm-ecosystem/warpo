export namespace mockFunctionStatus {

  @external("__unittest_framework_env","setMockFunction")
  export declare function setMockFunction(
    originalFunctionIndex: u32,
    mockFunctionIndex: u32,
  ): void;


  @external("__unittest_framework_env","getMockedFunctionCalls")
  export declare function getMockedFunctionCalls(
    originalFunctionIndex: u32,
    mockFunctionIndex: u32,
  ): u32;


  @external("__unittest_framework_env","setMockedFunctionIgnore")
  export declare function setMockedFunctionIgnore(
    originalFunctionIndex: u32,
    ignore: bool,
  ): void;
}

export class MockFn {
  get calls(): u32 {
    return mockFunctionStatus.getMockedFunctionCalls(
      this.originalFunctionIndex,
      this.mockFunctionIndex,
    );
  }
  constructor(
    public originalFunctionIndex: u32,
    public mockFunctionIndex: u32,
  ) {}
}
