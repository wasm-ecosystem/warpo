import { structuredPatch } from "diff";
import chalk from "chalk";

/**
 *
 * @param {string} filename
 * @param {string} expected
 * @param {string} actual
 * @returns
 */
export function diff(filename, expected, actual) {
  const patch = structuredPatch(filename, filename, expected, actual, "expected", "actual", { context: 5 });
  if (!patch.hunks.length) return null;
  const out = ["--- " + patch.oldHeader, "+++ " + patch.newHeader];
  for (const hunk of patch.hunks) {
    out.push("@@ -" + hunk.oldStart + "," + hunk.oldLines + " +" + hunk.newStart + "," + hunk.newLines + " @@");
    out.push(
      ...hunk.lines.map((line) =>
        line.charAt(0) === "+" ? chalk.green(line) : line.charAt(0) === "-" ? (line = chalk.red(line)) : line
      )
    );
  }
  return out.join("\n") + "\n";
}
