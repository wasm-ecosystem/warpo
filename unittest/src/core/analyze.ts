/**
 * Will transform all source file to get all relative functions
 */

import ignore from "ignore";
import { join, relative, resolve } from "node:path";
import { getIncludeFiles } from "../utils/pathResolver.js";
import { TestOption } from "../interface.js";
import assert from "node:assert";

type AnalyzeOption = Pick<TestOption, "includes" | "excludes" | "testFiles" | "testNamePattern" | "entryFiles">;

interface UnittestPackage {
  readonly testCodePaths: string[];
  readonly sourceCodePaths: string[];
  readonly entryFiles: string[];
  readonly filterByName: (fullTestName: string) => boolean;
}

export function analyze(
  { includes, excludes, testNamePattern, testFiles, entryFiles }: AnalyzeOption,
  failedTestNames: string[]
): UnittestPackage {
  const testCodePaths = testFiles ?? getRelatedFiles(includes, excludes, (path: string) => path.endsWith(".test.ts"));
  const sourceCodePaths = getRelatedFiles(
    includes,
    excludes,
    (path: string) => path.endsWith(".ts") && !path.endsWith(".test.ts")
  );
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

function getEntryFiles(includes: string[], sourceCodePaths: string[]): string[] {
  // entry files must be in source code paths
  return includes
    .map((include) => (include.endsWith(".ts") ? include : join(include, "index.ts")))
    .filter((include) => include.endsWith(".ts") && sourceCodePaths.includes(include));
}

function getFilterByName(testNamePattern: string | null, failedTestNames: string[]): UnittestPackage["filterByName"] {
  assert(
    !(testNamePattern !== null && failedTestNames.length > 0),
    "Cannot use testNamePattern and failedTestNames together"
  );
  if (testNamePattern !== null) {
    const regexPattern = new RegExp(testNamePattern);
    return (fullTestName: string): boolean => regexPattern.test(fullTestName);
  }
  if (failedTestNames.length > 0) {
    return (fullTestName: string): boolean => failedTestNames.includes(fullTestName);
  }
  return (): boolean => true;
}

// a. include in config
// b. exclude in config
function getRelatedFiles(includes: string[], excludes: string[], filter: (path: string) => boolean) {
  const result: string[] = [];
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
