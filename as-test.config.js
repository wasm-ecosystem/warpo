/** @type {import("assemblyscript-unittest-framework/config.d.ts").Config} */
export default {
  include: ["tests/assemblyscript", "assemblyscript/src/**.ts"],
  entryFiles: ["assemblyscript/src/glue/wasm/index.ts", "assemblyscript/src/index-wasm.ts"],
  collectCoverage: false,
  temp: "build_coverage",
  output: "build_coverage",
};
