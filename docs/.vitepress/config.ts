import { readdirSync } from "node:fs";
import path from "node:path";
import { DefaultTheme, defineConfig } from "vitepress";

function listItems(folder: string): DefaultTheme.SidebarItem[] {
  return readdirSync(path.join("docs", folder))
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
        text: "About Documentation",
        link: "/about_documentation",
      },
      {
        text: "new features",
        link: "/new_features",
      },
      {
        text: "Using the Language",
        link: "/using_language/index",
        items: [
          {
            text: "current status",
            link: "/using_language/current_status",
          },
          {
            text: "details",
            items: listItems("using_language/details"),
          },
        ],
      },
      {
        text: "Using the Compiler",
        link: "/using_compiler/quick_start",
        items: [
          {
            text: "third-party libraries",
            link: "/using_compiler/module_resolution",
          },
        ],
      },
      {
        text: "Using the Runtime",
        items: [
          {
            text: "garbage collection",
            link: "/using_runtime/garbage_collection",
            items: [
              {
                text: "shadow stack",
                link: "/using_runtime/shadow_stack",
              },
              {
                text: "radical GC",
                link: "/using_runtime/radical_gc",
              },
            ],
          },
        ],
      },
      {
        text: "Executing WebAssembly",
        link: "/executing_webassembly/index",
        items: listItems("executing_webassembly"),
      },
      {
        text: "Technical Details",
        items: [
          {
            text: "Lowering Passes",
            link: "/tech/lower/index",
            items: listItems("tech/lower"),
          },
          {
            text: "Builtin Transform",
            link: "/tech/transform/index",
            items: listItems("tech/transform"),
          },
          {
            text: "Optimization Passes",
            link: "/tech/opt/index",
            items: listItems("tech/opt"),
          },
          {
            text: "Debugging Support",
            link: "/tech/debug_symbol/index",
            items: listItems("tech/debug_symbol"),
          },
          {
            text: "Infrastructure",
            link: "/tech/infra/index",
            items: listItems("tech/infra"),
          },
          {
            text: "For Developers",
            items: listItems("tech/for_dev"),
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
