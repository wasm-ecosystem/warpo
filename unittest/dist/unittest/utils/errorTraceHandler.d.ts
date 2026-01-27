export interface WebAssemblyCallSite {
    functionName: string;
    fileName: string;
    lineNumber: number;
    columnNumber: number;
}
export interface ExecutionError {
    message: string;
    stacks: WebAssemblyCallSite[];
}
export declare function handleWebAssemblyError(error: WebAssembly.RuntimeError, wasmPath: string): Promise<ExecutionError>;
//# sourceMappingURL=errorTraceHandler.d.ts.map