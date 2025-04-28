import { execSync, execFileSync } from "child_process";
import { join } from "path";
import { exit, env, argv } from "process";
import { platform } from "os";

if (platform === "linux") {
  execSync("chmod +x " + join(__dirname, "linux/warpo"));
  execFileSync(join(__dirname, "linux/warpo"), argv.slice(2), { env, stdio: "inherit" });
} else if (platform === "darwin") {
  execSync("chmod +x " + join(__dirname, "macos/warpo"));
  execFileSync(join(__dirname, "macos/warpo"), argv.slice(2), { env, stdio: "inherit" });
} else {
  console.error("Unsupported platform");
  exit(1);
}
