# WARPO 配置文件（`asconfig.json`）

<p style="display: flex; gap: 10px;">
	<img src="/version/2.3.0.svg" alt="2.3.0" />
	<img src="/stability/stable.svg" alt="stable" />
</p>

WARPO 编译器使用名为 `asconfig.json` 的配置文件来控制构建流程、指定入口文件，以及自定义输出选项。该文件必须是符合下述 schema 的合法 JSON 对象。

## 顶层结构

```json
{
	"$schema": "https://raw.githubusercontent.com/wasm-ecosystem/warpo/refs/tags/2.3.0-alpha-1/asconfig.schema.json",
	"entries": [ ... ],
	"options": { ... },
	"targets": { ... }
}
```

- **schema**：`asconfig.json` 的预定义 schema。它位于 warpo 项目根目录。
  ::: info
  指定用于描述配置文件结构与校验规则的 JSON Schema URI。这能帮助工具与编辑器基于 schema 做校验、自动补全与错误检查。
  :::
- **entries**：要编译的入口 AssemblyScript 源文件数组。每一项是文件路径（string）。
- **options**：全局编译选项（见下文）。
- **targets**：将 target 名称映射到各自编译选项的对象（见下文）。

## Options

Options 用于控制构建过程与输出。它们可以全局设置（`options` 字段下），也可以按 target 设置（`targets` 字段下）。</br>
每个字段的详细描述请参考 schema。

### `use`

`use` 对应 AssemblyScript 的 `--use <name>=<value>` 选项。

它支持两种写法：

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
	<img src="/version/2.4.0.svg" alt="2.4.0" />
	<img src="/stability/stable.svg" alt="stable" />
</p>

用于选择编译器在导入（imports）层面要面向的 host API。默认值为 `none`。

支持的取值：

- `none`：不假设任何 host API。
- `wasi_snapshot_preview1`：使用 WASI Snapshot Preview 1 的 host imports。

另见：[WASI Snapshot Preview 1 Host](/zh-CN/using_compiler/hosts/wasi_snapshot_preview1)

可以在配置文件中设置：

```json
{
  "options": {
    "host": "wasi_snapshot_preview1"
  }
}
```

也可以通过 CLI 设置：

```bash
warpo assembly/index.ts -o build/app.wasm --host wasi_snapshot_preview1
```

## Targets

Targets 允许你定义多个构建配置（例如 `debug`、`release`）。每个 target 都是一个带有独立 options 的对象，用于覆盖全局 options。

示例：

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

## 示例配置

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

## 工作方式

编译器会读取由 `--config` 命令行选项指定的 `asconfig.json`。它会先应用 `options` 字段中的选项。如果通过 `--target` 指定了 target，则会用 `targets` 中对应 target 的选项覆盖全局选项。最后，会应用额外的命令行选项（优先级最高）。

## Tips

- 使用 `options` 定义公共的编译配置。
- 使用 `targets` 在不同构建配置间快速切换。
