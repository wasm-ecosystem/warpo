export declare class MockStatusRecorder {
    private _mockStatus;
    private hasMocked;
    _checkMock(functionIndex: number, isCall: boolean): number;
    _setMockFunction(originalFunctionIndex: number, mockFunctionIndex: number): void;
    _getMockedFunctionCalls(originalFunctionIndex: number, mockFunctionIndex: number): number;
    _setMockedFunctionIgnore(originalFunctionIndex: number, ignore: boolean): void;
    clear(): void;
    getMockFuncSet(): Record<string, unknown>;
}
//# sourceMappingURL=mockStatusRecorder.d.ts.map