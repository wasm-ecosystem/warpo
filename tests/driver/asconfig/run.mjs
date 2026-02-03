import { mkdirSync, readFileSync } from "node:fs";
import path from "node:path";
import { argv, env } from "node:process";
import { describe, it } from "node:test";
import { instantiate } from "@assemblyscript/loader";
import expect from "expect";
import { diff } from "../diff.js";
import asconfig from "./asconfig.json" with { type: "json" };
import { main as warpoMain } from "../../../dist/warpo.js";

const __dirname = import.meta.dirname;
const projectRoot = __dirname;

const isUpdateMode = argv.includes("--update") || argv.includes("-u");

const configPath = path.join(projectRoot, "asconfig.json");

const targetName = isUpdateMode ? "release-update" : "release";
const target = asconfig.targets[targetName];

const outputWasm = path.join(projectRoot, target.outFile);
const outputWat = path.join(projectRoot, target.outFile.replace(/wasm$/g, "wat"));

mkdirSync(path.dirname(outputWasm), { recursive: true });

describe("driver: asconfig", () => {
  it("builds and matches snapshot", { concurrency: false }, async () => {
    const code = await warpoMain({
      argv: ["build", "--config", configPath, "--target", targetName],
      env,
      cwd: projectRoot,
    });
    expect(code).toBe(0);

    if (!isUpdateMode) {
      const expectWat = path.join(projectRoot, "build", "asconfig.wat");
      const expected = readFileSync(expectWat, "utf8");
      const actual = readFileSync(outputWat, "utf8");
      if (expected !== actual) throw new Error(diff("asconfig.wat", expected, actual) ?? "snapshot mismatch");
    }

    const m = await instantiate(readFileSync(outputWasm));
    expect("__new" in m.exports).toBe(true);
    expect(() => m.exports._start()).not.toThrow();
  });
});
