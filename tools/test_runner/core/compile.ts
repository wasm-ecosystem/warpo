import { join, relative } from "node:path";
import { compileImpl } from "./compiler.js";
import { TestOption } from "../testOption.js";
import { WebAssemblyModule } from "../utils/wasm.js";

export type CompileOption = Pick<TestOption, "outputFolder" | "flags" | "collectCoverage">;

export async function compile(
  testCodePaths: string[],
  entryFiles: string[],
  option: CompileOption
): Promise<WebAssemblyModule> {
  const { outputFolder, flags, collectCoverage } = option;
  const ret = new WebAssemblyModule(join(outputFolder, "test").replaceAll(/\\/g, "/"));
  await compileImpl({
    sources: combineWithEntryFiles({ testCodePaths, entryFiles }),
    output: ret,
    userDefinedFlags: flags,
    collectCoverage,
  });
  return ret;
}

function getNewPath(newFolder: string, oldFolder: string, srcPath: string): string {
  return join(newFolder, relative(oldFolder, srcPath)).replaceAll(/\\/g, "/");
}

function combineWithEntryFiles({
  testCodePaths,
  entryFiles,
}: {
  testCodePaths: string[];
  entryFiles: string[];
}): string[] {
  // Because AS has recursive import resolution issue.
  // put entryFiles firstly will force ASC compile entry file firstly, which can avoid compilation failed due to test files import ordering
  return entryFiles.concat(testCodePaths);
}
