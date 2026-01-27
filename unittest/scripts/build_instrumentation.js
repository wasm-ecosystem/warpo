import { execSync } from "node:child_process";
import { existsSync, copyFileSync } from "node:fs";
import { join, resolve } from "node:path";

const env = process.env;

// Parse command-line arguments
const args = process.argv.slice(2);
let parallelJobs = ""; // Default: no value for --parallel
const jIndex = args.indexOf("-j");
if (jIndex !== -1 && args[jIndex + 1]) {
  parallelJobs = args[jIndex + 1];
}

function initEmscripten() {
  const sdkPath = resolve("third_party/emsdk/");
  const emscriptenPath = join(sdkPath, "upstream", "emscripten");

  env["PATH"] += `${process.platform === "win32" ? ";" : ":"}${sdkPath}`;
  if (!existsSync(emscriptenPath)) {
    execSync("emsdk install 3.1.32", { encoding: "utf8", stdio: "inherit", env });
    execSync("emsdk activate 3.1.32", { encoding: "utf8", stdio: "inherit", env });
  }
  env["PATH"] += `${process.platform === "win32" ? ";" : ":"}${emscriptenPath}`;
}

initEmscripten();

execSync("emcmake cmake -G Ninja -B build_wasm -S .", { encoding: "utf8", stdio: "inherit", env });
execSync(`cmake --build build_wasm --parallel ${parallelJobs} --target wasm-instrumentation`, {
  encoding: "utf8",
  stdio: "inherit",
  env,
});

copyFileSync("instrumentation/wasm-instrumentation.d.ts", "build_wasm/bin/wasm-instrumentation.d.ts");
