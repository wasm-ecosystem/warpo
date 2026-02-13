// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import eslint from "@eslint/js";
import path from "node:path";
import tseslint from "typescript-eslint";
import node_check from "eslint-plugin-n";
import { flatConfigs as eslint_import } from "eslint-plugin-import";
import promise_check from "eslint-plugin-promise";
import sonarjs from "eslint-plugin-sonarjs";
import unicorn from "eslint-plugin-unicorn";
import unused_imports from "eslint-plugin-unused-imports";

export default tseslint.config(
  {
    ignores: ["**/*.mjs", "node_modules/**"],
  },
  eslint.configs.recommended,
  tseslint.configs.recommendedTypeChecked,
  {
    languageOptions: {
      parserOptions: {
        project: ["./debugger/tsconfig.json"],
        tsconfigRootDir: path.resolve(import.meta.dirname, ".."),
      },
    },
  },
  eslint_import.recommended,
  {
    settings: {
      "import/resolver": {
        typescript: {
          alwaysTryTypes: true,
        },
      },
    },
  },
  promise_check.configs["flat/recommended"],
  sonarjs.configs.recommended,
  {
    rules: {
      "sonarjs/redundant-type-aliases": "off",
    },
  },
  unicorn.configs.recommended,
  {
    plugins: {
      "unused-imports": unused_imports,
    },
  },
  {
    rules: {
      "unicorn/no-new-array": "off",
      "unicorn/filename-case": ["error", { case: "camelCase" }],
      "unicorn/no-null": "off",
      "unicorn/no-array-reduce": "off",
      "unicorn/import-style": "off",
      "unicorn/numeric-separators-style": "off",
      "unicorn/prefer-module": "off",
      "unicorn/prevent-abbreviations": "off",
      "unicorn/prefer-string-replace-all": "off",
      "unicorn/prefer-spread": "off",
      "unicorn/no-array-callback-reference": "off",
      "unicorn/consistent-assert": "off",
      eqeqeq: "error",
      "prefer-spread": "error",
      "dot-notation": "off",
      "@typescript-eslint/dot-notation": "error",
      "import/no-unresolved": "error",
      "@typescript-eslint/no-unused-vars": [
        "error",
        {
          args: "all",
          argsIgnorePattern: "^_",
          caughtErrors: "all",
          caughtErrorsIgnorePattern: "^_",
          destructuredArrayIgnorePattern: "^_",
          varsIgnorePattern: "^_",
          ignoreRestSiblings: true,
        },
      ],
    },
  },
  node_check.configs["flat/recommended"],
  {
    rules: {
      "n/no-missing-import": "off",
      "n/no-unsupported-features/node-builtins": [
        "error",
        {
          version: ">=22.0.0",
        },
      ],
    },
  },
  {
    files: ["**/*.ts"],
    rules: {
      curly: ["error", "all"],
    },
  }
);
