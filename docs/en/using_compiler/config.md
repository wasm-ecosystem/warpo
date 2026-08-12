# WARPO Configuration File (`asconfig.json`)

<p style="display: flex; gap: 10px;">
  <img src="/version/2.3.0.svg" alt="2.3.0" />
  <img src="/stability/stable.svg" alt="stable" />
</p>

The WARPO compiler uses a configuration file named `asconfig.json` to control the build process, specify entry points, and customize output options. This file must be a valid JSON object matching the schema below.

## Top-Level Structure

```json
{
  "$schema": "./node_modules/warpo/asconfig.schema.json",
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

### WebAssembly Features

WARPO manages WebAssembly features through a single feature set. `tail-call` is disabled by default and must be enabled
when it is needed.

In `asconfig.json`, use `enable` and `disable` to control features:

```json
{
  "options": {
    "enable": ["tail-call"],
    "disable": ["multi-value"]
  }
}
```

Supported feature names are:

- `mutable-globals`
- `sign-extension`
- `nontrapping-f2i`
- `bulk-memory`
- `multi-value`
- `tail-call`

Equivalent CLI usage:

```bash
warpo assembly/index.ts -o build/app.wasm --enable-feature tail-call --disable-feature multi-value
```

When the same feature appears in both options, `disable` takes precedence.

### `host`

<p style="display: flex; gap: 10px;">
  <img src="/version/2.4.0.svg" alt="2.4.0" />
  <img src="/stability/stable.svg" alt="stable" />
</p>

Selects which host API surface the compiler targets for imports. The default is `none`.

Supported values:

- `none`: do not assume any host APIs.
- `wasi_snapshot_preview1`: use WASI Snapshot Preview 1 host imports.

See also: [WASI Snapshot Preview 1 Host](/en/using_compiler/hosts/wasi_snapshot_preview1)

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

### `initialMemory` and `maximumMemory`

Configure the WebAssembly memory limits used by WARPO.

- `initialMemory`: initial memory size in WebAssembly pages (`64KiB` per page).
- `maximumMemory`: maximum memory limit with optional unit suffix.

`maximumMemory` accepts:

- an integer: interpreted as bytes.
- a string with unit, for example: `65536`, `64KiB`, `1MiB`, `2MB`, `3pages`.

How `maximumMemory` is applied:

- if value is smaller than one page (`65536` bytes), WARPO applies it as `lowMemoryLimit`.
- if value is one page or larger, it must be an exact multiple of one page and is applied as `maximumMemory` pages.

Example in `asconfig.json`:

```json
{
  "options": {
    "initialMemory": 2,
    "maximumMemory": "64MiB"
  }
}
```

Equivalent CLI options:

```bash
warpo assembly/index.ts -o build/app.wasm --initialMemory 2 --maximumMemory 64MiB
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
