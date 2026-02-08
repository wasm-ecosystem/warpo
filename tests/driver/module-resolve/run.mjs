import path from "node:path";
import { readFileSync } from "node:fs";
import { argv, env } from "node:process";
import { describe, it } from "node:test";
import { instantiate } from "@assemblyscript/loader";
import expect from "expect";
import { diff } from "../diff.js";
import { main as warpoMain } from "../../../dist/warpo.js";

const __dirname = import.meta.dirname;
const projectRoot = __dirname;

const isUpdateMode = argv.includes("--update") || argv.includes("-u");

const entry = path.join(projectRoot, "assembly", "index.ts");
const expectWat = path.join(projectRoot, "build", "module-resolve.wat");
const outputWat = isUpdateMode ? expectWat : path.join(projectRoot, "tmp", "module-resolve.wat");
const outputWasm = outputWat.replace(/wat$/g, "wasm");

describe("driver: module-resolve", () => {
  it("builds and matches snapshot", { concurrency: false }, async () => {
    const code = await warpoMain({
      argv: ["build", entry, "-o", outputWat],
      env,
      cwd: projectRoot,
    });
    expect(code).toBe(0);

    if (!isUpdateMode) {
      const expected = readFileSync(expectWat, "utf8");
      const actual = readFileSync(outputWat, "utf8");
      if (expected !== actual) throw new Error(diff("module-resolve.wat", expected, actual) ?? "snapshot mismatch");
    }

    const m = await instantiate(readFileSync(outputWasm));
    expect(() => m.exports._start()).not.toThrow();
  });
});
