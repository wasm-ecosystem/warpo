#!/usr/bin/env node

// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { pathToFileURL } from "node:url";
import { argv as processArgv, env as processEnv, exit as processExit } from "node:process";
import { Command } from "commander";
import { main as runCompiler } from "./scripts/lib.js";
import { runFromCliArgs as runUnitTestsFromCliArgs } from "./test_runner/cli.js";

export interface CliOption {
  env: NodeJS.Dict<string>;
  argv: string[];
  cwd?: string;
}

const warpoRoot = join(import.meta.dirname, "..");

function getVersion(): string {
  try {
    return JSON.parse(readFileSync(join(warpoRoot, "package.json"), "utf8")).version as string;
  } catch {
    return "unknown";
  }
}

export async function main(options: CliOption): Promise<number> {
  const args = options.argv;

  // Preserve legacy behavior: direct compiler invocation when not using subcommands.
  const first = args[0];
  if (
    first !== undefined &&
    first !== "build" &&
    first !== "test" &&
    first !== "-h" &&
    first !== "--help" &&
    first !== "--version" &&
    first !== "-v"
  ) {
    return await runCompiler({ argv: args, env: options.env, cwd: options.cwd });
  }

  let returnCode = 0;

  const program = new Command();
  program.name("warpo").description("compiler + tooling");
  program.showHelpAfterError(true);
  program.version(getVersion(), "-v, --version", "Print version");

  program
    .command("build")
    .description("Build AssemblyScript project via WARPO compiler")
    .allowUnknownOption(true)
    .argument("[buildArgs...]", "Arguments passed through to warpo_asc")
    .action(async () => {
      const index = args.indexOf("build");
      const buildArgs = index === -1 ? [] : args.slice(index + 1);
      const cwd = options.cwd ?? process.cwd();
      const handleConfigOption = (args: string[]) => {
        const configPath = join(cwd, "asconfig.json");
        const hasConfig = args.includes("--config") || args.includes("-c");
        return !hasConfig && existsSync(configPath) ? [...args, "--config", configPath] : args;
      };
      const handleProjectOption = (args: string[]) => {
        const hasProject = args.includes("--project") || args.includes("-p");
        return !hasProject && existsSync(join(cwd, "create.ts")) ? [...args, "--project", cwd] : args;
      };
      returnCode = await runCompiler({
        argv: [handleConfigOption, handleProjectOption].reduce((args, handler) => handler(args), buildArgs),
        env: options.env,
        cwd: options.cwd,
      });
    });
  program
    .command("test")
    .description("Run unit tests via WARPO test runner")
    .helpOption(false)
    .allowUnknownOption(true)
    .argument("[testArgs...]", "Arguments passed through to the test runner")
    .action(async () => {
      const index = args.indexOf("test");
      const testArgs = index === -1 ? [] : args.slice(index + 1);
      returnCode = await runUnitTestsFromCliArgs(testArgs);
    });

  await program.parseAsync(args, { from: "user" });
  return returnCode;
}

if (typeof processArgv[1] === "string" && import.meta.url === pathToFileURL(processArgv[1]).href) {
  main({ argv: processArgv.slice(2), env: processEnv })
    .then((code) => processExit(code))
    .catch(() => {
      processExit(255);
    });
}
