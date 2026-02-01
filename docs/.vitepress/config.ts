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

function getThemeConfig(language: "en" | "zh-CN"): DefaultTheme.Config {
  // https://vitepress.dev/reference/default-theme-config
  const config: DefaultTheme.Config = {
    search: {
      provider: "local",
    },
    nav: [{ text: "GitHub", link: "https://github.com/wasm-ecosystem/warpo" }],
    sidebar: [
      {
        text: "About Documentation",
        link: `/${language}/about_documentation`,
      },
      {
        text: "new features",
        link: `/${language}/new_features`,
      },
      {
        text: "Using the Language",
        link: `/${language}/using_language/index`,
        items: [
          {
            text: "current status",
            link: `/${language}/using_language/current_status`,
          },
          {
            text: "details",
            items: listItems(`${language}/using_language/details`),
          },
        ],
      },
      {
        text: "Using the Compiler",
        link: `/${language}/using_compiler/quick_start`,
        items: [
          {
            text: "manage build configurations",
            link: `/${language}/using_compiler/config`,
          },
          {
            text: "host APIs",
            items: listItems(`${language}/using_compiler/hosts`),
          },
          {
            text: "third-party libraries",
            link: `/${language}/using_compiler/module_resolution`,
          },
        ],
      },
      {
        text: "Using the Runtime",
        items: [
          {
            text: "garbage collection",
            link: `/${language}/using_runtime/garbage_collection`,
            items: [
              {
                text: "shadow stack",
                link: `/${language}/using_runtime/shadow_stack`,
              },
              {
                text: "radical GC",
                link: `/${language}/using_runtime/radical_gc`,
              },
            ],
          },
        ],
      },
      {
        text: "Executing WebAssembly",
        link: `/${language}/executing_webassembly/index`,
        items: listItems(`${language}/executing_webassembly`),
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
            items: [
              {
                text: "binaryen",
                items: listItems("tech/for_dev/binaryen"),
              },
              {
                text: "assemblyscript",
                items: listItems("tech/for_dev/assemblyscript"),
              },
            ],
          },
        ],
      },
    ],
    socialLinks: [
      { icon: "github", link: "https://github.com/wasm-ecosystem/warpo" },
      { icon: "npm", link: "https://www.npmjs.com/package/warpo" },
    ],
  };
  return config;
}

// https://vitepress.dev/reference/site-config
export default defineConfig({
  locales: {
    en: {
      label: "English",
      lang: "en",
      title: "warpo document",
      description: "wasm optimizer designed for AssemblyScript and wasm-compiler",
      themeConfig: getThemeConfig("en"),
    },
    "zh-CN": {
      label: "简体中文",
      lang: "zh-CN",
      title: "warpo 文档",
      description: "面向 AssemblyScript 与 wasm 编译器的优化器/编译器工具链",
      themeConfig: getThemeConfig("zh-CN"),
    },
  },
  base: "/warpo/",
  head: [
    ["link", { rel: "icon", href: "/warpo/favicon.ico" }],
    ["meta", { name: "google-site-verification", content: "762vxla4bLoGKFlH_iYkk7TVUhrwwpMFS2r7idty0_Y" }],
  ],
  sitemap: {
    hostname: "https://wasm-ecosystem.github.io/warpo/",
  },
  themeConfig: getThemeConfig("en"),
});
