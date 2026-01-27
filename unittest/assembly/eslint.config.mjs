import tseslint from "typescript-eslint";
import prettier from "eslint-plugin-prettier";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export default tseslint.config(
  {
    ignores: ["*.mjs"],
  },
  tseslint.configs.recommendedTypeChecked,
  {
    languageOptions: {
      parserOptions: {
        tsconfigRootDir: __dirname,
        project: [path.join(__dirname, "tsconfig.json")],
      },
    },
  },

  {
    plugins: {
      prettier: prettier,
    },
  },

  {
    rules: {
      // Namespaces are quite useful in AssemblyScript
      "@typescript-eslint/no-namespace": "off",

      // There is actually codegen difference here
      "@typescript-eslint/no-array-constructor": "off",

      // Sometimes it can't be avoided to add a @ts-ignore
      "@typescript-eslint/ban-ts-comment": "off",

      // Not all types can be omitted in AS yet
      "@typescript-eslint/no-inferrable-types": "off",

      // The compiler has its own `Function` class for example
      "@typescript-eslint/ban-types": "off",
      "@typescript-eslint/no-unsafe-call": "off",
    },
  },
);
