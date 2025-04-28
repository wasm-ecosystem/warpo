import assert from "node:assert";
import { spawnSync } from "node:child_process";
import { diffTrimmedLines } from "diff";
import fs from "node:fs";
import fsp from "node:fs/promises";
import path from "node:path";
import { argv } from "node:process";
import { fileURLToPath } from "node:url";

let isDebugMode = argv.includes("--debug");
let isCreateMode = argv.includes("--create");
let caseRegex = argv.includes("--case") ? argv[argv.indexOf("--case") + 1] : null;
let buildDir = argv.includes("--build-dir") ? argv[argv.indexOf("--build-dir") + 1] : "build";

function cmd(program, args) {
  if (isDebugMode) console.log(`${program} ${args.map((arg) => `'${arg}'`).join(" ")}`);
  const config = { encoding: "utf8" };
  let spawnResult = spawnSync(program, args, config);
  if (spawnResult.status !== 0) {
    console.error(spawnResult.stdout);
    console.error(spawnResult.stderr);
    console.error(spawnResult.error);
    process.exit(1);
  }
  if (isDebugMode && spawnResult.stdout.length > 0) {
    console.log(spawnResult.stdout);
  }
  return;
}

export async function run(currentFolder) {
  const folderConfig = JSON.parse(await fsp.readFile(path.join(currentFolder, "config.json"), { encoding: "utf8" }));

  async function getAllFiles(folder, filter) {
    return (await fsp.readdir(folder))
      .map((file) => path.join(folder, file))
      .filter(filter)
      .filter((file) => fs.statSync(file).isFile());
  }

  async function runTest(file) {
    const filePathWithoutExt = file.slice(0, -path.extname(file).length);

    const code = await fsp.readFile(file, { encoding: "utf8" });
    let fileConfigStr = code.slice(0, code.indexOf("\n") + 1);
    assert(fileConfigStr.startsWith("//!"), "config should start with //!");
    fileConfigStr = fileConfigStr.slice(3).trim();
    console.log(`run test in '${file}' with '${fileConfigStr}'`);
    const fileConfig = JSON.parse(fileConfigStr);

    const originalWatPath = `${filePathWithoutExt}.input.wast`;
    const baseOutputPath = `${filePathWithoutExt}.base.wat`;
    const lowerOutputPath = `${filePathWithoutExt}.opt.wat`;

    const inputArgs = ["-i", originalWatPath];
    const optArgs = ["--pass", folderConfig.optPass, "-o", lowerOutputPath];
    const baseArgs = ["--pass", folderConfig.basePass, "-o", baseOutputPath];

    const functionFilter = fileConfig.func ? ["--func", fileConfig.func] : [];

    cmd("node", ["assemblyscript/bin/asc.js", file, "-t", originalWatPath]);
    cmd(`${buildDir}/tools/test_runner/warpo_test_runner`, [...inputArgs, ...optArgs, ...functionFilter]);
    cmd(`${buildDir}/tools/test_runner/warpo_test_runner`, [...inputArgs, ...baseArgs, ...functionFilter]);

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

    if (!fs.existsSync(outputPath) || isCreateMode) {
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
  const files = await getAllFiles(currentFolder, (file) => {
    if (caseRegex) return file.endsWith(".ts") && new RegExp(caseRegex).test(file);
    return file.endsWith(".ts");
  });
  await Promise.all(files.map(runTest));
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

["gc_leaf_filter", "gc_lower", "gc_reuse_stack", "gc_ssa_merge"].forEach((task) => {
  run(path.join(__dirname, task));
});
