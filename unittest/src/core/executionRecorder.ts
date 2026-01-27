import chalk from "chalk";
import {
  UnitTestFramework,
  ImportsArgument,
  AssertFailMessage,
  AssertMessage,
  IExecutionResult,
  FailedLogMessages,
  CrashInfo,
} from "../interface.js";
import { ExecutionError } from "../utils/errorTraceHandler.js";

class LogRecorder {
  #currentTestLogMessages: string[] = [];
  #isTestFailed: boolean = false;

  addLog(msg: string): void {
    this.#currentTestLogMessages.push(msg);
  }
  markTestFailed(): void {
    this.#isTestFailed = true;
  }

  reset(): void {
    this.#currentTestLogMessages = [];
    this.#isTestFailed = false;
  }
  onFinishTest(): string[] | null {
    if (this.#currentTestLogMessages.length === 0) {
      return null;
    }
    if (this.#isTestFailed === false) {
      return null;
    }
    return this.#currentTestLogMessages;
  }
}

export class ExecutionResult implements IExecutionResult {
  total: number = 0;
  fail: number = 0;
  failedInfo: AssertFailMessage = {};
  crashInfo: CrashInfo = new Set();
  failedLogMessages: FailedLogMessages = {};
}

class TestBlock {
  constructor(public description: string) {}
  setupFunctions: number[] = [];
  teardownFunctions: number[] = [];
}

export class TestCase {
  fullName: string;
  setupFunctions: number[];
  teardownFunctions: number[];
  constructor(
    testBlockStack: TestBlock[],
    public functionIndex: number
  ) {
    this.fullName = testBlockStack.map((block) => block.description).join(" ");
    this.setupFunctions = testBlockStack.flatMap((block) => block.setupFunctions);
    this.teardownFunctions = testBlockStack.flatMap((block) => block.teardownFunctions);
  }
}

export class ExecutionRecorder implements UnitTestFramework {
  result = new ExecutionResult();

  testBlockStack: TestBlock[] = [];
  testCases: TestCase[] = [];

  currentExecutedTestCaseFullName: string = "";
  logRecorder = new LogRecorder();

  _addDescription(description: string): void {
    this.testBlockStack.push(new TestBlock(description));
  }
  _removeDescription(): void {
    this.testBlockStack.pop();
  }

  get lastTestBlock(): TestBlock | undefined {
    return this.testBlockStack.at(-1);
  }
  // return false if error
  _registerSetup(functionIndex: number): boolean {
    const lastTestBlock = this.lastTestBlock;
    if (lastTestBlock === undefined) {
      return false;
    } else {
      lastTestBlock.setupFunctions.push(functionIndex);
      return true;
    }
  }
  // return false if error
  _registerTeardown(functionIndex: number): boolean {
    const lastTestBlock = this.lastTestBlock;
    if (lastTestBlock === undefined) {
      return false;
    } else {
      lastTestBlock.teardownFunctions.push(functionIndex);
      return true;
    }
  }
  _addTestCase(functionIndex: number): void {
    this.testCases.push(new TestCase(this.testBlockStack, functionIndex));
  }

  _startTestFunction(fullName: string): void {
    this.currentExecutedTestCaseFullName = fullName;
    this.logRecorder.reset();
  }
  _finishTestFunction(): void {
    const logMessages: string[] | null = this.logRecorder.onFinishTest();
    if (logMessages !== null) {
      this.result.failedLogMessages[this.currentExecutedTestCaseFullName] = (
        this.result.failedLogMessages[this.currentExecutedTestCaseFullName] || []
      ).concat(logMessages);
    }
  }
  async runTestFunction(
    fullName: string,
    runner: () => Promise<void> | void,
    exceptionHandler: (error: unknown) => Promise<void>
  ) {
    this._startTestFunction(fullName);
    try {
      const r = runner();
      if (r instanceof Promise) {
        await r;
      }
    } catch (error) {
      await exceptionHandler(error);
    }
    this._finishTestFunction();
  }

  notifyTestCrash(error: ExecutionError): void {
    this.logRecorder.addLog(`Reason: ${chalk.red(error.message)}`);
    this.logRecorder.addLog(
      error.stacks
        .map((stack) => `  at ${stack.functionName} (${stack.fileName}:${stack.lineNumber}:${stack.columnNumber})`)
        .join("\n")
    );
    this.result.crashInfo.add(this.currentExecutedTestCaseFullName);
    this.result.total++; // fake test cases
    this.#increaseFailureCount();
  }

  collectCheckResult(result: boolean, codeInfoIndex: number, actualValue: string, expectValue: string): void {
    this.result.total++;
    if (!result) {
      this.#increaseFailureCount();
      const testCaseFullName = this.currentExecutedTestCaseFullName;
      const assertMessage: AssertMessage = [codeInfoIndex.toString(), actualValue, expectValue];
      this.result.failedInfo[testCaseFullName] = this.result.failedInfo[testCaseFullName] || [];
      this.result.failedInfo[testCaseFullName].push(assertMessage);
    }
  }

  log(msg: string): void {
    this.logRecorder.addLog(msg);
  }

  getCollectionFuncSet(arg: ImportsArgument): Record<string, unknown> {
    return {
      addDescription: (description: number): void => {
        this._addDescription(arg.exports!.__getString(description));
      },
      removeDescription: (): void => {
        this._removeDescription();
      },
      registerTestFunction: (index: number): void => {
        this._addTestCase(index);
      },
      registerBeforeEachFunction: (index: number): boolean => {
        return this._registerSetup(index);
      },
      registerAfterEachFunction: (index: number): boolean => {
        return this._registerTeardown(index);
      },
      collectCheckResult: (result: number, codeInfoIndex: number, actualValue: number, expectValue: number): void => {
        this.collectCheckResult(
          result !== 0,
          codeInfoIndex,
          arg.exports!.__getString(actualValue),
          arg.exports!.__getString(expectValue)
        );
      },
    };
  }

  #increaseFailureCount(): void {
    this.result.fail++;
    this.logRecorder.markTestFailed();
  }
}
