import { execSync } from "node:child_process";
import path from "node:path";
import { argv, exit } from "node:process";
import { structuredPatch } from "diff";
import { readFileSync } from "node:fs";
import chalk from "chalk";
import { instantiate } from "@assemblyscript/loader";

const __dirname = import.meta.dirname;
const projectRoot = __dirname;

const isUpdateMode = argv.includes("--update") || argv.includes("-u");

const warpoRoot = path.join(__dirname, "..", "..", "..");
const binary = path.join(warpoRoot, "build", "warpo", "warpo_asc");
const entry = path.join(projectRoot, "assembly", "index.ts");
const expectWat = path.join(projectRoot, "build", "module-resolve.wat");
const outputWat = isUpdateMode ? expectWat : path.join(projectRoot, "tmp", "module-resolve.wat");
const outputWasm = outputWat.replace(/wat$/g, "wasm");

execSync(`${binary} --project ${projectRoot} ${entry} -o ${outputWat}`, {
  cwd: projectRoot,
  stdio: "inherit",
});

function diff(filename, expected, actual) {
  const patch = structuredPatch(filename, filename, expected, actual, "expected", "actual", { context: 5 });
  if (!patch.hunks.length) return null;
  const out = ["--- " + patch.oldHeader, "+++ " + patch.newHeader];
  for (const hunk of patch.hunks) {
    out.push("@@ -" + hunk.oldStart + "," + hunk.oldLines + " +" + hunk.newStart + "," + hunk.newLines + " @@");
    out.push(
      ...hunk.lines.map((line) =>
        line.charAt(0) === "+" ? chalk.green(line) : line.charAt(0) === "-" ? (line = chalk.red(line)) : line
      )
    );
  }
  return out.join("\n") + "\n";
}

if (!isUpdateMode) {
  const oldOutput = readFileSync(expectWat, "utf8");
  const newOutput = readFileSync(outputWat, "utf8");
  if (oldOutput !== newOutput) {
    console.log(diff("module-resolve.wat", oldOutput, newOutput));
    exit(1);
  }
}

const m = await instantiate(readFileSync(outputWasm));
m.exports._start();
