interface MockObject {
  calls: number;
  ignore: boolean;
  mockFunctionIndex: number;
}

export class MockStatusRecorder {
  private _mockStatus = new Map<number, MockObject>();

  private hasMocked(functionIndex: number): boolean {
    const mockObject = this._mockStatus.get(functionIndex);
    if (mockObject === undefined) {
      return false;
    }
    return !mockObject.ignore;
  }

  // isCall = true,  return -1 if not mocked;
  // isCall = false, return oldIndex if not mocked.
  _checkMock(functionIndex: number, isCall: boolean): number {
    if (this.hasMocked(functionIndex)) {
      const mockObject = this._mockStatus.get(functionIndex);
      mockObject!.calls++;
      return mockObject!.mockFunctionIndex;
    }
    return isCall ? -1 : functionIndex;
  }

  _setMockFunction(originalFunctionIndex: number, mockFunctionIndex: number): void {
    const mockObject: MockObject = {
      calls: 0,
      ignore: false,
      mockFunctionIndex,
    };
    this._mockStatus.set(originalFunctionIndex, mockObject);
  }

  _getMockedFunctionCalls(originalFunctionIndex: number, mockFunctionIndex: number): number {
    const mockObject = this._mockStatus.get(originalFunctionIndex);
    if (mockObject === undefined || mockObject.mockFunctionIndex !== mockFunctionIndex) {
      return 0;
    }
    return mockObject.calls;
  }

  _setMockedFunctionIgnore(originalFunctionIndex: number, ignore: boolean): void {
    const mockObject = this._mockStatus.get(originalFunctionIndex);
    if (mockObject === undefined) {
      return;
    }
    mockObject.ignore = ignore;
  }

  clear(): void {
    this._mockStatus.clear();
  }

  getMockFuncSet(): Record<string, unknown> {
    return {
      checkMock: (functionIndex: number, isCall: boolean): number => {
        return this._checkMock(functionIndex, isCall);
      },
      setMockFunction: (originalFunctionIndex: number, mockFunctionIndex: number): void => {
        this._setMockFunction(originalFunctionIndex, mockFunctionIndex);
      },
      getMockedFunctionCalls: (originalFunctionIndex: number, mockFunctionIndex: number): number => {
        return this._getMockedFunctionCalls(originalFunctionIndex, mockFunctionIndex);
      },
      setMockedFunctionIgnore: (originalFunctionIndex: number, ignore: boolean): void => {
        this._setMockedFunctionIgnore(originalFunctionIndex, ignore);
      },
    };
  }
}
