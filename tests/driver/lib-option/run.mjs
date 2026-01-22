import { execSync } from "node:child_process";
import { mkdirSync, readFileSync } from "node:fs";
import path from "node:path";
import { instantiate } from "@assemblyscript/loader";

const __dirname = import.meta.dirname;
const projectRoot = __dirname;

const warpoRoot = path.join(__dirname, "..", "..", "..");
const binary = path.join(warpoRoot, "build", "warpo", "warpo_asc");

/**
 * @param {Object} param
 * @param {string} param.targetName
 * @param {string[]} param.extraArgs
 * @returns {string}
 */
function runBuild({ targetName, extraArgs }) {
  const configPath = path.join(projectRoot, "asconfig.json");
  const config = JSON.parse(readFileSync(configPath, "utf8"));
  const outputWasm = path.join(projectRoot, config.targets[targetName].outFile);

  mkdirSync(path.dirname(outputWasm), { recursive: true });

  execSync(`${binary} --config ${configPath} --target ${targetName} ${extraArgs.join(" ")}`, {
    cwd: projectRoot,
    stdio: "inherit",
  });

  return outputWasm;
}

const builds = [
  runBuild({
    targetName: "opt",
    extraArgs: [],
  }),
  runBuild({
    targetName: "cli",
    extraArgs: ["--lib", "assembly/lib1.ts", "assembly/libs"],
  }),
];

for (const outputWasm of builds) {
  const m = await instantiate(readFileSync(outputWasm));
  m.exports._start();
}
