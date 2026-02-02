import assert from "node:assert";
import { CodeSnippetIndex, CovInfo, FunctionCoverageResult, UncoveredBasicBlocks } from "../interface.js";

type BranchGraph = Map<number, Map<number, boolean>>;

export class SingleFunctionCoverageAnalysis {
  result: FunctionCoverageResult;
  branchGraph: BranchGraph = new Map();
  notFullyCoveredBasicBlock: UncoveredBasicBlocks = new Set();
  constructor(
    public covInfo: CovInfo,
    name: string
  ) {
    this.result = new FunctionCoverageResult(name);
    this.result.branchCoverageRate.total = covInfo.branchInfo.length;
    let maxLine = Number.MIN_SAFE_INTEGER,
      minLine = Number.MAX_SAFE_INTEGER;
    for (const branchInfo of covInfo.branchInfo) {
      const branches = this.branchGraph.get(branchInfo[0]);
      if (branches) {
        branches.set(branchInfo[1], false);
      } else {
        this.branchGraph.set(branchInfo[0], new Map([[branchInfo[1], false]]));
      }
    }
    for (const lineIndexSet of covInfo.lineInfo.values()) {
      for (const lineIndex of lineIndexSet.values()) {
        minLine = Math.min(minLine, lineIndex);
        maxLine = Math.max(maxLine, lineIndex);
        this.result.sourceUsedCount.set(lineIndex, 0);
      }
    }
    if (this.result.sourceUsedCount.size > 0) {
      this.result.lineRange = [minLine, maxLine];
    }
  }

  update(indexSerialInSingleFunction: CodeSnippetIndex[]): FunctionCoverageResult {
    this.updateLine(indexSerialInSingleFunction);
    this.updateBranch(indexSerialInSingleFunction);
    return this.result;
  }

  updateLine(indexSerialInSingleFunction: CodeSnippetIndex[]) {
    const indexCount = new Map<CodeSnippetIndex, number>();
    for (const index of indexSerialInSingleFunction) {
      const count = indexCount.get(index);
      indexCount.set(index, count === undefined ? 1 : count + 1);
    }
    for (const [index, count] of indexCount.entries()) {
      const codeLines = this.covInfo.lineInfo.get(index);
      if (codeLines === undefined) {
        throw new Error(`CovInfo And CovTrace of Function ${this.result.functionName} mismatch: Index: ${index}`);
      }
      for (const lineIndex of codeLines) {
        const usedCount = this.result.sourceUsedCount.get(lineIndex);
        this.result.sourceUsedCount.set(lineIndex, usedCount === undefined ? count : usedCount + count);
      }
    }
  }

  updateBranch(indexSerialInSingleFunction: CodeSnippetIndex[]) {
    if (this.branchGraph.size === 0) {
      return;
    }
    this.markCoveredBranches(indexSerialInSingleFunction);
    this.calculateBranchCoverage();
    this.addUncoveredLines();
  }

  private markCoveredBranches(indexSerialInSingleFunction: CodeSnippetIndex[]) {
    for (let i = 1; i < indexSerialInSingleFunction.length; i++) {
      const first = indexSerialInSingleFunction[i - 1],
        second = indexSerialInSingleFunction[i];
      assert(first !== undefined);
      assert(second !== undefined);
      const toNodes = this.branchGraph.get(first);
      if (toNodes && toNodes.get(second) === false) {
        toNodes.set(second, true);
      }
    }
  }

  private calculateBranchCoverage() {
    for (const [currentBasicBlock, branchesForThatBasicBlock] of this.branchGraph) {
      let used = 0;
      for (const isCovered of branchesForThatBasicBlock.values()) {
        if (isCovered) {
          used++;
        } else {
          this.notFullyCoveredBasicBlock.add(currentBasicBlock);
        }
      }
      this.result.branchCoverageRate.used += used;
    }
  }

  private addUncoveredLines() {
    for (const block of this.notFullyCoveredBasicBlock) {
      const lineInfo = this.covInfo.lineInfo.get(block);
      if (lineInfo !== undefined && lineInfo.size > 0) {
        this.result.uncoveredlines.add(Math.max(...lineInfo));
      }
    }
  }
}
