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
    return this.baseName.concat(".instrumented.wasm.map");
  }
  get traceFile(): string {
    return this.baseName.concat(".trace");
  }

  private async getModule(): Promise<WebAssembly.Module> {
    if (this.m) return this.m;
    const bytes = await (await openAsBlob(this.wasm)).arrayBuffer();
    this.m = new WebAssembly.Module(bytes);
    return this.m!;
  }

  async getCustomSectionPayload(sectionName: string): Promise<Uint8Array | null> {
    const sections = WebAssembly.Module.customSections(await this.getModule(), sectionName);
    if (sections.length === 0) return null;
    if (sections.length > 1) throw new Error(`multiple wasm custom sections found: '${sectionName}'`);
    return new Uint8Array(sections[0]!);
  }

  async getCustomSectionUtf8(sectionName: string): Promise<string | null> {
    const payload = await this.getCustomSectionPayload(sectionName);
    if (payload === null) return null;
    return new TextDecoder("utf-8").decode(payload);
  }
}
