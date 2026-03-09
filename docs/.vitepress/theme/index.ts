// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import DefaultTheme from "vitepress/theme";
import mermaid from "mermaid";
import { defineComponent, h, onMounted, ref } from "vue";

const MermaidRenderer = defineComponent({
  name: "MermaidRenderer",
  props: {
    code: {
      type: String,
      required: true,
    },
  },
  setup(props) {
    const rootEl = ref<HTMLElement | null>(null);

    onMounted(async () => {
      if (!rootEl.value) {
        return;
      }

      mermaid.initialize({ startOnLoad: false });
      const renderTargetId = `mermaid-${Math.random().toString(36).slice(2)}`;
      const { svg } = await mermaid.render(renderTargetId, props.code);
      rootEl.value.innerHTML = svg;
    });

    return () => h("div", { class: "mermaid-renderer", ref: rootEl });
  },
});

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component("MermaidRenderer", MermaidRenderer);
  },
};
