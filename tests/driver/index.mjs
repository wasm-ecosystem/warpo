import { readdir } from "node:fs/promises";
import { join } from "node:path";

const __dirname = import.meta.dirname;

async function importRunFiles() {
  const entries = await readdir(__dirname, { withFileTypes: true });
  for (const entry of entries) {
    if (entry.isDirectory()) {
      const runFile = join(__dirname, entry.name, "run.mjs");
      console.log(`importing: ${runFile}`);
      await import(runFile);
    }
  }
}

importRunFiles();
