WARP support tracing by `builtin.tracePoint` API.

This transform will insert calling `builtin.tracePoint` to statistic execution status of each function.

- For the normal functions, calling `builtin.tracePoint` will be inserted before and after function.
- For the import functions, calling `builtin.tracePoint` will be inserted before and after calling.

### options

#### `--trace-point-mapping-file <file path>`

Enable transform by providing mapping file path.
The trace point mapped function name will be outputted in the mapping file with following format.

```
<trace point number> ' ' <function name>
```
