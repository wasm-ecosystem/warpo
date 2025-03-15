const { spawnSync } = require("child_process");
const { join } = require("path");
const { exit, env, argv } = require("process");
const platform = require("os").platform();

if (platform === "linux") {
  spawnSync(join(__dirname, "linux/warpo"), argv.slice(2), { env, stdio: "inherit" });
} else if (platform === "darwin") {
  spawnSync(join(__dirname, "macos/warpo"), argv.slice(2), { env, stdio: "inherit" });
} else {
  console.error("Unsupported platform");
  exit(1);
}
