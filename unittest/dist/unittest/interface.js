/**
 * This file define the interface of coverage information
 */
// input
import { relative } from "node:path";
// instrumented file information
export class InstrumentResult {
    baseName;
    constructor(baseName) {
        this.baseName = relative(process.cwd(), baseName).replaceAll(/\\/g, "/");
    }
    get sourceWasm() {
        return this.baseName.concat(".wasm");
    }
    get instrumentedWasm() {
        return this.baseName.concat(".instrumented.wasm");
    }
    get sourceMap() {
        return this.baseName.concat(".wasm.map");
    }
    get debugInfo() {
        return this.baseName.concat(".debugInfo.json");
    }
    get expectInfo() {
        return this.baseName.concat(".expectInfo.json");
    }
    get traceFile() {
        return this.baseName.concat(".trace");
    }
}
// output
export class Rate {
    used = 0;
    total = 0;
    getRate() {
        return this.total === 0 ? 100 : Math.round((this.used / this.total) * 10000) / 100;
    }
    toString() {
        return `${this.used}/${this.total}`;
    }
    static summarize(rates) {
        return rates.reduce((prev, curr) => {
            prev.used += curr.used;
            prev.total += curr.total;
            return prev;
        }, new Rate());
    }
}
export class FileCoverageResult {
    filename;
    constructor(filename) {
        this.filename = filename;
    }
    statementCoverageRate = new Rate();
    branchCoverageRate = new Rate();
    functionCoverageRate = new Rate();
    lineCoverageRate = new Rate();
    sourceUsedCount = [];
    uncoveredlines = new Set();
}
export class FunctionCoverageResult {
    functionName;
    constructor(functionName) {
        this.functionName = functionName;
    }
    branchCoverageRate = new Rate();
    uncoveredlines = new Set();
    lineRange = [Number.MAX_SAFE_INTEGER, Number.MIN_SAFE_INTEGER];
    /**
     * first means lineIndex;
     * second means usedCount;
     */
    sourceUsedCount = new Map();
    /**
     * Now assemblyscrpt will compile foo<T>() to different function like foo<f64>() , foo<u32>() etc;
     * We need merge the generic function to foo() for coverage statistics
     */
    static mergeFromGeneric(nameWithoutGeneric, infos) {
        const result = new FunctionCoverageResult(nameWithoutGeneric);
        result.lineRange = [
            Math.min(...infos.map((info) => info.lineRange[0])),
            Math.max(...infos.map((info) => info.lineRange[1])),
        ];
        result.branchCoverageRate = Rate.summarize(infos.map((info) => info.branchCoverageRate));
        for (const info of infos) {
            for (const line of info.uncoveredlines)
                result.uncoveredlines.add(line);
            for (const [lineIndex, count] of info.sourceUsedCount.entries()) {
                const srcLineUsedCount = result.sourceUsedCount.get(lineIndex);
                result.sourceUsedCount.set(lineIndex, srcLineUsedCount === undefined ? count : srcLineUsedCount + count);
            }
        }
        return result;
    }
}
export class CodeCoverage {
    static default = -1;
    source;
    /**
     * Default means not a effect line;
     * 0 means not used but effect;
     * more than 0 means a used line;
     */
    usedCount = CodeCoverage.default;
    constructor(src) {
        this.source = src;
    }
}
export class ImportsArgument {
    framework;
    module = null;
    instance = null;
    exports = null;
    constructor(framework) {
        this.framework = framework;
    }
}
export class UnitTestFramework {
}
export const OrganizationName = "wasm-ecosystem";
export const Repository = "https://github.com/wasm-ecosystem/assemblyscript-unittest-framework";
//# sourceMappingURL=interface.js.map