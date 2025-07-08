import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "warpo document",
  description: "wasm optimizer designed for AssemblyScript and WARP",
  base: "/warpo/",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    search: {
      provider: "local",
    },
    nav: [{ text: "Home", link: "/" }],
    sidebar: [
      {
        text: "Document",
        items: [
          {
            text: "Lowering Pass",
            link: "/lower/overview",
            items: [{ text: "gc lowering", link: "/lower/gc_lowering" }],
          },
          {
            text: "Optimization Pass",
            link: "/opt/overview",
            items: [{ text: "reorder global", link: "/opt/extract_most_frequently_used_globals" }],
          },
        ],
      },
    ],
    socialLinks: [{ icon: "github", link: "https://atc-github.azure.cloud.bmw/CDCFW/warpo" }],
  },
});
