import path from "node:path";
import { URL } from "node:url";

const __dirname = import.meta.dirname;

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
