import { readdirSync } from "node:fs";
import { execSync } from "node:child_process";
import path from "node:path";
import { DefaultTheme, defineConfig } from "vitepress";

function listItems(root: string, folder: string): DefaultTheme.SidebarItem[] {
  return readdirSync(path.join(root, folder))
    .filter((file) => file.endsWith(".md") && file !== "index.md")
    .map((file) => file.replace(/\.md$/, ""))
    .map((name) => ({
      text: name.replace(/_/g, " "),
      link: `/${folder}/${name}`,
    }));
}

const repoUrl = execSync(`git remote get-url origin`, { encoding: "utf-8" }).trim();

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "warpo document",
  description: "wasm optimizer designed for AssemblyScript and wasm-compiler",
  base: "/warpo/",
  head: [
    ["link", { rel: "icon", href: "/warpo/favicon.ico" }],
    ["meta", { name: "google-site-verification", content: "762vxla4bLoGKFlH_iYkk7TVUhrwwpMFS2r7idty0_Y" }],
  ],
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
        text: "Using the Language",
        link: "/using_language/index",
        items: [
          {
            text: "current status",
            link: "/using_language/current_status",
          },
          {
            text: "experimental features",
            link: "/using_language/experimental_features",
          },
        ],
      },
      {
        text: "Using the Compiler",
        link: "/using_compiler/quick_start",
        items: [],
      },
      {
        text: "Using the Runtime",
        items: [
          {
            text: "garbage collection",
            link: "/using_runtime/garbage_collection",
          },
        ],
      },
      {
        text: "Executing WebAssembly",
        link: "/executing_webassembly/index",
        items: [],
      },
      {
        text: "Technical Details",
        items: [
          {
            text: "Lowering Passes",
            link: "/tech/lower/index",
            items: listItems("docs", "tech/lower"),
          },
          {
            text: "Builtin Transform",
            link: "/tech/transform/index",
            items: listItems("docs", "tech/transform"),
          },
          {
            text: "Optimization Passes",
            link: "/tech/opt/index",
            items: listItems("docs", "tech/opt"),
          },
          {
            text: "Debugging Support",
            link: "/tech/debug_symbol/index",
            items: listItems("docs", "tech/debug_symbol"),
          },
          {
            text: "Infrastructure",
            link: "/tech/infra/index",
            items: listItems("docs", "tech/infra"),
          },
        ],
      },
    ],
    socialLinks: [
      { icon: "github", link: "https://github.com/wasm-ecosystem/warpo" },
      { icon: "npm", link: "https://www.npmjs.com/package/warpo" },
    ],
  },
});
