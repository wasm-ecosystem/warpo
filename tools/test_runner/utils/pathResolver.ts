import assert from "node:assert";
import fs from "fs-extra";
import { glob } from "glob";
import { dirname, join, relative, resolve } from "node:path";

export function splitCommand(cmdline: string): { cmd: string; argv: string[] } {
  const res = new Array<string>();
  let depth = 0;
  let last = 0;
  for (let i = 0; i < cmdline.length; i++) {
    const ch = cmdline.charAt(i);
    if (ch === '"' || ch === "'" || ch === "`") {
      depth++;
    } else if (ch === " " && depth % 2 === 0 && (i === 0 || cmdline.charAt(i - 1) !== "\\")) {
      if (last !== i) {
        const argv = cmdline.slice(last, i).replaceAll(/\\ /g, " ");
        res.push(argv);
      }
      last = i + 1;
    }
  }
  if (last !== cmdline.length) {
    res.push(cmdline.slice(last));
  }
  const cmd = res[0];
  if (cmd === undefined) throw new Error(`Invalidat Command: ${cmdline}`);
  const argv = res.slice(1);
  return { cmd: cmd, argv: argv };
}

function getAllFileInFolder(folder: string, filter: (v: string) => boolean = () => true): string[] {
  const res: string[] = [];
  let sub: string[];
  try {
    sub = fs.readdirSync(folder).map((v) => join(folder, v));
  } catch (error) {
    if (error instanceof Error) {
      console.error(error.stack);
    }
    throw new Error(`read "${folder}" info failed`);
  }
  for (const f of sub) {
    const st = fs.statSync(f);
    if (st.isFile() && filter(f)) {
      res.push(f);
    } else if (st.isDirectory()) {
      res.push(...getAllFileInFolder(f, filter));
    }
  }
  return res;
}

export function findRoot(filePaths: string[]): string {
  if (filePaths.length === 1) {
    const filePath = filePaths[0];
    assert(filePath !== undefined);
    return dirname(filePath);
  }
  const absPaths = filePaths.map((p) => {
    return resolve(p);
  });
  const p0 = absPaths[0];
  if (p0 === undefined) {
    throw new Error("include length is zeros");
  }
  let root: string = p0;
  while (!absPaths.every((v) => v.startsWith(root))) {
    root = dirname(root);
  }
  root = relative(".", root);
  if (root === "") {
    root = ".";
  }
  if (root.startsWith("..")) {
    throw new Error("file path out of project range");
  }
  return root;
}

export function getIncludeFiles(includePatterns: string[], filter: (path: string) => boolean): string[] {
  const flatPatterns = includePatterns.flatMap((pattern) => {
    return glob.sync(pattern);
  });
  const files = flatPatterns.flatMap((flatPattern) => {
    const st = fs.statSync(flatPattern);
    if (st.isDirectory()) {
      return getAllFileInFolder(flatPattern, filter);
    } else if (st.isFile() && filter(flatPattern)) {
      return [flatPattern];
    } else {
      return [];
    }
  });
  return files;
}
