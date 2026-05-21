import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import esbuild from "esbuild";

const dirname = path.dirname(fileURLToPath(import.meta.url));
const assemblyscriptDir = path.resolve(dirname, "..");
const buildParserDir = path.join(assemblyscriptDir, "build-parser");
const tsconfigPath = path.join(assemblyscriptDir, "src", "tsconfig.parser.json");
const entryPoint = path.join(assemblyscriptDir, "src", "index-parser.ts");

fs.rmSync(buildParserDir, { recursive: true, force: true });
fs.mkdirSync(buildParserDir, { recursive: true });

await esbuild.build({
  entryPoints: [entryPoint],
  tsconfig: tsconfigPath,
  outfile: path.join(buildParserDir, "index-parser.js"),
  bundle: true,
  platform: "node",
  format: "esm",
  target: "es2020",
  sourcemap: true,
  legalComments: "none",
});