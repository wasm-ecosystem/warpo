import { fileURLToPath } from "url";
import { dirname, resolve, join } from "path";
import { existsSync } from "fs";

async function findProjectRoot(importMetaUrl: string) {
  const filePath = fileURLToPath(importMetaUrl);
  let currentDir = dirname(filePath);

  while (currentDir !== "/") {
    const packageJsonPath = join(currentDir, "package.json");
    if (existsSync(packageJsonPath)) {
      return currentDir;
    }
    currentDir = resolve(currentDir, "..");
  }

  throw new Error("Could not find project root");
}

export const projectRoot = await findProjectRoot(import.meta.url);
console.log(`WARPO Project root: ${projectRoot}`);
