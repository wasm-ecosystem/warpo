# Build and Test with WARPO CLI

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

The WARPO CLI now provides project-oriented subcommands for the common local workflow:

- `npx warpo build` builds the current project.
- `npx warpo test` runs the WARPO unit test runner.

These commands are the recommended entry points when you are working inside a WARPO project.

If you want to prefetch compiler binaries manually, WARPO also provides `npx warpo download` and `npx warpo download --all`.

## Build a Project

`npx warpo build` forwards all extra arguments to the compiler and adds a few project-friendly defaults:

- If `asconfig.json` exists in the current directory and `--config` is not passed, WARPO uses it automatically.
- If `create.ts` exists in the current directory and `--project` is not passed, WARPO enables project mode automatically.

Typical `asconfig.json`:

```json
{
  "entries": ["assembly/index.ts"],
  "targets": {
    "debug": {
      "debug": true,
      "sourceMap": true
    },
    "release": {
      "optimizeLevel": 3,
      "shrinkLevel": 2
    }
  }
}
```

Common commands:

```bash
npx warpo build
npx warpo build --target debug
npx warpo build --target release
npx warpo build --config ./configs/asconfig.json --target release
```

If `--proxy` is set, WARPO uses that proxy for release metadata and compiler archive downloads. Otherwise it falls back to `HTTPS_PROXY` or `https_proxy` from the environment.

## Download Prebuilt Compiler

`npx warpo download` downloads and extracts the prebuilt WARPO compiler for the current OS and CPU. Use this when you want to prefetch the compiler archive instead of letting `build` download it on demand.

`npx warpo download --all` downloads and extracts all published release archives for the current WARPO version.

Common commands:

```bash
npx warpo download
npx warpo download --all
npx warpo download --proxy http://127.0.0.1:7890
npx warpo download --all --proxy http://127.0.0.1:7890
```

If `--proxy` is set, WARPO uses that proxy for release metadata and archive downloads. Otherwise it falls back to `HTTPS_PROXY` or `https_proxy` from the environment.

The legacy direct form is still supported:

```bash
npx warpo assembly/index.ts -o build/debug.wat
```

## Run Unit Tests

`npx warpo test` runs WARPO's test runner. It is integrated from [assemblyscript-unittest-framework](https://wasm-ecosystem.github.io/assemblyscript-unittest-framework/), so the test layout, `as-test.config.js` file, and common assertion style follow the same model. By default it looks for `as-test.config.js` in the current directory. Use `--config` if your test config lives somewhere else.

If you are new to this testing workflow, start with the framework's [quick start](https://wasm-ecosystem.github.io/assemblyscript-unittest-framework/quick-start.html). WARPO's `test` subcommand is the WARPO-integrated entry point for that test system.

Typical `as-test.config.js`:

```js
export default {
  include: ["tests/assemblyscript/**/*.ts"],
  collectCoverage: false,
  output: "build_coverage",
};
```

Common commands:

```bash
npx warpo test
npx warpo test --testFiles tests/assemblyscript/add.spec.ts
npx warpo test --testNamePattern add
npx warpo test --onlyFailures
npx warpo test --collectCoverage true --mode html --output build_coverage
```

Notes:

- `--testFiles` runs only the listed test files.
- `--testNamePattern` filters test cases by regular expression.
- `--onlyFailures` reruns the tests that failed previously.
- When you filter tests with `--testFiles`, `--testNamePattern`, or `--onlyFailures`, coverage collection is disabled by default unless you enable it explicitly.

## See Also

- [WARPO Configuration File](/en/using_compiler/config)
- [assemblyscript-unittest-framework quick start](https://wasm-ecosystem.github.io/assemblyscript-unittest-framework/quick-start.html)
