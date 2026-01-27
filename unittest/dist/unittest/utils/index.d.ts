import { Imports as ASImports } from "@assemblyscript/loader";
import { ImportFunctionInfo, ImportsArgument } from "../interface.js";
export declare function json2map<V>(json: Record<string, V>): Map<string, V>;
/**
 * return if the functionName is in fileName.
 * @param fileName example: "assembly/assertCollector.ts"
 * @param functionName example:
 *    "start:assembly/assertCollector~anonymous|0"
 *    || "assembly/assertCollector/addDescription"
 */
export declare function isFunctionInsideFile(fileName: string, functionName: string): boolean;
export declare function checkGenerics(functionName: string): string | undefined;
export declare function checkVarargs(functionName: string): string | undefined;
export declare function supplyDefaultFunction(infos: ImportFunctionInfo[], importObject: ASImports, importsArg: ImportsArgument): void;
//# sourceMappingURL=index.d.ts.map