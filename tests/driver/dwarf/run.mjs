import path from "node:path";
import { openAsBlob, readFileSync } from "node:fs";
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
const expectWat = path.join(projectRoot, "build", "out.wat");
const outputWat = isUpdateMode ? expectWat : path.join(projectRoot, "tmp", "out.wat");
const outputWasm = outputWat.replace(/wat$/g, "wasm");

describe("driver: dwarf", { concurrency: true }, () => {
  it("builds and matches snapshot", async () => {
    const code = await warpoMain({
      argv: ["build", entry, "-o", outputWat],
      env,
      cwd: projectRoot,
    });
    expect(code).toBe(0);

    if (!isUpdateMode) {
      const expected = readFileSync(expectWat, "utf8");
      const actual = readFileSync(outputWat, "utf8");
      if (expected !== actual) throw new Error(diff("out.wat", expected, actual) ?? "snapshot mismatch");
    }

    let wasm = new WebAssembly.Module(await (await openAsBlob(outputWasm)).arrayBuffer());
    // FIXME: according to https://github.com/WebAssembly/tool-conventions/blob/main/Debugging.md, embedding dwarf custom section name should start with ".debug"
    expect(WebAssembly.Module.customSections(wasm, "debug_info").length).toBe(1);
    expect(WebAssembly.Module.customSections(wasm, "debug_abbrev").length).toBe(1);
    expect(WebAssembly.Module.customSections(wasm, "debug_str").length).toBe(1);
  });
});
