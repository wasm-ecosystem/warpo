(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (result i32)))
 (type $2 (func (param i32 i32 i32) (result i32)))
 (type $3 (func (param i64 i64) (result i64)))
 (type $4 (func (param f64 f64) (result f64)))
 (type $5 (func))
 (type $6 (func (param i32) (result i32)))
 (type $7 (func (param i32)))
 (type $8 (func (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $function-types/i32Adder (mut i32) (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $function-types/i64Adder (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 204))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32972))
 (global $~lib/memory/__heap_base i32 (i32.const 32972))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\"\00\00\00f\00u\00n\00c\00t\00i\00o\00n\00-\00t\00y\00p\00e\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 108) "\1c\00\00\00\00\00\00\00\00\00\00\00\05\00\00\00\08\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 140) "\1c\00\00\00\00\00\00\00\00\00\00\00\06\00\00\00\08\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 172) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 5 5 funcref)
 (elem $0 (i32.const 1) $function-types/makeAdder<i32>~anonymous|0 $function-types/makeAdder<i64>~anonymous|0 $function-types/makeAdder<f64>~anonymous|0 $function-types/addI32)
 (export "memory" (memory $0))
 (start $~start)
 (func $function-types/makeAdder<i32>~anonymous|0 (param $a i32) (param $b i32) (result i32)
  (return
   (i32.add
    (local.get $a)
    (local.get $b)
   )
  )
 )
 (func $function-types/makeAdder<i32> (result i32)
  (return
   (i32.const 32)
  )
 )
 (func $function-types/makeAdder<i64>~anonymous|0 (param $a i64) (param $b i64) (result i64)
  (return
   (i64.add
    (local.get $a)
    (local.get $b)
   )
  )
 )
 (func $function-types/makeAdder<i64> (result i32)
  (return
   (i32.const 128)
  )
 )
 (func $function-types/makeAdder<f64>~anonymous|0 (param $a f64) (param $b f64) (result f64)
  (return
   (f64.add
    (local.get $a)
    (local.get $b)
   )
  )
 )
 (func $function-types/makeAdder<f64> (result i32)
  (return
   (i32.const 160)
  )
 )
 (func $function-types/doAddWithFn<i32> (param $a i32) (param $b i32) (param $fn i32) (result i32)
  (return
   (call_indirect (type $0)
    (local.get $a)
    (local.get $b)
    (block (result i32)
     (call $~lib/rt/closure/setClosureEnv
      (i32.load offset=4
       (local.get $fn)
      )
     )
     (global.set $~argumentsLength
      (i32.const 2)
     )
     (i32.load
      (local.get $fn)
     )
    )
   )
  )
 )
 (func $function-types/doAdd<i32> (param $a i32) (param $b i32) (result i32)
  (local $2 i32)
  (return
   (call_indirect (type $0)
    (local.get $a)
    (local.get $b)
    (block (result i32)
     (local.set $2
      (call $function-types/makeAdder<i32>)
     )
     (call $~lib/rt/closure/setClosureEnv
      (i32.load offset=4
       (local.get $2)
      )
     )
     (global.set $~argumentsLength
      (i32.const 2)
     )
     (i32.load
      (local.get $2)
     )
    )
   )
  )
 )
 (func $function-types/addI32 (param $a i32) (param $b i32) (result i32)
  (return
   (i32.add
    (local.get $a)
    (local.get $b)
   )
  )
 )
 (func $function-types/makeAndAdd<i32> (param $a i32) (param $b i32) (param $adder i32) (result i32)
  (return
   (call_indirect (type $0)
    (local.get $a)
    (local.get $b)
    (block (result i32)
     (call $~lib/rt/closure/setClosureEnv
      (i32.load offset=4
       (local.get $adder)
      )
     )
     (global.set $~argumentsLength
      (i32.const 2)
     )
     (i32.load
      (local.get $adder)
     )
    )
   )
  )
 )
 (func $function-types/makeAndAdd<i32>@varargs (param $a i32) (param $b i32) (param $adder i32) (result i32)
  (block $1of1
   (block $0of1
    (block $outOfRange
     (br_table $0of1 $1of1 $outOfRange
      (i32.sub
       (global.get $~argumentsLength)
       (i32.const 2)
      )
     )
    )
    (unreachable)
   )
   (local.set $adder
    (call $~lib/rt/__localtostack
     (call $function-types/makeAdder<i32>)
    )
   )
  )
  (call $function-types/makeAndAdd<i32>
   (local.get $a)
   (local.get $b)
   (call $~lib/rt/__tmptostack
    (local.get $adder)
   )
  )
 )
 (func $start:function-types
  (local $0 i32)
  (global.set $function-types/i32Adder
   (call $function-types/makeAdder<i32>)
  )
  (if
   (i32.eqz
    (i32.eq
     (call_indirect (type $0)
      (i32.const 1)
      (i32.const 2)
      (block (result i32)
       (call $~lib/rt/closure/setClosureEnv
        (i32.load offset=4
         (global.get $function-types/i32Adder)
        )
       )
       (global.set $~argumentsLength
        (i32.const 2)
       )
       (i32.load
        (global.get $function-types/i32Adder)
       )
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 11)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $function-types/i64Adder
   (call $function-types/makeAdder<i64>)
  )
  (if
   (i32.eqz
    (i64.eq
     (call_indirect (type $3)
      (i64.const 10)
      (i64.const 20)
      (block (result i32)
       (call $~lib/rt/closure/setClosureEnv
        (i32.load offset=4
         (global.get $function-types/i64Adder)
        )
       )
       (global.set $~argumentsLength
        (i32.const 2)
       )
       (i32.load
        (global.get $function-types/i64Adder)
       )
      )
     )
     (i64.const 30)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 15)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f64.eq
     (call_indirect (type $4)
      (f64.const 1.5)
      (f64.const 2.5)
      (block (result i32)
       (local.set $0
        (call $function-types/makeAdder<f64>)
       )
       (call $~lib/rt/closure/setClosureEnv
        (i32.load offset=4
         (local.get $0)
        )
       )
       (global.set $~argumentsLength
        (i32.const 2)
       )
       (i32.load
        (local.get $0)
       )
      )
     )
     (f64.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 17)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $function-types/doAddWithFn<i32>
      (i32.const 2)
      (i32.const 3)
      (call $~lib/rt/__tmptostack
       (global.get $function-types/i32Adder)
      )
     )
     (i32.const 5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $function-types/doAdd<i32>
      (i32.const 3)
      (i32.const 4)
     )
     (i32.const 7)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 29)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $function-types/doAddWithFn<i32>
      (i32.const 4)
      (i32.const 5)
      (call $~lib/rt/__tmptostack
       (i32.const 192)
      )
     )
     (i32.const 9)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 35)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $function-types/makeAndAdd<i32>@varargs
      (i32.const 1)
      (i32.const 2)
      (block (result i32)
       (global.set $~argumentsLength
        (i32.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 41)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $function-types/makeAndAdd<i32>
      (i32.const 1)
      (i32.const 2)
      (call $~lib/rt/__tmptostack
       (call $function-types/makeAdder<i32>)
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 42)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:function-types)
 )
)
