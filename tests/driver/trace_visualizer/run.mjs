import { existsSync, mkdirSync, rmSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import { describe, it } from "node:test";
import expect from "expect";
import { traceVisualizer } from "../../../dist/scripts/lib.js";

const __dirname = import.meta.dirname;
const tmpDir = join(__dirname, "tmp");

if (existsSync(tmpDir)) {
  rmSync(tmpDir, { recursive: true, force: true });
}
mkdirSync(tmpDir, { recursive: true });

function createBinaryTraceFile(filePath, records) {
  const header = Buffer.from("___WARP_TRACE___", "ascii");
  const recordBuffers = records.map(([uuid, counter, fnId]) => {
    const buf = Buffer.alloc(16);
    buf.writeBigUInt64LE(BigInt(uuid), 0);
    buf.writeUInt32LE(counter, 8);
    buf.writeInt32LE(fnId, 12);
    return buf;
  });
  writeFileSync(filePath, Buffer.concat([header, ...recordBuffers]));
}

describe("driver: trace_visualizer", () => {
  it("visualizes trace with single mapping file", async () => {
    const recordFile = join(tmpDir, "single_record.bin");
    const mappingFile = join(tmpDir, "single_mapping.txt");
    const outputFile = join(tmpDir, "single_trace.pftrace");

    writeFileSync(mappingFile, "1 main\n2 worker\n", "utf8");
    createBinaryTraceFile(recordFile, [
      [1, 100, 1],
      [1, 200, 2],
      [1, 300, -2],
      [1, 400, -1],
    ]);

    const code = await traceVisualizer({
      argv: [
        "--trace-point-mapping-file",
        mappingFile,
        "--trace-point-record-file",
        recordFile,
        "--output-pftrace-file",
        outputFile,
        "--count-to-perfetto-timestamp-rate",
        "1.0",
      ],
    });

    expect(code).toBe(0);
    expect(existsSync(outputFile)).toBe(true);
  });

  it("visualizes multi-trace with JSON mapping file", async () => {
    const recordFile = join(tmpDir, "multi_record.bin");
    const map1 = join(tmpDir, "mod1_mapping.txt");
    const map2 = join(tmpDir, "mod2_mapping.txt");
    const jsonFile = join(tmpDir, "trace_mapping.json");
    const outputFile = join(tmpDir, "multi_trace.pftrace");

    writeFileSync(map1, "1 mod1_main\n", "utf8");
    writeFileSync(map2, "1 mod2_worker\n", "utf8");
    writeFileSync(
      jsonFile,
      JSON.stringify({
        10: {
          moduleName: "PipelineModule1",
          mappingFile: "mod1_mapping.txt",
        },
        "0x14": {
          moduleName: "PipelineModule2",
          tracePointMappingFile: "mod2_mapping.txt",
        },
      }),
      "utf8"
    );

    createBinaryTraceFile(recordFile, [
      [10, 100, 1],
      [20, 150, 1],
      [10, 250, -1],
      [20, 300, -1],
    ]);

    const code = await traceVisualizer({
      argv: [
        "--trace-point-mapping-json-file",
        jsonFile,
        "--trace-point-record-file",
        recordFile,
        "--output-pftrace-file",
        outputFile,
        "--count-to-perfetto-timestamp-rate",
        "1.0",
      ],
    });

    expect(code).toBe(0);
    expect(existsSync(outputFile)).toBe(true);
  });

  it("fails when both single mapping and json mapping are provided", async () => {
    const recordFile = join(tmpDir, "mutex_record.bin");
    const mappingFile = join(tmpDir, "single_mapping.txt");
    const jsonFile = join(tmpDir, "trace_mapping.json");
    const outputFile = join(tmpDir, "mutex_out.pftrace");

    createBinaryTraceFile(recordFile, [[1, 100, 1]]);

    const code = await traceVisualizer({
      argv: [
        "--trace-point-mapping-file",
        mappingFile,
        "--trace-point-mapping-json-file",
        jsonFile,
        "--trace-point-record-file",
        recordFile,
        "--output-pftrace-file",
        outputFile,
      ],
    });

    expect(code).not.toBe(0);
  });

  it("fails when neither single mapping nor json mapping is provided", async () => {
    const recordFile = join(tmpDir, "nomap_record.bin");
    const outputFile = join(tmpDir, "nomap_out.pftrace");

    createBinaryTraceFile(recordFile, [[1, 100, 1]]);

    const code = await traceVisualizer({
      argv: ["--trace-point-record-file", recordFile, "--output-pftrace-file", outputFile],
    });

    expect(code).not.toBe(0);
  });
});
