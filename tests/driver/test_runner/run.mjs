import { readFileSync, writeFileSync } from "node:fs";
import path from "node:path";
import { describe, it } from "node:test";
import expect from "expect";
import { diff } from "../diff.js";
import { exec } from "node:child_process";

const __dirname = import.meta.dirname;
const repoRoot = path.resolve(__dirname, "../../..");

const isUpdateMode = process.argv.includes("--update") || process.argv.includes("-u");

async function runAsTest({ name, args = [] }) {
  const caseRoot = path.join("tests", "driver", "test_runner", name);
  return new Promise((resolve) => {
    exec(
      `node ${repoRoot}/dist/warpo.js test ${args.join(" ")}`,
      {
        cwd: caseRoot,
        env: { ...process.env, FORCE_COLOR: "0" },
      },
      (error, stdout, stderr) => {
        resolve({ code: error ? error.code : 0, stdout, stderr });
      }
    );
  });
}

function checkStdoutSnapshot(name, stdout, stderr) {
  const snapshotPath = path.join(repoRoot, "tests", "driver", "test_runner", name, "stdout.txt");

  if (isUpdateMode) {
    writeFileSync(snapshotPath, stdout, "utf8");
    return;
  }

  const expected = readFileSync(snapshotPath, "utf8");
  stdout = stdout.replace(/\r\n/g, "\n");
  if (expected === stdout) return;

  const d =
    diff(path.join("tests", "driver", "test_runner", name, "stdout.txt"), expected, stdout) ?? "snapshot mismatch";
  throw new Error(`${d}\n---- stderr ----\n${stderr}`);
}

describe("test runner", () => {
  it("assertFailed", async () => {
    const { code, stdout, stderr } = await runAsTest({ name: "assertFailed" });
    checkStdoutSnapshot("assertFailed", stdout, stderr);
    expect(code).toBe(1);
  });

  it("compilationFailed", async () => {
    const { code, stdout, stderr } = await runAsTest({ name: "compilationFailed" });
    checkStdoutSnapshot("compilationFailed", stdout, stderr);
    expect(code).toBe(2);
  });

  it("on-failure-only", async () => {
    let mergedStdout = "";
    let mergedStderr = "";

    {
      const { stdout, stderr } = await runAsTest({ name: "on-failure-only" });
      mergedStdout += stdout;
      mergedStderr += stderr;
    }

    mergedStdout += "\n";
    mergedStderr += "\n";

    {
      const { stdout, stderr } = await runAsTest({ name: "on-failure-only", args: ["--onlyFailures"] });
      mergedStdout += stdout;
      mergedStderr += stderr;
    }

    checkStdoutSnapshot("on-failure-only", mergedStdout, mergedStderr);
  });

  it("printLogInFailedInfo", async () => {
    const { code, stdout, stderr } = await runAsTest({ name: "printLogInFailedInfo" });
    checkStdoutSnapshot("printLogInFailedInfo", stdout, stderr);
    expect(code).toBe(1);
  });

  it("setup-teardown", async () => {
    const { code, stdout, stderr } = await runAsTest({ name: "setup-teardown" });
    checkStdoutSnapshot("setup-teardown", stdout, stderr);
    expect(code).toBe(1);
  });

  it("testFiles", async () => {
    const { code, stdout, stderr } = await runAsTest({
      name: "testFiles",
      args: ["--testFiles", "succeed_0.test.ts", "succeed_1.test.ts"],
    });
    checkStdoutSnapshot("testFiles", stdout, stderr);
    expect(code).toBe(0);
  });
});
