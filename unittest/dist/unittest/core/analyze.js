/**
 * Will transform all source file to get all relative functions
 */
import ignore from "ignore";
import { join, relative, resolve } from "node:path";
import { getIncludeFiles } from "../utils/pathResolver.js";
import assert from "node:assert";
export function analyze({ includes, excludes, testNamePattern, testFiles, entryFiles }, failedTestNames) {
    const testCodePaths = testFiles ?? getRelatedFiles(includes, excludes, (path) => path.endsWith(".test.ts"));
    const sourceCodePaths = getRelatedFiles(includes, excludes, (path) => path.endsWith(".ts") && !path.endsWith(".test.ts"));
    return {
        // if specify testFiles, use testFiles for unittest
        // otherwise, get testFiles(*.test.ts) in includes directory
        testCodePaths: testCodePaths,
        // get all source files in includes directory
        sourceCodePaths: sourceCodePaths,
        entryFiles: entryFiles ?? getEntryFiles(includes, sourceCodePaths),
        filterByName: getFilterByName(testNamePattern, failedTestNames),
    };
}
function getEntryFiles(includes, sourceCodePaths) {
    // entry files must be in source code paths
    return includes
        .map((include) => (include.endsWith(".ts") ? include : join(include, "index.ts")))
        .filter((include) => include.endsWith(".ts") && sourceCodePaths.includes(include));
}
function getFilterByName(testNamePattern, failedTestNames) {
    assert(!(testNamePattern !== null && failedTestNames.length > 0), "Cannot use testNamePattern and failedTestNames together");
    if (testNamePattern !== null) {
        const regexPattern = new RegExp(testNamePattern);
        return (fullTestName) => regexPattern.test(fullTestName);
    }
    if (failedTestNames.length > 0) {
        return (fullTestName) => failedTestNames.includes(fullTestName);
    }
    return () => true;
}
// a. include in config
// b. exclude in config
function getRelatedFiles(includes, excludes, filter) {
    const result = [];
    const includeFiles = getIncludeFiles(includes, (path) => path.endsWith(".ts")); // a
    const exc = ignore().add(excludes);
    for (const path of includeFiles) {
        const relativePath = relative(".", path);
        if (relativePath.startsWith("..")) {
            throw new Error(`file ${path} out of scope (${resolve(".")})`);
        }
        if (exc.ignores(relativePath)) {
            continue; // ab
        }
        if (filter(path)) {
            result.push(path.replaceAll(/\\/g, "/"));
        }
    }
    return result;
}
//# sourceMappingURL=analyze.js.map