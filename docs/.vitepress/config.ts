import { readdirSync } from "node:fs";
import { DefaultTheme, defineConfig } from "vitepress";
import path from "node:path";

function listItems(root: string, folder: string): DefaultTheme.SidebarItem[] {
  return readdirSync(path.join(root, folder))
    .filter((file) => file.endsWith(".md") && file !== "index.md")
    .map((file) => file.replace(/\.md$/, ""))
    .map((name) => ({
      text: name.replace(/_/g, " "),
      link: `/${folder}/${name}`,
    }));
}

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "warpo document",
  description: "wasm optimizer designed for AssemblyScript and WARP",
  base: "/warpo/",
  head: [["meta", { name: "google-site-verification", content: "762vxla4bLoGKFlH_iYkk7TVUhrwwpMFS2r7idty0_Y" }]],
  sitemap: {
    hostname: "https://wasm-ecosystem.github.io/warpo/",
  },
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    search: {
      provider: "local",
    },
    nav: [
      { text: "Home", link: "/" },
      { text: "GitHub", link: "https://github.com/wasm-ecosystem/warpo" },
    ],
    sidebar: [
      {
        text: "Document",
        items: [
          {
            text: "Lowering Passes",
            link: "/lower/index",
            items: listItems("docs", "lower"),
          },
          {
            text: "Optimization Passes",
            link: "/opt/index",
            items: listItems("docs", "opt"),
          },
          {
            text: "Infrastructure",
            link: "/infra/index",
            items: listItems("docs", "infra"),
          },
        ],
      },
    ],
    socialLinks: [{ icon: "github", link: "https://github.com/wasm-ecosystem/warpo" }],
  },
});
