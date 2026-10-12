(module
 (type $0 (func (result i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\04\00\00\00\08\00\00\00\01")
 (data $1 (i32.const 44) "L")
 (data $1.1 (i32.const 56) "\02\00\00\00<\00\00\00c\00l\00o\00s\00u\00r\00e\00-\00l\00o\00c\00a\00l\00-\00s\00h\00a\00d\00o\00w\00s\00-\00o\00u\00t\00e\00r\00.\00t\00s")
 (export "test" (func $closure-local-shadows-outer/test))
 (export "memory" (memory $0))
 (func $closure-local-shadows-outer/test (result i32)
  i32.const 10
 )
)
