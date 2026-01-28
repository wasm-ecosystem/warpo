/** @type {import("assemblyscript-unittest-framework/config.d.ts").Config} */
export default {
  include: [
    "tests/assemblyscript",
    "tests/warpo_extension",
    "assemblyscript/src/**/*.ts",
    "warpo_extension/std/warpo/**/*.ts",
  ],
  entryFiles: ["assemblyscript/src/glue/wasm/index.ts", "assemblyscript/src/index-wasm.ts"],
  collectCoverage: false,
  temp: "build_coverage",
  output: "build_coverage",
};
