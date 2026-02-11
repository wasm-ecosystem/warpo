// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import * as vscode from "vscode";
import { WarpoDebugSession } from "./debugSession";

export function activate(context: vscode.ExtensionContext) {
  const factory = new WarpoDebugAdapterFactory();
  context.subscriptions.push(
    vscode.debug.registerDebugAdapterDescriptorFactory("warpo", factory),
  );
}

export function deactivate() {}

class WarpoDebugAdapterFactory
  implements vscode.DebugAdapterDescriptorFactory
{
  createDebugAdapterDescriptor(
    _session: vscode.DebugSession,
  ): vscode.ProviderResult<vscode.DebugAdapterDescriptor> {
    return new vscode.DebugAdapterInlineImplementation(
      new WarpoDebugSession(),
    );
  }
}
