import { execSync } from "node:child_process";
import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import assert from "node:assert";

const build_target = process.argv[2];
assert(build_target === "debug" || build_target === "release", "invalid build target");

const project_root = join("..", "..");

execSync("node scripts/build.js", { cwd: join(project_root, "assemblyscript") });

const { libraryFiles } = await import("../../assemblyscript/cli/index.generated.js");
writeFileSync(
  join(project_root, "build-as/library_sources.inc"),
  Object.keys(libraryFiles)
    .map((fileName) => `{\n  "${fileName}", R"##(${libraryFiles[fileName]})##",\n},\n`)
    .join("")
);

execSync(`npx asc --config asconfig.json --target ${build_target}`, { cwd: project_root });

const wasmBuf = readFileSync(join(project_root, `build-as/assemblyscript.${build_target}.wasm`));
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

console.log(`AS wasm size: ${wasmBuf.length} bytes`);
