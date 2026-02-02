import { join } from "node:path";
import { writeFileSync } from "node:fs";
import { FileCoverageResult, Rate } from "../../interface.js";

type JsonOutput = Record<string, FileInfo>;
interface FileInfo {
  statementCoverageRate: JsonRate;
  branchCoverageRate: JsonRate;
  functionCoverageRate: JsonRate;
  lineCoverageRate: JsonRate;
}

class JsonRate {
  total: number;
  used: number;
  rate: number;
  constructor(rate: Rate) {
    this.total = rate.total;
    this.used = rate.used;
    this.rate = rate.getRate();
  }
}

export function genJson(target: string, filesInfos: FileCoverageResult[]) {
  const jsonOutput: JsonOutput = {};

  const statementCoverageTotalRate = new Rate();
  const branchCoverageTotalRate = new Rate();
  const functionCoverageTotalRate = new Rate();
  const lineCoverageTotalRate = new Rate();
  for (const cur of filesInfos) {
    const { filename, statementCoverageRate, branchCoverageRate, functionCoverageRate, lineCoverageRate } = cur;
    jsonOutput[filename] = {
      statementCoverageRate: new JsonRate(statementCoverageRate),
      branchCoverageRate: new JsonRate(branchCoverageRate),
      functionCoverageRate: new JsonRate(functionCoverageRate),
      lineCoverageRate: new JsonRate(lineCoverageRate),
    };
    statementCoverageTotalRate.total += statementCoverageRate.total;
    statementCoverageTotalRate.used += statementCoverageRate.used;
    branchCoverageTotalRate.total += branchCoverageRate.total;
    branchCoverageTotalRate.used += branchCoverageRate.used;
    functionCoverageTotalRate.total += functionCoverageRate.total;
    functionCoverageTotalRate.used += functionCoverageRate.used;
    lineCoverageTotalRate.total += lineCoverageRate.total;
    lineCoverageTotalRate.used += lineCoverageRate.used;
  }
  jsonOutput["All files"] = {
    statementCoverageRate: new JsonRate(statementCoverageTotalRate),
    branchCoverageRate: new JsonRate(branchCoverageTotalRate),
    functionCoverageRate: new JsonRate(functionCoverageTotalRate),
    lineCoverageRate: new JsonRate(lineCoverageTotalRate),
  };

  writeFileSync(join(target, "coverage.json"), JSON.stringify(jsonOutput, null, 4), {});
}
