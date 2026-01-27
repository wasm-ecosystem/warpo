import { Rate, CodeCoverage, FileCoverageResult } from "../interface.js";
export class SingleFileCoverageAnalysis {
    result;
    constructor(fileName, source) {
        this.result = new FileCoverageResult(fileName);
        for (const srcLine of source.split(/\r?\n/)) {
            this.result.sourceUsedCount.push(new CodeCoverage(srcLine));
        }
    }
    setTotalFunction(count) {
        this.result.functionCoverageRate.total = count;
    }
    merge(results) {
        // SingleFileCoverageAnalysis contains FileCoverageResult
        if (results.length === 0)
            return;
        for (const functionCovResult of results) {
            for (const line of functionCovResult.uncoveredlines)
                this.result.uncoveredlines.add(line);
            for (const [lineIndex, count] of functionCovResult.sourceUsedCount.entries()) {
                const srcLineUsedCount = this.result.sourceUsedCount[lineIndex - 1];
                if (srcLineUsedCount === undefined) {
                    throw new Error(`unknown error: There is not Line ${lineIndex} in ${JSON.stringify(this.result.sourceUsedCount)}`);
                }
                if (srcLineUsedCount.usedCount === CodeCoverage.default) {
                    srcLineUsedCount.usedCount = count;
                }
                else {
                    srcLineUsedCount.usedCount += count;
                }
            }
        }
        const branchCoverageRates = results.map((result) => result.branchCoverageRate);
        branchCoverageRates.push(this.result.branchCoverageRate);
        this.result.branchCoverageRate = Rate.summarize(branchCoverageRates);
        this.result.functionCoverageRate.used += results.length;
    }
    getResult() {
        for (const cov of this.result.sourceUsedCount) {
            if (cov.usedCount === CodeCoverage.default)
                continue;
            if (cov.usedCount > 0) {
                this.result.lineCoverageRate.used++;
            }
            this.result.lineCoverageRate.total++;
        }
        this.result.statementCoverageRate = this.result.lineCoverageRate;
        return this.result;
    }
}
//# sourceMappingURL=singleFileAnalysis.js.map