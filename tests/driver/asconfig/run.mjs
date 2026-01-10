import { execSync } from "node:child_process";
import { mkdirSync, readFileSync } from "node:fs";
import path from "node:path";
import { argv, exit } from "node:process";
import { instantiate } from "@assemblyscript/loader";
import { diff } from "../diff.js";

const __dirname = import.meta.dirname;
const projectRoot = __dirname;

const isUpdateMode = argv.includes("--update") || argv.includes("-u");

const warpoRoot = path.join(__dirname, "..", "..", "..");
const binary = path.join(warpoRoot, "build", "warpo", "warpo_asc");
const configPath = path.join(projectRoot, "asconfig.json");
const expectWat = path.join(projectRoot, "build", "asconfig.wat");
const outputWat = isUpdateMode ? expectWat : path.join(projectRoot, "tmp", "asconfig.wat");
const outputWasm = outputWat.replace(/wat$/g, "wasm");

mkdirSync(path.dirname(outputWat), { recursive: true });
mkdirSync(path.dirname(outputWasm), { recursive: true });

execSync(`${binary} --config ${configPath} --target release -o ${outputWat}`, {
  cwd: projectRoot,
  stdio: "inherit",
});

if (!isUpdateMode) {
  const oldOutput = readFileSync(expectWat, "utf8");
  const newOutput = readFileSync(outputWat, "utf8");
  if (oldOutput !== newOutput) {
    console.log(diff("asconfig.wat", oldOutput, newOutput));
    exit(1);
  }
}

const m = await instantiate(readFileSync(outputWasm));
if (!("__new" in m.exports)) {
  console.error("expected runtime exports when using release target");
  exit(1);
}
m.exports._start();
