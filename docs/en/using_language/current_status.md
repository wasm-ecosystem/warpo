# Current Status

## TS Features

WARPO supports most of well-known TS features

- numeric calculation
- function
- class, interface and polymorphism
- generics

But also misses some features

- `undefined`  
  In script, you can use `null` to totally replace `undefined`.  
  In standard libarary, script will crash in runtime when return value is undefined in TS, e.g. get from non-existed key in map.
- `any`, `unknown`
- prototype
- for...in
- type deduction

## WebAssembly Features

#### maturity T0: enabled by default 🚀

- Mutable Globals
- Bulk Memory Operations For Optimization
- Sign-extension Operators
- Non-trapping float-to-int Conversions

#### maturity T1: implemented 🏁

- Fixed-width SIMD

#### not implemented 🔨

- Branch Hinting
- Bulk Memory Operations
- Exception Handling
- Multi-value
- Reference Types
- Tail Call
- Typed Function References
- Relaxed SIMD

#### no plan (meaningless for WARPO)

- Multiple Memories
- Garbage Collection
- Memory64
