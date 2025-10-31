import { execSync } from "node:child_process";
import { join } from "node:path";

execSync("../../../build/warpo/warpo_asc -p . assembly/index.ts -o build/module-resolve.wat", {
  cwd: join(__dirname, "module-resolve"),
});
