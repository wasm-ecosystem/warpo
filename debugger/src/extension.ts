// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import * as vscode from "vscode";
import * as path from "node:path";
import * as fs from "node:fs";
import { type ChildProcess } from "node:child_process";
import { launchDapServer } from "./launcher";

let serverProcess: ChildProcess | undefined;

const DAP_SERVER_RELATIVE_PATH = path.join("dist", "debug_server", "dapServer.js");

interface WarpoDebugConfiguration extends vscode.DebugConfiguration {
  program?: string;
  wasmFilePath?: string;
  sessionMode?: string;
  launchType?: string;
  runtime?: string;
  entryFunctionName?: string;
  cwd?: string;
  warpoPath?: string;
  debugSessionLogging?: boolean;
  args?: number[];
}

export function activate(context: vscode.ExtensionContext) {
  const factory = new WarpoDebugAdapterFactory(context.extensionPath);
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

function findDapServer(workspaceFolder: string, extensionPath: string): string | undefined {
  const config = vscode.workspace.getConfiguration("warpo");
  const override = config.get<string>("debugRuntime");
  if (override) {
    const resolved = path.isAbsolute(override) ? override : path.join(workspaceFolder, override);
    if (fs.existsSync(resolved)) {
      return resolved;
    }
  }

  const projectRuntime = path.join(workspaceFolder, "node_modules", "warpo", DAP_SERVER_RELATIVE_PATH);
  if (fs.existsSync(projectRuntime)) {
    return projectRuntime;
  }

  const developmentRuntime = path.join(extensionPath, "..", DAP_SERVER_RELATIVE_PATH);
  return fs.existsSync(developmentRuntime) ? developmentRuntime : undefined;
}

class WarpoDebugConfigurationProvider implements vscode.DebugConfigurationProvider {
  resolveDebugConfiguration(
    folder: vscode.WorkspaceFolder | undefined,
    config: vscode.DebugConfiguration
  ): vscode.ProviderResult<vscode.DebugConfiguration> {
    const warpoConfig = config as WarpoDebugConfiguration;
    const workspaceFolder = folder?.uri.fsPath ?? vscode.workspace.workspaceFolders?.[0]?.uri.fsPath;

    warpoConfig.sessionMode = warpoConfig.sessionMode ?? "wasm file";
    if (warpoConfig.sessionMode === "unittest") {
      if (!workspaceFolder) {
        void vscode.window.showErrorMessage("Open a workspace folder to debug unit tests.");
        return undefined;
      }
      warpoConfig.program = path.join(workspaceFolder, "build_coverage", "test.instrumented.wasm");
      warpoConfig.cwd = workspaceFolder;
      if (warpoConfig.warpoPath && !path.isAbsolute(warpoConfig.warpoPath)) {
        warpoConfig.warpoPath = path.join(workspaceFolder, warpoConfig.warpoPath);
      }
    } else {
      warpoConfig.wasmFilePath = warpoConfig.wasmFilePath ?? warpoConfig.program;
      if (!warpoConfig.wasmFilePath) {
        void vscode.window.showErrorMessage("No 'wasmFilePath' specified in launch configuration.");
        return undefined;
      }
      warpoConfig.program = warpoConfig.wasmFilePath;
    }
    if (!warpoConfig.program) {
      void vscode.window.showErrorMessage("No program specified in launch configuration.");
      return undefined;
    }
    warpoConfig.launchType = warpoConfig.sessionMode;
    warpoConfig.runtime = warpoConfig.runtime ?? "node";
    warpoConfig.entryFunctionName = warpoConfig.entryFunctionName ?? "main";
    warpoConfig.debugSessionLogging = warpoConfig.debugSessionLogging ?? false;
    warpoConfig.args = warpoConfig.args ?? [];
    return warpoConfig;
  }
}

class WarpoDebugAdapterFactory implements vscode.DebugAdapterDescriptorFactory {
  constructor(private readonly extensionPath: string) {}

  async createDebugAdapterDescriptor(session: vscode.DebugSession): Promise<vscode.DebugAdapterDescriptor> {
    const workspaceFolder = session.workspaceFolder?.uri.fsPath ?? vscode.workspace.workspaceFolders?.[0]?.uri.fsPath;
    if (!workspaceFolder) {
      throw new Error("No workspace folder found. Open a folder to use Warpo debugger.");
    }

    const dapServer = findDapServer(workspaceFolder, this.extensionPath);
    if (!dapServer) {
      throw new Error(
        "Warpo debug runtime not found. Install 'warpo' in this project, or set 'warpo.debugRuntime' for local development."
      );
    }

    serverProcess?.kill();
    const { port, child } = await launchDapServer(dapServer);
    serverProcess = child;
    return new vscode.DebugAdapterServer(port, "127.0.0.1");
  }
}
