# Warpo Debugger

Debug Warpo WebAssembly projects from Visual Studio Code.

## Requirements

- Install the `warpo` package in the workspace being debugged:

  ```sh
  npm install warpo
  ```

## Debug a Wasm file

Add a Warpo launch configuration to `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "warpo",
      "request": "launch",
      "name": "Warpo Debug",
      "wasmFilePath": "${workspaceFolder}/build/output.wasm",
      "sessionMode": "wasm file",
      "entryFunctionName": "main",
      "args": []
    }
  ]
}
```

Start the configuration from the Run and Debug view. `entryFunctionName`
defaults to `main`, and `args` accepts numeric arguments for the entry
function.

## Debug unit tests

Set `sessionMode` to `unittest`:

```json
{
  "type": "warpo",
  "request": "launch",
  "name": "Warpo Debug (unittest)",
  "sessionMode": "unittest"
}
```

The debugger runs the Warpo test command for the workspace. If unit tests need
to use a different Warpo CLI, set the optional `warpoPath` property in the
launch configuration. Relative paths are resolved from the workspace folder.

## Configuration

- `wasmFilePath`: Path to the Wasm file to debug.
- `sessionMode`: `wasm file` or `unittest`.
- `entryFunctionName`: Exported Wasm function to call; defaults to `main`.
- `args`: Numeric arguments passed to the entry function; defaults to `[]`.
- `debugSessionLogging`: Show detailed debug session logs in the Debug Console.
- `debugSessionLogFile`: Optional file path for detailed debug session logs.
  Relative paths are resolved from the workspace folder and take precedence
  over any environment-based trace-file setting.
- `warpoPath`: Optional Warpo CLI path for unit-test mode.

## Collect logs for a bug report

Set `debugSessionLogFile` in the launch configuration:

```json
{
  "type": "warpo",
  "request": "launch",
  "name": "Warpo Debug with logging",
  "wasmFilePath": "${workspaceFolder}/build/output.wasm",
  "debugSessionLogFile": "${workspaceFolder}/warpo-debug.log"
}
```

Start the session, reproduce the problem, and attach the generated log file to
the bug report. The file is created when the debug session starts. To also see
the messages live, set `debugSessionLogging` to `true`; it displays them in the
**Debug Console**.

## Repository

See the [Warpo repository](https://github.com/wasm-ecosystem/warpo) for source
code, documentation, and issue reporting.
