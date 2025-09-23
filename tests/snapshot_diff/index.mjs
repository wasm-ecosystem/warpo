import assert from "node:assert";
import { spawn, spawnSync } from "node:child_process";
import { diffTrimmedLines } from "diff";
import fs from "node:fs";
import fsp from "node:fs/promises";
import path from "node:path";
import { argv } from "node:process";
import { fileURLToPath } from "node:url";
import { cpus } from "node:os";

const isDebugMode = argv.includes("--debug");
const isUpdateMode = argv.includes("--update") || argv.includes("-u");
const caseRegex = argv.includes("--case") ? argv[argv.indexOf("--case") + 1] : null;
const buildDir = argv.includes("--build-dir") ? argv[argv.indexOf("--build-dir") + 1] : "build";

async function cmd(program, args) {
  if (isDebugMode) console.log(`${program} ${args.map((arg) => `'${arg}'`).join(" ")}`);
  try {
    await new Promise((resolve, reject) => {
      let s = spawn(program, args);
      s.on("close", (code) => {
        if (code !== 0) {
          reject(new Error(`Command failed with exit code ${code}`));
        } else {
          resolve();
        }
      });
      s.on("error", (err) => {
        reject(err);
      });
      if (isDebugMode) {
        s.stdout.on("data", (data) => {
          process.stdout.write(data);
        });
      }
      s.stderr.on("data", (data) => {
        process.stderr.write(data);
      });
    });
  } catch (e) {
    console.error(`Error occurred while executing command: ${e.message}`);
  }
}

class TestCase {
  file;
  folderConfig;
  constructor(file, folderConfig) {
    this.file = file;
    this.folderConfig = folderConfig;
  }

  async runTest() {
    const filePathWithoutExt = this.file.slice(0, -path.extname(this.file).length);

    const code = await fsp.readFile(this.file, { encoding: "utf8" });
    let fileConfigStr = code.slice(0, code.indexOf("\n") + 1);
    assert(fileConfigStr.startsWith("//!"), "config should start with //!");
    fileConfigStr = fileConfigStr.slice(3).trim();
    console.log(`run test in '${this.file}' with '${fileConfigStr}'`);
    const fileConfig = JSON.parse(fileConfigStr);

    const originalWatPath = `${filePathWithoutExt}.input.wast`;
    const baseOutputPath = `${filePathWithoutExt}.base.wat`;
    const lowerOutputPath = `${filePathWithoutExt}.opt.wat`;

    const inputArgs = ["-i", originalWatPath];
    const optArgs = [...this.folderConfig.optPass, "-o", lowerOutputPath];
    const baseArgs = [...this.folderConfig.basePass, "-o", baseOutputPath];

    const functionFilter = fileConfig.func ? ["--func", fileConfig.func] : [];

    await cmd("build/warpo/warpo_compiler", [this.file, "-t", originalWatPath]);
    await cmd(`${buildDir}/tools/test_runner/warpo_test_runner`, [...inputArgs, ...optArgs, ...functionFilter]);
    await cmd(`${buildDir}/tools/test_runner/warpo_test_runner`, [...inputArgs, ...baseArgs, ...functionFilter]);

    originalWatPath;
    const commentLine = (l) => (l.startsWith("  ") ? `;;${l.slice(2)}` : l.length > 0 ? `;;${l}` : l);
    const commentLines = (lines) => lines.split("\n").map(commentLine).join("\n");
    const commentLinesForRemoved = (change) => (change.removed ? commentLines(change.value) : change.value);
    const getChangePrefix = (change) =>
      change.added ? ";; =========add========" : change.removed ? ";; ======remove=======" : ";; ====================";
    const diff = diffTrimmedLines(
      await fsp.readFile(baseOutputPath, "utf8"),
      await fsp.readFile(lowerOutputPath, "utf8"),
      {}
    )
      .map((change) => getChangePrefix(change) + "\n" + commentLinesForRemoved(change))
      .join("");
    if (!isDebugMode) {
      fsp.unlink(originalWatPath);
      fsp.unlink(lowerOutputPath);
      fsp.unlink(baseOutputPath);
    }

    const outputPath = `${filePathWithoutExt}.diff.wat`;

    if (!fs.existsSync(outputPath) || isUpdateMode) {
      console.log(`create new diff to ${outputPath}`);
      fsp.writeFile(outputPath, diff, "utf8");
      return;
    }
    const oldDiff = await fsp.readFile(outputPath, "utf8");
    if (oldDiff !== diff) {
      assert(
        false,
        `diff for ${file} is different from the previous one. Please run the test again to update the diff file.`
      );
    }
    return;
  }
}

export async function run(folder) {
  const folderConfig = JSON.parse(await fsp.readFile(path.join(folder, "config.json"), { encoding: "utf8" }));
  async function getAllFiles(folder, filter) {
    return (await fsp.readdir(folder))
      .map((file) => path.join(folder, file))
      .filter(filter)
      .filter((file) => fs.statSync(file).isFile());
  }
  const files = await getAllFiles(folder, (file) => {
    if (caseRegex) return file.endsWith(".ts") && new RegExp(caseRegex).test(file);
    return file.endsWith(".ts");
  });
  return files.map((file) => new TestCase(file, folderConfig));
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const tasks = (
  await Promise.all(
    [
      "advanced_inlining",
      "gc_lower_fast",
      "gc_lower_opt/base",
      "gc_lower_opt/leaf_filter",
      "gc_lower_opt/reuse_stack",
      "gc_lower_opt/shrink_wrap",
      "gc_lower_opt/shrink_wrap_leaf_filter",
      "gc_lower_opt/ssa_merge",
    ].map((task) => run(path.join(__dirname, task)))
  )
).flat();

const cpuCount = Math.max(cpus().length, 1);
const BATCH_SIZE = Math.floor(cpuCount * 1.2);
console.log(`Running ${tasks.length} tests with batch size ${BATCH_SIZE}...`);
for (let i = 0; i < tasks.length; i += BATCH_SIZE) {
  console.log(`\tRunning ${i}/${tasks.length}`);
  await Promise.all(tasks.slice(i, i + BATCH_SIZE).map(async (task) => await task.runTest()));
}
