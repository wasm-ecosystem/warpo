import expect from "expect";
import { env } from "node:process";
import { describe, it } from "node:test";
import { main as warpoMain } from "../../../dist/warpo_internal.js";

const __dirname = import.meta.dirname;
const projectRoot = __dirname;

describe("driver: missing-target", () => {
  it("reports missing target", async () => {
    let stdout = [];
    const code = await warpoMain({
      argv: ["build", "--target", "miss"],
      env: { ...env, FORCE_COLOR: "0" },
      cwd: projectRoot,
      onStdout: (data) => {
        stdout.push(data);
      },
    });

    expect(code).not.toBe(0);
    expect(stdout.join("")).toContain(
      "ERROR: Target 'miss' not found in asconfig.json. Available targets: debug, release."
    );
  });
});
