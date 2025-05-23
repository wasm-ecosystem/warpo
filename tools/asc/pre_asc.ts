import * as asc from "../../assemblyscript/dist/asc.js";

export async function runPreAsc(outputWast: string, restArgv: string[]) {
  console.log("AS compilation stage");
  const apiResult = asc.main(["-t", outputWast, ...restArgv], {
    stdout: process.stdout,
    stderr: process.stderr,
  });
  const { error } = await apiResult;
  if (error) process.exit(1);
}
