import { join, relative } from "node:path";
import { findRoot } from "../utils/pathResolver.js";
import { compileImpl } from "./compiler.js";
import { TestOption } from "../interface.js";

export type CompileOption = Pick<TestOption, "isolated" | "outputFolder" | "flags" | "warpo">;

export async function compile(testCodePaths: string[], entryFiles: string[], option: CompileOption): Promise<string[]> {
  const { isolated } = option;
  return isolated
    ? await separatedCompile(testCodePaths, entryFiles, option)
    : [await unifiedCompile(testCodePaths, entryFiles, option)];
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

async function unifiedCompile(testCodePaths: string[], entryFiles: string[], option: CompileOption): Promise<string> {
  const { outputFolder, flags } = option;
  const outputWASM = join(outputFolder, "test.wasm").replaceAll(/\\/g, "/");
  await compileImpl(
    {
      sources: combineWithEntryFiles({ testCodePaths, entryFiles }),
      outputWASM,
      userDefinedFlags: flags,
    },
    option.warpo
  );
  return outputWASM;
}

async function separatedCompile(
  testCodePaths: string[],
  entryFiles: string[],
  option: CompileOption
): Promise<string[]> {
  const { outputFolder, flags } = option;
  const wasm: string[] = [];
  const root = findRoot(testCodePaths);
  const compileOneFile = async (testCodePath: string) => {
    const outputWASM = getNewPath(outputFolder, root, testCodePath).slice(0, -2).concat("wasm");
    wasm.push(outputWASM);
    await compileImpl(
      {
        sources: combineWithEntryFiles({ testCodePaths: [testCodePath], entryFiles }),
        outputWASM,
        userDefinedFlags: flags,
      },
      option.warpo
    );
  };

  // Here, for-await is more efficient and less memory cost than Promise.all()
  for (const codePath of testCodePaths) {
    await compileOneFile(codePath);
  }

  return wasm;
}
