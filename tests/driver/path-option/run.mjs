import { mkdirSync, readFileSync } from "node:fs";
import path from "node:path";
import { describe, it } from "node:test";
import expect from "expect";
import { main as warpoMain } from "../../../dist/warpo_internal.js";

const __dirname = import.meta.dirname;
const projectRoot = __dirname;

const entry = path.join(projectRoot, "assembly", "index.ts");
const searchPath = path.join(projectRoot, "paths");
const outputDir = path.join(projectRoot, "tmp");
const missingPathWat = path.join(outputDir, "path-option-missing.wat");
const resolvedPathWat = path.join(outputDir, "path-option.wat");

mkdirSync(outputDir, { recursive: true });

describe("driver: path-option", () => {
  it("resolves packages from explicit --path search roots", { concurrency: false }, async () => {
    const code = await warpoMain({
      argv: ["build", entry, "-o", resolvedPathWat, "--path", searchPath, "--enable-feature", "tail-call"],
    });
    expect(code).toBe(0);

    const output = readFileSync(resolvedPathWat, "utf8");
    expect(output).toContain("$~lib/@as/custom/lib/index/v");
  });
});
