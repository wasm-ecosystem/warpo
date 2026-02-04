import path from "node:path";

const __dirname = import.meta.dirname;

/**
 * @type {import("../../../config.d.ts").Config}
 */
export default {
  include: [__dirname],
  temp: path.join(__dirname, "tmp"),
  output: path.join(__dirname, "tmp"),
  mode: [],
  isolated: true,
};
