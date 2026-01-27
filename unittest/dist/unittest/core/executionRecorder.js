import chalk from "chalk";
class LogRecorder {
    #currentTestLogMessages = [];
    #isTestFailed = false;
    addLog(msg) {
        this.#currentTestLogMessages.push(msg);
    }
    markTestFailed() {
        this.#isTestFailed = true;
    }
    reset() {
        this.#currentTestLogMessages = [];
        this.#isTestFailed = false;
    }
    onFinishTest() {
        if (this.#currentTestLogMessages.length === 0) {
            return null;
        }
        if (this.#isTestFailed === false) {
            return null;
        }
        return this.#currentTestLogMessages;
    }
}
export class ExecutionResult {
    total = 0;
    fail = 0;
    failedInfo = {};
    crashInfo = new Set();
    failedLogMessages = {};
}
class TestBlock {
    description;
    constructor(description) {
        this.description = description;
    }
    setupFunctions = [];
    teardownFunctions = [];
}
export class TestCase {
    functionIndex;
    fullName;
    setupFunctions;
    teardownFunctions;
    constructor(testBlockStack, functionIndex) {
        this.functionIndex = functionIndex;
        this.fullName = testBlockStack.map((block) => block.description).join(" ");
        this.setupFunctions = testBlockStack.flatMap((block) => block.setupFunctions);
        this.teardownFunctions = testBlockStack.flatMap((block) => block.teardownFunctions);
    }
}
export class ExecutionRecorder {
    result = new ExecutionResult();
    testBlockStack = [];
    testCases = [];
    currentExecutedTestCaseFullName = "";
    logRecorder = new LogRecorder();
    _addDescription(description) {
        this.testBlockStack.push(new TestBlock(description));
    }
    _removeDescription() {
        this.testBlockStack.pop();
    }
    get lastTestBlock() {
        return this.testBlockStack.at(-1);
    }
    // return false if error
    _registerSetup(functionIndex) {
        const lastTestBlock = this.lastTestBlock;
        if (lastTestBlock === undefined) {
            return false;
        }
        else {
            lastTestBlock.setupFunctions.push(functionIndex);
            return true;
        }
    }
    // return false if error
    _registerTeardown(functionIndex) {
        const lastTestBlock = this.lastTestBlock;
        if (lastTestBlock === undefined) {
            return false;
        }
        else {
            lastTestBlock.teardownFunctions.push(functionIndex);
            return true;
        }
    }
    _addTestCase(functionIndex) {
        this.testCases.push(new TestCase(this.testBlockStack, functionIndex));
    }
    _startTestFunction(fullName) {
        this.currentExecutedTestCaseFullName = fullName;
        this.logRecorder.reset();
    }
    _finishTestFunction() {
        const logMessages = this.logRecorder.onFinishTest();
        if (logMessages !== null) {
            this.result.failedLogMessages[this.currentExecutedTestCaseFullName] = (this.result.failedLogMessages[this.currentExecutedTestCaseFullName] || []).concat(logMessages);
        }
    }
    async runTestFunction(fullName, runner, exceptionHandler) {
        this._startTestFunction(fullName);
        try {
            const r = runner();
            if (r instanceof Promise) {
                await r;
            }
        }
        catch (error) {
            await exceptionHandler(error);
        }
        this._finishTestFunction();
    }
    notifyTestCrash(error) {
        this.logRecorder.addLog(`Reason: ${chalk.red(error.message)}`);
        this.logRecorder.addLog(error.stacks
            .map((stack) => `  at ${stack.functionName} (${stack.fileName}:${stack.lineNumber}:${stack.columnNumber})`)
            .join("\n"));
        this.result.crashInfo.add(this.currentExecutedTestCaseFullName);
        this.result.total++; // fake test cases
        this.#increaseFailureCount();
    }
    collectCheckResult(result, codeInfoIndex, actualValue, expectValue) {
        this.result.total++;
        if (!result) {
            this.#increaseFailureCount();
            const testCaseFullName = this.currentExecutedTestCaseFullName;
            const assertMessage = [codeInfoIndex.toString(), actualValue, expectValue];
            this.result.failedInfo[testCaseFullName] = this.result.failedInfo[testCaseFullName] || [];
            this.result.failedInfo[testCaseFullName].push(assertMessage);
        }
    }
    log(msg) {
        this.logRecorder.addLog(msg);
    }
    getCollectionFuncSet(arg) {
        return {
            addDescription: (description) => {
                this._addDescription(arg.exports.__getString(description));
            },
            removeDescription: () => {
                this._removeDescription();
            },
            registerTestFunction: (index) => {
                this._addTestCase(index);
            },
            registerBeforeEachFunction: (index) => {
                return this._registerSetup(index);
            },
            registerAfterEachFunction: (index) => {
                return this._registerTeardown(index);
            },
            collectCheckResult: (result, codeInfoIndex, actualValue, expectValue) => {
                this.collectCheckResult(result !== 0, codeInfoIndex, arg.exports.__getString(actualValue), arg.exports.__getString(expectValue));
            },
        };
    }
    #increaseFailureCount() {
        this.result.fail++;
        this.logRecorder.markTestFailed();
    }
}
//# sourceMappingURL=executionRecorder.js.map