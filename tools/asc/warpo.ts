import { execSync, execFileSync } from "node:child_process";
import { join } from "node:path";
import { env } from "node:process";
import { platform } from "node:os";
import { projectRoot } from "./project_root.js";

export function runWarpo(inputWast: string, outputWasm: string): void {
  console.log("WARPO optimization stage");
  let platformPath;
  if (platform() === "linux") {
    platformPath = "linux";
  } else if (platform() === "darwin") {
    platformPath = "macos";
  } else {
    throw new Error("Unsupported platform");
  }
  const warpoPath = join(projectRoot, "bin", platformPath, "warpo");
  execSync("chmod +x " + warpoPath);
  execFileSync(warpoPath, ["-i", inputWast, "-o", outputWasm], { env, stdio: "inherit" });
}
