#!/usr/bin/env node
// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { argv as processArgv, exit as processExit } from "node:process";
import { fileURLToPath } from "node:url";
import { traceVisualizer as runTraceVisualizer } from "./scripts/lib.js";

if (processArgv[1] !== undefined && fileURLToPath(import.meta.url) === processArgv[1]) {
    runTraceVisualizer({ argv: processArgv.slice(2) })
        .then((code) => {
            return processExit(code);
        })
        // eslint-disable-next-line unicorn/prefer-top-level-await
        .catch((error: unknown) => {
            console.error(error);
            return processExit(255);
        });
}
