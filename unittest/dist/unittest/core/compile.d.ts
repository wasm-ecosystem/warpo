import { TestOption } from "../interface.js";
export type CompileOption = Pick<TestOption, "isolated" | "outputFolder" | "flags" | "warpo">;
export declare function compile(testCodePaths: string[], entryFiles: string[], option: CompileOption): Promise<string[]>;
//# sourceMappingURL=compile.d.ts.map