/** @type {import("./dist/test_runner/interface").Config} */
export default {
  include: [
    "tests/assemblyscript",
    "tests/warpo_extension",
    "assemblyscript/src/**/*.ts",
    "warpo_extension/std/warpo/**/*.ts",
  ],
  entryFiles: ["assemblyscript/src/glue/wasm/index.ts", "assemblyscript/src/index-wasm.ts"],
  collectCoverage: false,
  output: "build_coverage",
};
