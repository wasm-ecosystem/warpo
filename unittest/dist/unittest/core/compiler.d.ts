import { main } from "assemblyscript/asc";
export declare class CompilationError extends Error {
    constructor(errorMessage: string | undefined);
}
export declare const asc: {
    compile: typeof main;
};
export interface CompilationOption {
    sources: string[];
    outputWASM: string;
    userDefinedFlags: string;
}
export declare function compileImpl(option: CompilationOption, useWarpo: boolean): Promise<void>;
//# sourceMappingURL=compiler.d.ts.map