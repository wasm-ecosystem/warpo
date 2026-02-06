// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { openAsBlob } from "fs";
import { relative } from "path";

export class WebAssemblyModule {
  baseName: string;
  private m: WebAssembly.Module | null = null;
  constructor(baseName: string) {
    this.baseName = relative(process.cwd(), baseName).replaceAll(/\\/g, "/");
  }
  get wasm() {
    return this.baseName.concat(".instrumented.wasm");
  }
  get sourceMap(): string {
    return this.baseName.concat(".wasm.map");
  }
  get traceFile(): string {
    return this.baseName.concat(".trace");
  }

  private async getModule(): Promise<WebAssembly.Module> {
    const bytes = await (await openAsBlob(this.wasm)).arrayBuffer();
    this.m = new WebAssembly.Module(bytes);
    return this.m!;
  }

  getCustomSectionPayload(sectionName: string): Uint8Array | null {
    const sections = WebAssembly.Module.customSections(this.getModule(), sectionName);
    if (sections.length === 0) return null;
    if (sections.length > 1) throw new Error(`multiple wasm custom sections found: '${sectionName}'`);
    return new Uint8Array(sections[0]!);
  }

  getCustomSectionUtf8(sectionName: string): string | null {
    const payload = this.getCustomSectionPayload(sectionName);
    if (payload === null) return null;
    return new TextDecoder("utf-8").decode(payload);
  }
}
