import { runWarpo } from "./warpo.js";
import { runPreAsc } from "./pre_asc.js";
import { argv, exit } from "node:process";

function exitWithMessage(message: string): never {
  console.error(message);
  exit(1);
}

let output = undefined;
let restArgv = [];
for (let i = 2; i < argv.length; i++) {
  if (argv[i] == "--outFile" || argv[i] == "-o") {
    output = argv[i + 1];
    i++;
  } else {
    if (argv[i] == "--runtime" && argv[i + 1] != "incremental") {
      exitWithMessage("Only incremental runtime is supported");
    } else if (argv[i] == "--optimizeLevel" && argv[i + 1] != "0") {
      exitWithMessage("Only --optimizeLevel 0 is supported");
    } else if (argv[i] == "--shrinkLevel" && argv[i + 1] != "2") {
      exitWithMessage("Only --shrinkLevel 2 is supported");
    }
    restArgv.push(argv[i]);
  }
}

if (output == undefined) exitWithMessage("Please specify the output file with --outFile or -o");

const outputWast = output.endsWith("wasm") ? output.slice(0, -4) + ".wast" : output + ".wast";
await runPreAsc(outputWast, restArgv);
runWarpo(outputWast, output);
