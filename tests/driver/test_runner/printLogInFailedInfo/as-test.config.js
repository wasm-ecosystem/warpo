import os from "node:os";
import path from "node:path";
import { URL } from "node:url";

const __dirname = path.dirname(new URL(import.meta.url).pathname);

export default {
  include: [__dirname],
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
