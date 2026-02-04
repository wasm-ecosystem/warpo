import path from "node:path";

const __dirname = import.meta.dirname;

/**
 * @type {import("../../../config.d.ts").Config}
 */
export default {
  include: [__dirname],
  isolated: true,
  imports(runtime) {
    return {
      env: {
        log: (msg) => {
          runtime.framework.log(runtime.exports.__getString(msg));
        },
      },
    };
  },
  temp: path.join(__dirname, "tmp"),
  output: path.join(__dirname, "tmp"),
  mode: [],
};
