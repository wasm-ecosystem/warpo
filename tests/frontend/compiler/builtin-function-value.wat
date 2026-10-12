(module
 (type $0 (func (param i32 i32 f64 f64 f64 f64 f64)))
 (type $1 (func))
 (type $2 (func (param i32) (result i32)))
 (type $3 (func (param i32)))
 (import "env" "trace" (func $~lib/builtins/trace (param i32 i32 f64 f64 f64 f64 f64)))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $builtin-function-value/fn (mut i32) (i32.const 32))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 92))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32860))
 (global $~lib/memory/__heap_base i32 (i32.const 32860))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00m\00e\00s\00s\00a\00g\00e\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $~lib/builtins/trace@varargs)
 (export "memory" (memory $0))
 (start $~start)
 (func $start:builtin-function-value
  (call_indirect (type $0)
   (i32.const 64)
   (i32.const 0)
   (f64.const 0)
   (f64.const 0)
   (f64.const 0)
   (f64.const 0)
   (f64.const 0)
   (block (result i32)
    (call $~lib/rt/closure/setClosureEnv
     (i32.load offset=4
      (global.get $builtin-function-value/fn)
     )
    )
    (global.set $~argumentsLength
     (i32.const 1)
    )
    (i32.load
     (global.get $builtin-function-value/fn)
    )
   )
  )
 )
 (func $~lib/builtins/trace@varargs (param $0 i32) (param $1 i32) (param $2 f64) (param $3 f64) (param $4 f64) (param $5 f64) (param $6 f64)
  (block $6of6
   (block $5of6
    (block $4of6
     (block $3of6
      (block $2of6
       (block $1of6
        (block $0of6
         (block $outOfRange
          (br_table $0of6 $1of6 $2of6 $3of6 $4of6 $5of6 $6of6 $outOfRange
           (i32.sub
            (global.get $~argumentsLength)
            (i32.const 1)
           )
          )
         )
         (unreachable)
        )
        (nop)
       )
       (nop)
      )
      (nop)
     )
     (nop)
    )
    (nop)
   )
   (nop)
  )
  (call $~lib/builtins/trace
   (call $~lib/rt/__tmptostack
    (local.get $0)
   )
   (local.get $1)
   (local.get $2)
   (local.get $3)
   (local.get $4)
   (local.get $5)
   (local.get $6)
  )
 )
 (func $~start
  (call $start:builtin-function-value)
 )
)
