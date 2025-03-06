#! /usr/bin/env node

import { execSync } from "node:child_process";
import { existsSync } from "node:fs";

const env = process.env;
const execConfig = { encoding: "utf8", stdio: "inherit", env };

function initEmscripten() {
  const sdkPath = "third_party/emsdk";

  env["PATH"] = `${sdkPath}/:` + env["PATH"];
  if (!existsSync(`${sdkPath}/upstream/emscripten`)) {
    execSync("emsdk install 4.0.4", execConfig);
    execSync("emsdk activate 4.0.4", execConfig);
  }
  env["PATH"] = `${sdkPath}/upstream/bin/:${sdkPath}/upstream/emscripten/:` + env["PATH"];
}

initEmscripten();

const args = [].join(" ");
execSync(`emcmake cmake -B build_wasm -S . ${args}`, execConfig);
execSync("cmake --build build_wasm --parallel", execConfig);
