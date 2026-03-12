#!/usr/bin/env node

// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { argv as processArgv, env as processEnv, exit as processExit } from "node:process";
import { main } from "./warpo_internal.js";

main({ argv: processArgv.slice(2), env: processEnv })
  .then((code) => processExit(code))
  .catch(() => {
    processExit(255);
  });
