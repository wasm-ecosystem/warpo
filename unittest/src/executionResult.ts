import { promises } from "node:fs";
import { json2map } from "./utils/index.js";
import {
  FailedInfoMap,
  AssertMessage,
  ExpectInfo,
  IExecutionResult,
  AssertFailMessage,
  TestCaseName,
  FailedInfo,
  FailedLogMessages,
} from "./interface.js";
import chalk from "chalk";
import assert from "node:assert";

const { readFile, writeFile } = promises;

export class ExecutionResultSummary {
  fail = 0;
  total = 0;
  failedInfos: FailedInfoMap = new Map();

  #prepareFailedInfos(testcaseName: TestCaseName): FailedInfo {
    if (this.failedInfos.has(testcaseName)) {
      return this.failedInfos.get(testcaseName)!;
    }
    const failedInfo: FailedInfo = {
      hasCrash: false,
      assertMessages: [],
      logMessages: [],
    };
    this.failedInfos.set(testcaseName, failedInfo);
    return failedInfo;
  }

  #processAssertInfo(failedInfo: AssertFailMessage, expectInfo: ExpectInfo | null) {
    for (const [testcaseName, value] of json2map<AssertMessage[]>(failedInfo)) {
      const errorMsgs: string[] = [];
      for (const msg of value) {
        const [expectInfoIndex, actualValue, expectValue] = msg;
        assert(expectInfo !== null && "missing expect info!");
        const debugLocation = expectInfo[expectInfoIndex];
        let errorMsg = `${debugLocation ?? ""}  value: ${actualValue}  expect: ${expectValue}`;
        if (errorMsg.length > 160) {
          errorMsg = `${debugLocation ?? ""}\nvalue: \n  ${actualValue}\nexpect: \n  ${expectValue}`;
        }
        errorMsgs.push(errorMsg);
      }
      this.#prepareFailedInfos(testcaseName).assertMessages =
        this.#prepareFailedInfos(testcaseName).assertMessages.concat(errorMsgs);
    }
  }

  #processCrashInfo(crashInfo: Set<TestCaseName>) {
    for (const testcaseName of crashInfo) {
      this.#prepareFailedInfos(testcaseName).hasCrash = true;
    }
  }

  /**
   * It should be called after other error processed to append log messages.
   */
  #processLogMessages(failedLogMessages: FailedLogMessages) {
    for (const [testcaseName, failedInfo] of this.failedInfos) {
      if (failedLogMessages[testcaseName] !== undefined) {
        failedInfo.logMessages = failedInfo.logMessages.concat(failedLogMessages[testcaseName]);
      }
    }
  }

  async merge(result: IExecutionResult, expectInfoFilePath: string) {
    this.fail += result.fail;
    this.total += result.total;
    if (result.fail > 0) {
      try {
        const expectContent = await readFile(expectInfoFilePath, { encoding: "utf8" });
        const expectInfo = JSON.parse(expectContent) as ExpectInfo | null;
        this.#processAssertInfo(result.failedInfo, expectInfo);
        this.#processCrashInfo(result.crashInfo);
        this.#processLogMessages(result.failedLogMessages);
      } catch (error) {
        if (error instanceof Error) {
          console.error(error.stack);
        }
        throw error;
      }
    }
  }

  async writeFailures(failuresPath: string) {
    await writeFile(failuresPath, JSON.stringify(Array.from(this.failedInfos.keys())));
  }

  print(log: (msg: string) => void): void {
    const rate =
      (this.fail === 0 ? chalk.greenBright(this.total) : chalk.redBright(this.total - this.fail)) +
      "/" +
      this.total.toString();
    log(`\ntest case: ${rate} (success/total)`);
    if (this.fail !== 0) {
      log("");
      this.#printErrorMessage(log);
    }
  }

  #printErrorMessage(log: (msg: string) => void): void {
    log(chalk.red("Error Message: "));
    // sort failedInfos by testcaseName to keep stability for e2e testing
    const failedInfosArray = Array.from(this.failedInfos.entries()).sort((a, b) => a[0].localeCompare(b[0]));
    for (const [testcaseName, { hasCrash, assertMessages, logMessages }] of failedInfosArray) {
      log(`  ${testcaseName}: `);
      for (const assertMessage of assertMessages) {
        log("    " + chalk.yellow(assertMessage));
      }
      if (hasCrash) {
        log("    " + chalk.red("Test Crashed!"));
      }
      for (const logMessage of logMessages ?? []) {
        log(chalk.gray(logMessage));
      }
      if (logMessages.length > 0) {
        // empty line to separate test
        log("");
      }
    }
  }
}
