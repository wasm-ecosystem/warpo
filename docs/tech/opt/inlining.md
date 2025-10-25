This pass is inherited from [binaryen's inlining pass](https://github.com/WebAssembly/binaryen/blob/3db6220b8abb03eef649cea4c42706caac6f9b9b/src/passes/Inlining.cpp).

It introduces [cost model](/infra/cost_model) based inlining evaluation. When deciding whether we should inline a function call, this pass will check the potential instruction count changing based on cost model. When the potential instruction count increasing is less than the budget provided in command line options, this function can be inlined, otherwise will not.

## Options

##### `--adv-inline-tolerable-instruction-increase`

A number indicating the amount of instruction increase that can be tolerated.

Default is 64.
