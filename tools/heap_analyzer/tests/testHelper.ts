import { execFileSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, rmSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { platform } from "node:os";
import { before, after, describe } from "node:test";
import { executeFixture } from "./wasmExecutor.js";

const TESTS_DIR = dirname(fileURLToPath(import.meta.url));

export const PROJECT_ROOT = resolve(TESTS_DIR, "../../..");

const WARPO_ASC_NAME = platform() === "win32" ? "warpo_asc.exe" : "warpo_asc";
export const WARPO_ASC = resolve(PROJECT_ROOT, "build/warpo", WARPO_ASC_NAME);
export const FIXTURE_SRC = resolve(TESTS_DIR, "fixture/dwarfFixture.ts");
export const CLASS_PREFIX = "tools/heap_analyzer/tests/fixture/dwarfFixture/";

export const canRunIntegration = existsSync(WARPO_ASC);

export interface FixtureContext {
  compileFixture(): void;
  loadFixtureWasm(): Uint8Array;
  generateFixtureDump(): void;
  loadFixtureDumpBuffer(): ArrayBuffer;
}

function createFixtureContext(suiteName: string): FixtureContext {
  const buildDir = resolve(TESTS_DIR, `fixture/build-${suiteName}`);
  const wasmPath = resolve(buildDir, "dwarfFixture.wasm");
  const dumpPath = resolve(buildDir, "example.dump");

  function ensureBuildDir(): void {
    if (!existsSync(buildDir)) {
      mkdirSync(buildDir, { recursive: true });
    }
  }

  return {
    compileFixture() {
      ensureBuildDir();
      execFileSync(WARPO_ASC, [FIXTURE_SRC, "-o", wasmPath, "--debug", "--exportRuntime"], {
        cwd: PROJECT_ROOT,
        stdio: "pipe",
      });
    },
    loadFixtureWasm() {
      return new Uint8Array(readFileSync(wasmPath));
    },
    generateFixtureDump() {
      executeFixture(wasmPath, dumpPath);
    },
    loadFixtureDumpBuffer() {
      const buf = readFileSync(dumpPath);
      return buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.byteLength);
    },
  };
}

/**
 * Always registers the test suite. If warpo_asc is missing, the suite
 * fails immediately instead of being silently skipped.
 *
 * Each suite gets its own build directory to allow parallel execution.
 */
export function describeIntegration(name: string, fn: (ctx: FixtureContext) => void): void {
  const buildDir = resolve(TESTS_DIR, `fixture/build-${name}`);
  const ctx = createFixtureContext(name);

  describe(name, () => {
    before(() => {
      if (!canRunIntegration) {
        throw new Error(
          `Integration test "${name}" requires warpo_asc at ${WARPO_ASC}. ` + `Please build with: npm run build:cpp`
        );
      }
    });
    after(() => {
      rmSync(buildDir, { recursive: true, force: true });
    });
    fn(ctx);
  });
}
