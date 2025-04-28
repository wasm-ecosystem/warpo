import fs from "node:fs";

const as_package = JSON.parse(fs.readFileSync("assemblyscript/package.json", "utf-8"));

console.log();
as_package.dependencies;

let warpo_package = JSON.parse(fs.readFileSync("package.json", "utf-8"));

warpo_package.files = [...(warpo_package.files ?? []), ...as_package.files.map((f) => `assemblyscript/${f}`)];
warpo_package.dependencies = {
  ...(warpo_package.dependencies ?? {}),
  ...(as_package.dependencies ?? {}),
};

console.log("warpo_package\n", JSON.stringify(warpo_package, null, 2));
fs.writeFileSync("package.json", JSON.stringify(warpo_package, null, 2));
