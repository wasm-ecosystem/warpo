import { ensureDirSync } from "fs-extra";
import { copyFile, writeFileSync } from "node:fs";
import { basename, dirname, join, relative } from "node:path";
import { generateFolderHtml } from "./genFolder.js";
import { FileCoverageResult } from "../../interface.js";
import { generateCodeHtml } from "./genCode.js";
import { projectRoot } from "../../utils/projectRoot.js";

const resourceFiles = [
  "base.css",
  "block-navigation.js",
  "prettify.css",
  "prettify.js",
  "sort-arrow-sprite.png",
  "sorter.js",
];

export function genHtml(target: string, filesInfos: FileCoverageResult[]) {
  const resourceFolder = join(target, "resource");
  ensureDirSync(resourceFolder);
  for (const file of resourceFiles) {
    copyFile(join(projectRoot, "resource", file), join(resourceFolder, basename(file)), () => {
      return;
    });
  }
  const html = generateFolderHtml(".", filesInfos);
  writeFileSync(join(target, "index.html"), html);
  for (const filesInfo of filesInfos) {
    const htmlpath = join(target, filesInfo.filename + ".html");
    const relativePath = relative(dirname(htmlpath), target);
    const html = generateCodeHtml(relativePath, filesInfo);
    ensureDirSync(dirname(htmlpath));
    writeFileSync(htmlpath, html);
  }
}
