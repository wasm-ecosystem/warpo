import path from "node:path";

const __dirname = import.meta.dirname;

/**
 * @type {import("../../../dist/interface.d.ts").TestOption}
 */
export default {
  include: [__dirname],
  temp: path.join(__dirname, "tmp"),
  output: path.join(__dirname, "tmp"),
  mode: [],
};
