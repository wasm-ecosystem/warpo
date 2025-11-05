import { readdir } from "node:fs/promises";
import { join } from "node:path";
import { pathToFileURL } from "node:url";

const __dirname = import.meta.dirname;

async function importRunFiles() {
  const entries = await readdir(__dirname, { withFileTypes: true });
  for (const entry of entries) {
    if (entry.isDirectory()) {
      const runFile = join(__dirname, entry.name, "run.mjs");
      const fileUrl = pathToFileURL(runFile).href;
      await import(fileUrl);
    }
  }
}

importRunFiles();
