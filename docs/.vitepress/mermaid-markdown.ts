// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import type { MarkdownRenderer } from "vitepress";

export function overrideMermaidFence(md: MarkdownRenderer): void {
  const defaultFenceRenderer =
    md.renderer.rules.fence ?? ((tokens, idx, options, _env, self) => self.renderToken(tokens, idx, options));

  md.renderer.rules.fence = (tokens, idx, options, env, self) => {
    const token = tokens[idx];
    const fenceType = token.info.trim().split(/\s+/u)[0];

    if (fenceType !== "mermaid") {
      return defaultFenceRenderer(tokens, idx, options, env, self);
    }

    // Encode graph source before embedding it in template attributes.
    const encodedMermaidCode = encodeURIComponent(token.content);
    return `<MermaidRenderer :code="decodeURIComponent('${encodedMermaidCode}')" />`;
  };
}
