import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";

const DUMP_MAGIC = new Uint8Array([0x41, 0x53, 0x48, 0x44]); // "A S H D"
const DUMP_VERSION = 1;
const HEADER_SIZE = 24;

interface AscExports extends WebAssembly.Exports {
  memory: WebAssembly.Memory;
  __data_end: WebAssembly.Global;
  __heap_base: WebAssembly.Global;
  __stack_pointer: WebAssembly.Global;
  _start: () => void;
}

function writeDump(exports: AscExports, outputPath: string): void {
  const raw = new Uint8Array(exports.memory.buffer);
  const dump = new Uint8Array(HEADER_SIZE + raw.byteLength);
  const view = new DataView(dump.buffer);

  dump.set(DUMP_MAGIC, 0);
  view.setUint32(4, DUMP_VERSION, true);
  view.setUint32(8, Number(exports.__data_end.value), true);
  view.setUint32(12, Number(exports.__heap_base.value), true);
  view.setUint32(16, Number(exports.__stack_pointer.value), true);
  dump.set(raw, HEADER_SIZE);

  mkdirSync(dirname(outputPath), { recursive: true });
  writeFileSync(outputPath, dump);
}

/**
 * Instantiate a compiled wasm fixture and run its `_start` entry point.
 * The injected `MemoryDump.dumpMemoryRegion` import writes a dump
 * file whose path is decoded (UTF-8) from linear memory.
 *
 * The fixture may abort after the dump is written (e.g. debug assertions);
 * such aborts are silently ignored.
 */
export function executeFixture(wasmPath: string, projectRoot: string): void {
  const wasmBytes = readFileSync(wasmPath);

  // eslint-disable-next-line prefer-const
  let exports: AscExports;

  const imports: WebAssembly.Imports = {
    env: {
      abort(message: number, fileName: number, line: number, column: number): void {
        throw new Error(`abort at ${line}:${column} (msg=${message}, file=${fileName})`);
      },
    },
    MemoryDump: {
      dumpMemoryRegion(offset: number, size: number): void {
        const guestPath = Buffer.from(exports.memory.buffer, offset, size).toString("utf8");
        writeDump(exports, resolve(projectRoot, guestPath));
      },
    },
  };

  const mod = new WebAssembly.Module(wasmBytes);
  const instance = new WebAssembly.Instance(mod, imports);
  exports = instance.exports as AscExports;

  exports._start();
}
