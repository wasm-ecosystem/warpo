export class MockStatusRecorder {
    _mockStatus = new Map();
    hasMocked(functionIndex) {
        const mockObject = this._mockStatus.get(functionIndex);
        if (mockObject === undefined) {
            return false;
        }
        return !mockObject.ignore;
    }
    // isCall = true,  return -1 if not mocked;
    // isCall = false, return oldIndex if not mocked.
    _checkMock(functionIndex, isCall) {
        if (this.hasMocked(functionIndex)) {
            const mockObject = this._mockStatus.get(functionIndex);
            mockObject.calls++;
            return mockObject.mockFunctionIndex;
        }
        return isCall ? -1 : functionIndex;
    }
    _setMockFunction(originalFunctionIndex, mockFunctionIndex) {
        const mockObject = {
            calls: 0,
            ignore: false,
            mockFunctionIndex,
        };
        this._mockStatus.set(originalFunctionIndex, mockObject);
    }
    _getMockedFunctionCalls(originalFunctionIndex, mockFunctionIndex) {
        const mockObject = this._mockStatus.get(originalFunctionIndex);
        if (mockObject === undefined || mockObject.mockFunctionIndex !== mockFunctionIndex) {
            return 0;
        }
        return mockObject.calls;
    }
    _setMockedFunctionIgnore(originalFunctionIndex, ignore) {
        const mockObject = this._mockStatus.get(originalFunctionIndex);
        if (mockObject === undefined) {
            return;
        }
        mockObject.ignore = ignore;
    }
    clear() {
        this._mockStatus.clear();
    }
    getMockFuncSet() {
        return {
            checkMock: (functionIndex, isCall) => {
                return this._checkMock(functionIndex, isCall);
            },
            setMockFunction: (originalFunctionIndex, mockFunctionIndex) => {
                this._setMockFunction(originalFunctionIndex, mockFunctionIndex);
            },
            getMockedFunctionCalls: (originalFunctionIndex, mockFunctionIndex) => {
                return this._getMockedFunctionCalls(originalFunctionIndex, mockFunctionIndex);
            },
            setMockedFunctionIgnore: (originalFunctionIndex, ignore) => {
                this._setMockedFunctionIgnore(originalFunctionIndex, ignore);
            },
        };
    }
}
//# sourceMappingURL=mockStatusRecorder.js.map