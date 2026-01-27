import { join, relative } from "node:path";
import { findRoot } from "../utils/pathResolver.js";
import { compileImpl } from "./compiler.js";
export async function compile(testCodePaths, entryFiles, option) {
    const { isolated } = option;
    return isolated
        ? await separatedCompile(testCodePaths, entryFiles, option)
        : [await unifiedCompile(testCodePaths, entryFiles, option)];
}
function getNewPath(newFolder, oldFolder, srcPath) {
    return join(newFolder, relative(oldFolder, srcPath)).replaceAll(/\\/g, "/");
}
function combineWithEntryFiles({ testCodePaths, entryFiles, }) {
    // Because AS has recursive import resolution issue.
    // put entryFiles firstly will force ASC compile entry file firstly, which can avoid compilation failed due to test files import ordering
    return entryFiles.concat(testCodePaths);
}
async function unifiedCompile(testCodePaths, entryFiles, option) {
    const { outputFolder, flags } = option;
    const outputWASM = join(outputFolder, "test.wasm").replaceAll(/\\/g, "/");
    await compileImpl({
        sources: combineWithEntryFiles({ testCodePaths, entryFiles }),
        outputWASM,
        userDefinedFlags: flags,
    }, option.warpo);
    return outputWASM;
}
async function separatedCompile(testCodePaths, entryFiles, option) {
    const { outputFolder, flags } = option;
    const wasm = [];
    const root = findRoot(testCodePaths);
    const compileOneFile = async (testCodePath) => {
        const outputWASM = getNewPath(outputFolder, root, testCodePath).slice(0, -2).concat("wasm");
        wasm.push(outputWASM);
        await compileImpl({
            sources: combineWithEntryFiles({ testCodePaths: [testCodePath], entryFiles }),
            outputWASM,
            userDefinedFlags: flags,
        }, option.warpo);
    };
    // Here, for-await is more efficient and less memory cost than Promise.all()
    for (const codePath of testCodePaths) {
        await compileOneFile(codePath);
    }
    return wasm;
}
//# sourceMappingURL=compile.js.map