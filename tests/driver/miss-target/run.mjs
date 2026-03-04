import { env } from "node:process";
import { describe, it } from "node:test";
import expect from "expect";
import { main as warpoMain } from "../../../dist/warpo.js";

const __dirname = import.meta.dirname;
const projectRoot = __dirname;

describe("driver: compilation-failed", () => {
  it("reports missing target", async () => {
    const code = await warpoMain({
      argv: ["build", "--target", "miss"],
      env: { ...env, FORCE_COLOR: "0" },
      cwd: projectRoot,
    });

    expect(code).not.toBe(0);
    // expect(stdout).toContain("ERROR: Target 'miss' not found in asconfig.json. Available targets: debug, release.");
  });
});
