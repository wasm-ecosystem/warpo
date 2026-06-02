// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import * as vscode from "vscode";
import * as path from "node:path";
import * as fs from "node:fs";
import { type ChildProcess } from "node:child_process";
import { launchDapServer } from "./launcher";

let serverProcess: ChildProcess | undefined;

interface WarpoDebugConfiguration extends vscode.DebugConfiguration {
  program?: string;
  launchType?: string;
  runtime?: string;
  entryFunctionName?: string;
  args?: number[];
}

export function activate(context: vscode.ExtensionContext) {
  const factory = new WarpoDebugAdapterFactory();
  const configProvider = new WarpoDebugConfigurationProvider();

  context.subscriptions.push(
    vscode.debug.registerDebugConfigurationProvider("warpo", configProvider),
    vscode.debug.registerDebugAdapterDescriptorFactory("warpo", factory),
    {
      dispose() {
        serverProcess?.kill();
        serverProcess = undefined;
      },
    }
  );
}

export function deactivate() {
  serverProcess?.kill();
  serverProcess = undefined;
}

function findDapServer(workspaceFolder: string): string | undefined {
  const config = vscode.workspace.getConfiguration("warpo");
  const override = config.get<string>("debugRuntime");
  if (override) {
    const resolved = path.isAbsolute(override) ? override : path.join(workspaceFolder, override);
    if (fs.existsSync(resolved)) {
      return resolved;
    }
  }

  const candidate = path.join(workspaceFolder, "node_modules", "warpo", "dist", "debug_server", "dapServer.js");
  return fs.existsSync(candidate) ? candidate : undefined;
}

class WarpoDebugConfigurationProvider implements vscode.DebugConfigurationProvider {
  resolveDebugConfiguration(
    _folder: vscode.WorkspaceFolder | undefined,
    config: vscode.DebugConfiguration
  ): vscode.ProviderResult<vscode.DebugConfiguration> {
    const warpoConfig = config as WarpoDebugConfiguration;

    if (!warpoConfig.program) {
      void vscode.window.showErrorMessage("No 'program' specified in launch configuration.");
      return undefined;
    }
    warpoConfig.launchType = warpoConfig.launchType ?? "wasm file";
    warpoConfig.runtime = warpoConfig.runtime ?? "node";
    warpoConfig.entryFunctionName = warpoConfig.entryFunctionName ?? "main";
    warpoConfig.args = warpoConfig.args ?? [];
    return warpoConfig;
  }
}

class WarpoDebugAdapterFactory implements vscode.DebugAdapterDescriptorFactory {
  async createDebugAdapterDescriptor(session: vscode.DebugSession): Promise<vscode.DebugAdapterDescriptor> {
    const workspaceFolder = session.workspaceFolder?.uri.fsPath ?? vscode.workspace.workspaceFolders?.[0]?.uri.fsPath;
    if (!workspaceFolder) {
      throw new Error("No workspace folder found. Open a folder to use Warpo debugger.");
    }

    const dapServer = findDapServer(workspaceFolder);
    if (!dapServer) {
      throw new Error(
        "Warpo debug runtime not found. Make sure 'warpo' is installed in your project (npm install warpo)."
      );
    }

    serverProcess?.kill();
    const { port, child } = await launchDapServer(dapServer);
    serverProcess = child;
    return new vscode.DebugAdapterServer(port, "127.0.0.1");
  }
}
