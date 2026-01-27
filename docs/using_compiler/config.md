# WARPO Configuration File (`asconfig.json`)

<p style="display: flex; gap: 10px;">
  <img src="/version/2.3.0.svg" alt="2.3.0" />
  <img src="/stability/stable.svg" alt="stable" />
</p>

The WARPO compiler uses a configuration file named `asconfig.json` to control the build process, specify entry points, and customize output options. This file must be a valid JSON object matching the schema below.

## Top-Level Structure

```json
{
  "$schema": "https://raw.githubusercontent.com/wasm-ecosystem/warpo/refs/tags/2.3.0-alpha-1/asconfig.schema.json",
  "entries": [ ... ],
  "options": { ... },
  "targets": { ... }
}
```

- **schema**: Pre-defined schema for `asconfig.json`. It locates in warpo project root.
  ::: info
  Specifies the JSON Schema URI that describes the structure and validation rules for the configuration file. This helps tools and editors provide validation, auto-completion, and error checking based on the defined schema.
  :::
- **entries**: Array of entry AssemblyScript source files to compile. Each item is a file path (string).
- **options**: Global compiler options (see below).
- **targets**: Object mapping target names to their own compiler options (see below).

## Options

Options control the build process and output. They can be specified globally (under `options`) or per target (under `targets`).</br>
Detail description for each items see schema.

### `use`

`use` corresponds to AssemblyScript's `--use <name>=<value>` option.

It supports two forms:

```json
{
  "use": { "NAME": "VALUE" }
}
```

```json
{
  "use": ["NAME=VALUE"]
}
```

### `host`

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/stable.svg" alt="stable" />
</p>

Selects which host API surface the compiler targets for imports. The default is `none`.

Supported values:

- `none`: do not assume any host APIs.
- `wasi_snapshot_preview1`: use WASI Snapshot Preview 1 host imports.

See also: [WASI Snapshot Preview 1 Host](/using_compiler/hosts/wasi_snapshot_preview1)

You can set it in the config file:

```json
{
  "options": {
    "host": "wasi_snapshot_preview1"
  }
}
```

Or via CLI:

```bash
warpo assembly/index.ts -o build/app.wasm --host wasi_snapshot_preview1
```

## Targets

Targets allow you to define multiple build configurations (e.g., `debug`, `release`). Each target is an object with its own options, overriding the global options.

Example:

```json
"targets": {
  "release": {
    "debug": false,
    "optimizeLevel": 3,
    "shrinkLevel": 2
  },
  "debug": {
    "debug": true,
    "sourceMap": true
  }
}
```

## Example Configuration

```json
{
  "entries": ["src/main.ts", "src/module.ts"],
  "options": {
    "exportStart": "main",
    "debug": true,
    "optimizeLevel": 0
  },
  "targets": {
    "release": {
      "debug": false,
      "optimizeLevel": 3,
      "shrinkLevel": 2
    },
    "debug": {
      "debug": true,
      "sourceMap": true
    }
  }
}
```

## How It Works

The compiler loads `asconfig.json` specified by the `--config` command line option. It first applies options from the `options` field. If a target is specified via the `--target` command line option, the corresponding options from the `targets` field override the global options. Finally, any additional command line options are applied, taking precedence over previous settings.

## Tips

- Use the `options` section to define the common configurations.
- Use the `targets` section to easily switch between different build configurations.
