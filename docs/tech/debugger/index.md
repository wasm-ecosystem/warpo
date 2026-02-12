## User experience design

### 1. launch a basic Wasm file

```json
{
  "type": "wasm file",
  "wasmFilePath": "some/demo/path.wasm",
  "entryFunctionName": "foo"
}
```

Node Runtime:
In this case, the debugger runtime will:

1. Launch a subprocess with node inspect
2. use a internal js file to load the Wasm
3. run the export function.

Warp Runtime: TBD

### 2. launch a Javascript file

```json
{
  "type": "js file",
  "jsFilePath": "some/demo/path.js"
}
```

Node Runtime:
In this case, the debugger runtime will:

1. Launch a subprocess with node inspect
2. run the given js file and wait for Wasm loaded event.
3. When a Wasm with warpo comapitable debug symbol loaded, debugger will register this module for debugging

### 3. Launch with a custom command

```json
{
  "type": "js file",
  "command": "some_command"
}
```

Node runtime

```shell
export NODE_OPTIONS=--inspect-brk=0
bash -c "node  test.js"
Debugger listening on ws://127.0.0.1:43699/75c52c83-e638-4877-8064-64b19f549630
```

The nodejs support environment variable `NODE_OPTIONS=--inspect-brk=port_number`, 0 means a random port. When this environment variable is set, node js will always be launched in debug mode and print the port number in stderr after launch.
Then the debug runtime doesn't need to care how is the Wasm is launched in nodejs and how many level subprocess are nested here.

Restriction:

1. integrator must forword the enviornment variable
2. integrator must forword the stderr as pipe

Warp Runtime: TBD

## Topology

Topology of the debugger ![here](./debugger.excalidraw.svg)
