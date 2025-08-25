import { execSync } from "node:child_process";
import { libraryFiles } from "../../assemblyscript/cli/index.generated.js";
import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const project_root = join("..", "..");

execSync("node scripts/build.js", { cwd: join(project_root, "assemblyscript") });

writeFileSync(
  join(project_root, "build-as/library_sources.inc"),
  Object.keys(libraryFiles)
    .map((fileName) => `{\n  "${fileName}", R"##(${libraryFiles[fileName]})##",\n},\n`)
    .join("")
);

execSync("npx asc --config asconfig.json --target debug", { cwd: project_root });

execSync("npx asc --config asconfig.json --target debug", { cwd: project_root });

const wasmBuf = readFileSync(join(project_root, "build-as/assemblyscript.debug.wasm"));
const wasmBytes = Array.from(wasmBuf)
  .map((byte) => "0x" + byte.toString(16).padStart(2, "0"))
  .join(", ");
writeFileSync(
  join(project_root, "build-as/assemblyscript.inc"),
  `
unsigned char asc_wasm[] = {${wasmBytes}};
unsigned int asc_wasm_len = {${wasmBuf.length}};
  `
);
