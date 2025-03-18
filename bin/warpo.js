const { execSync, execFileSync } = require("child_process");
const { join } = require("path");
const { exit, env, argv } = require("process");
const platform = require("os").platform();

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
