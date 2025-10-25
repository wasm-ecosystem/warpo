There are 2 kinds of cost model in WARPO.

**Performance Cost Model** is CPU execution time for each wasm op code.

**Size Cost Model** is average instructions count for each wasm op code.

Input is plain text file with following format.  
`<wasm op code [string]> <average count of instructions [float]>`.

::: info
A special op code `func` is added to identify additional costs for each function.
:::

preset size cost models for 5 backend:

- model/instruction_cost_aarch64_active_vb_warp.txt
- model/instruction_cost_aarch64_vb_warp.txt
- model/instruction_cost_tricore_vb_warp.txt
- model/instruction_cost_x86_64_active_vb_warp.txt
- model/instruction_cost_x86_64_vb_warp.txt
