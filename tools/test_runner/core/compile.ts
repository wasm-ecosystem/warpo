import { join, relative } from "node:path";
import { findRoot } from "../utils/pathResolver.js";
import { compileImpl } from "./compiler.js";
import { InstrumentResult, TestOption } from "../interface.js";

export type CompileOption = Pick<TestOption, "outputFolder" | "flags" | "collectCoverage">;

export async function compile(
  testCodePaths: string[],
  entryFiles: string[],
  option: CompileOption
): Promise<InstrumentResult[]> {
  return await separatedCompile(testCodePaths, entryFiles, option);
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

async function separatedCompile(
  testCodePaths: string[],
  entryFiles: string[],
  option: CompileOption
): Promise<InstrumentResult[]> {
  const { outputFolder, flags, collectCoverage } = option;
  const root = findRoot(testCodePaths);
  const compileOneFile = async (testCodePath: string) => {
    const ret = new InstrumentResult(getNewPath(outputFolder, root, testCodePath).slice(0, -3));
    await compileImpl({
      sources: combineWithEntryFiles({ testCodePaths: [testCodePath], entryFiles }),
      output: ret,
      userDefinedFlags: flags,
      collectCoverage,
    });
    return ret;
  };

  const ret: InstrumentResult[] = [];
  // Here, for-await is more efficient and less memory cost than Promise.all()
  for (const codePath of testCodePaths) {
    ret.push(await compileOneFile(codePath));
  }
  return ret;
}
