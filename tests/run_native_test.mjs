import { spawnSync } from "node:child_process";
import process from "node:process";

const [executable, ...args] = process.argv.slice(2);
if (executable === undefined) throw new Error("native test executable is required");

const executablePath = process.platform === "win32" && !executable.endsWith(".exe") ? `${executable}.exe` : executable;
const result = spawnSync(executablePath, args, { stdio: "inherit" });
if (result.error) throw result.error;
process.exitCode = result.status ?? 1;
