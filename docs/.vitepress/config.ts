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
    socialLinks: [{ icon: "github", link: "https://atc-github.azure.cloud.bmw/CDCFW/warpo" }],
  },
});
