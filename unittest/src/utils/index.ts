import { Imports as ASImports } from "@assemblyscript/loader";
import { ImportFunctionInfo, ImportsArgument } from "../interface.js";
import { TypeKind } from "wasmparser/dist/cjs/WasmParser.js";

export function json2map<V>(json: Record<string, V>): Map<string, V> {
  const res = new Map<string, V>();
  for (const key in json) {
    const value = json[key];
    if (value === undefined) {
      throw new Error(`json parse failed: ${JSON.stringify(json)}`);
    }
    res.set(key, value);
  }
  return res;
}

/**
 * return if the functionName is in fileName.
 * @param fileName example: "assembly/assertCollector.ts"
 * @param functionName example:
 *    "start:assembly/assertCollector~anonymous|0"
 *    || "assembly/assertCollector/addDescription"
 */
export function isFunctionInsideFile(fileName: string, functionName: string) {
  // `/`: parent is File
  // `#`: parent is Class, this is non-static
  // `.`: parent is Class, this is static
  // `<`: generic
  // `~`: parent is Function
  const regex = new RegExp(`^(start:)?${fileName.slice(0, -3)}[/~](?<rest>.+)`);
  const matchPrefix = regex.exec(functionName);
  const rest = matchPrefix?.groups?.["rest"] ?? null;
  if (rest === null) {
    return false;
  }
  const specialCharIndex = rest.search(/[/#.<~]/g);
  if (specialCharIndex === -1) {
    return true;
  }
  return rest[specialCharIndex] !== "/";
}

export function checkGenerics(functionName: string): string | undefined {
  // FIXME: cannot handle nested generic method in generic class
  const startIndex = functionName.indexOf("<");
  const endIndex = functionName.lastIndexOf(">");
  if (startIndex !== -1 && endIndex !== -1) {
    return functionName.slice(0, startIndex) + functionName.slice(endIndex + 1);
  }
  return undefined;
}

export function checkVarargs(functionName: string): string | undefined {
  if (functionName.endsWith("@varargs")) {
    return functionName.slice(0, -8);
  }
  return undefined;
}

export function supplyDefaultFunction(
  infos: ImportFunctionInfo[],
  importObject: ASImports,
  importsArg: ImportsArgument
) {
  for (const info of infos) {
    const module = info.module;
    const name = info.name;
    const importObjectModule = importObject[module] ?? {};
    importObject[module] = importObjectModule;
    if (importObjectModule[name] !== undefined) {
      continue;
    }
    if (module === "env" && name === "abort") {
      importObjectModule[name] = (msg: number, file: number, line: number, col: number) => {
        const exports = importsArg.exports!;
        throw new WebAssembly.RuntimeError(
          `abort: ${exports.__getString(msg)} at ${exports.__getString(file)}:${line}:${col}`
        );
      };
    } else if (module === "env" && name === "trace") {
      importObjectModule[name] = (msg: number, n: number, ...args: number[]) => {
        const exports = importsArg.exports!;
        importsArg.framework.log(`trace: ${exports.__getString(msg)}${n > 0 ? " " : ""}${args.slice(0, n).join(", ")}`);
      };
    } else {
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      importObjectModule[name] = (..._args: unknown[]): unknown => {
        return info.return?.kind === TypeKind.i64 ? BigInt(0) : 0;
      };
    }
  }
}
