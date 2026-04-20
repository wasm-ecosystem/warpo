import { execFileSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, rmSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { executeFixture } from "./wasmExecutor.js";

const TESTS_DIR = dirname(fileURLToPath(import.meta.url));

export const PROJECT_ROOT = resolve(TESTS_DIR, "../../..");
export const WARPO_ASC = resolve(PROJECT_ROOT, "build/warpo/warpo_asc");
export const FIXTURE_SRC = resolve(TESTS_DIR, "fixture/dwarfFixture.ts");
export const FIXTURE_BUILD_DIR = resolve(TESTS_DIR, "fixture/build");
export const FIXTURE_WASM = resolve(FIXTURE_BUILD_DIR, "dwarfFixture.wasm");
export const FIXTURE_DUMP = resolve(FIXTURE_BUILD_DIR, "example.dump");
export const CLASS_PREFIX = "tools/heap_analyzer/tests/fixture/dwarfFixture/";

export const canRunIntegration = existsSync(WARPO_ASC);

/**
 * Always registers the test suite. If warpo_asc is missing, the suite
 * fails immediately instead of being silently skipped.
 */
export function describeIntegration(name: string, fn: () => void): void {
  describe(name, () => {
    beforeAll(() => {
      if (!canRunIntegration) {
        throw new Error(
          `Integration test "${name}" requires warpo_asc at ${WARPO_ASC}. ` + `Please build with: npm run build:cpp`
        );
      }
    });
    afterAll(() => {
      rmSync(FIXTURE_BUILD_DIR, { recursive: true, force: true });
    });
    fn();
  });
}

function ensureBuildDir(): void {
  if (!existsSync(FIXTURE_BUILD_DIR)) {
    mkdirSync(FIXTURE_BUILD_DIR, { recursive: true });
  }
}

export function compileFixture(): void {
  ensureBuildDir();
  execFileSync(WARPO_ASC, [FIXTURE_SRC, "-o", FIXTURE_WASM, "--debug", "--exportRuntime"], {
    cwd: PROJECT_ROOT,
    stdio: "pipe",
  });
}

export function loadFixtureWasm(): Uint8Array {
  return new Uint8Array(readFileSync(FIXTURE_WASM));
}

export function generateFixtureDump(): void {
  ensureBuildDir();
  executeFixture(FIXTURE_WASM, PROJECT_ROOT);
}

export function loadFixtureDumpBuffer(): ArrayBuffer {
  const buf = readFileSync(FIXTURE_DUMP);
  return buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.byteLength);
}
