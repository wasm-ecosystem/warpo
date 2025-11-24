#!/usr/bin/env node

import { main } from "./lib.js";
import { argv, env } from "node:process";

process.exit(await main({ argv: argv.slice(2), env: env }));
