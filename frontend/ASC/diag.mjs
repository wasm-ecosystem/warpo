// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import fs from "fs";
import path from "path";
import { project_root } from "./helper.mjs";

export function generateDiagnostics() {
  const out = [`// GENERATED FILE. DO NOT EDIT.\n\n`];

  function makeKey(text) {
    return text.replace(/[^\w]+/g, "_").replace(/_+$/, "");
  }

  out.push("/** Enum of available diagnostic codes. */\n");
  out.push("export enum DiagnosticCode {\n");

  let first = true;
  const messages = JSON.parse(
    fs.readFileSync(path.join(project_root, "assemblyscript", "src", "diagnosticMessages.json"))
  );
  Object.keys(messages).forEach((text) => {
    let key = makeKey(text);
    if (first) first = false;
    else {
      out.push(",\n");
    }
    out.push("  " + key + " = " + messages[text]);
  });

  out.push("\n}\n\n");
  out.push("/** Translates a diagnostic code to its respective string. */\n");
  out.push("export function diagnosticCodeToString(code: DiagnosticCode): string {\n  switch (code) {\n");

  Object.keys(messages).forEach((text) => {
    out.push("    case " + messages[text] + ": return " + JSON.stringify(text) + ";\n");
  });

  out.push('    default: return "";\n  }\n}\n');

  const generated = out.join("");
  fs.writeFileSync(path.join(project_root, "assemblyscript", "src", "diagnosticMessages.generated.ts"), generated);
}
