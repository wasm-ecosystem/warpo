// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

export function getCustomSectionPayload(bytes: ArrayBuffer, sectionName: string): Uint8Array | null {
  const module = new WebAssembly.Module(bytes);
  const sections = WebAssembly.Module.customSections(module, sectionName);
  if (sections.length === 0) return null;
  if (sections.length > 1) throw new Error(`multiple wasm custom sections found: '${sectionName}'`);
  return new Uint8Array(sections[0]!);
}

export function getCustomSectionUtf8(bytes: ArrayBuffer, sectionName: string): string | null {
  const payload = getCustomSectionPayload(bytes, sectionName);
  if (payload === null) return null;
  return new TextDecoder("utf-8").decode(payload);
}
