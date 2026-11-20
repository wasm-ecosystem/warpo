import { Imports as ASImports } from "@assemblyscript/loader";
import { ImportsArgument } from "../interface.js";

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
  const pureFileName = fileName.slice(0, -3);
  if (functionName.startsWith("start:")) {
    const pureFunctionName = functionName.slice(6);
    const anonymousIndex = pureFunctionName.indexOf("~");
    const functionFileName = anonymousIndex === -1 ? pureFunctionName : pureFunctionName.slice(0, anonymousIndex);
    return functionFileName === pureFileName;
  }

  const anonymousPrefix = `${pureFileName}~`;
  if (functionName.startsWith(anonymousPrefix)) {
    return functionName.length > anonymousPrefix.length;
  }

  const filePrefix = `${pureFileName}/`;
  if (!functionName.startsWith(filePrefix)) {
    return false;
  }

  const rest = functionName.slice(filePrefix.length);
  if (rest.length === 0) {
    return false;
  }

  const pathSeparatorIndex = rest.indexOf("/");
  const functionSyntaxIndex = rest.search(/[#<~]/);
  return pathSeparatorIndex === -1 || (functionSyntaxIndex !== -1 && functionSyntaxIndex < pathSeparatorIndex);
}

export function checkGenerics(functionName: string): string | undefined {
  // Cannot handle nested generic method in generic class yet.
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

export function injectDefaultFunction(
  infos: WebAssembly.ModuleImportDescriptor[],
  importObject: ASImports,
  importsArg: ImportsArgument
) {
  for (const info of infos) {
    const { module, name, kind } = info;
    const importObjectModule = importObject[module] ?? {};
    importObject[module] = importObjectModule;
    if (importObjectModule[name] !== undefined) {
      continue;
    }
    if (module === "env" && name === "abort") {
      importObjectModule[name] = (msg: number, file: number, line: number, col: number) => {
        const exports = importsArg.exports;
        if (exports === null) {
          throw new WebAssembly.RuntimeError("missing AssemblyScript exports");
        }
        throw new WebAssembly.RuntimeError(
          `abort: ${exports.__getString(msg)} at ${exports.__getString(file)}:${line}:${col}`
        );
      };
      continue;
    }
    if (module === "env" && name === "trace") {
      importObjectModule[name] = (msg: number, n: number, ...args: number[]) => {
        const exports = importsArg.exports;
        if (exports === null) {
          throw new WebAssembly.RuntimeError("missing AssemblyScript exports");
        }
        importsArg.framework.log(`trace: ${exports.__getString(msg)}${n > 0 ? " " : ""}${args.slice(0, n).join(", ")}`);
      };
      continue;
    }
    if (kind === "function") {
      importObjectModule[name] = () => {
        // https://tc39.es/ecma262/multipage/abstract-operations.html#sec-tobigint
        // https://tc39.es/ecma262/multipage/abstract-operations.html#sec-tonumber
        // When return js value to wasm, spec requires to convert the value to bigint for i64 and number for others.
        // Here return a number does not work for bigint because a TypeError will be thrown.
        // The common solution is to return boolean that can be converted to both number and bigint
        return false;
      };
      continue;
    }
    throw new Error(`unsupported import: ${module}.${name} of kind ${kind}`);
  }
}
