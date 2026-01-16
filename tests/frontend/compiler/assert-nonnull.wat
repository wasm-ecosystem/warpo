(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (result i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 444))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33212))
 (global $~lib/memory/__heap_base i32 (i32.const 33212))
 (memory $0 1)
 (data $0 (i32.const 12) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00^\00\00\00U\00n\00e\00x\00p\00e\00c\00t\00e\00d\00 \00\'\00n\00u\00l\00l\00\'\00 \00(\00n\00o\00t\00 \00a\00s\00s\00i\00g\00n\00e\00d\00 \00o\00r\00 \00f\00a\00i\00l\00e\00d\00 \00c\00a\00s\00t\00)\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 140) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\"\00\00\00a\00s\00s\00e\00r\00t\00-\00n\00o\00n\00n\00u\00l\00l\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 204) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 268) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00")
 (data $4 (i32.const 316) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "testVar" (func $assert-nonnull/testVar))
 (export "testObj" (func $assert-nonnull/testObj))
 (export "testProp" (func $assert-nonnull/testProp))
 (export "testArr" (func $assert-nonnull/testArr))
 (export "testElem" (func $assert-nonnull/testElem))
 (export "testAll" (func $assert-nonnull/testAll))
 (export "testAll2" (func $assert-nonnull/testAll2))
 (export "testFn" (func $assert-nonnull/testFn))
 (export "testFn2" (func $assert-nonnull/testFn2))
 (export "testRet" (func $assert-nonnull/testRet))
 (export "testObjFn" (func $assert-nonnull/testObjFn))
 (export "testObjRet" (func $assert-nonnull/testObjRet))
 (export "memory" (memory $0))
 (func $assert-nonnull/testVar (param $n i32) (result i32)
  (local $1 i32)
  (return
   (if (result i32)
    (local.tee $1
     (call $~lib/rt/__localtostack
      (local.get $n)
     )
    )
    (then
     (local.get $1)
    )
    (else
     (call $~lib/builtins/abort
      (i32.const 32)
      (i32.const 160)
      (i32.const 2)
      (i32.const 10)
     )
     (unreachable)
    )
   )
  )
 )
 (func $assert-nonnull/Foo#get:bar (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $assert-nonnull/testObj (param $foo i32) (result i32)
  (local $1 i32)
  (return
   (call $assert-nonnull/Foo#get:bar
    (call $~lib/rt/__tmptostack
     (if (result i32)
      (local.tee $1
       (call $~lib/rt/__localtostack
        (local.get $foo)
       )
      )
      (then
       (local.get $1)
      )
      (else
       (call $~lib/builtins/abort
        (i32.const 32)
        (i32.const 160)
        (i32.const 11)
        (i32.const 10)
       )
       (unreachable)
      )
     )
    )
   )
  )
 )
 (func $assert-nonnull/testProp (param $foo i32) (result i32)
  (local $1 i32)
  (return
   (if (result i32)
    (local.tee $1
     (call $~lib/rt/__localtostack
      (call $assert-nonnull/Foo#get:bar
       (call $~lib/rt/__tmptostack
        (local.get $foo)
       )
      )
     )
    )
    (then
     (local.get $1)
    )
    (else
     (call $~lib/builtins/abort
      (i32.const 32)
      (i32.const 160)
      (i32.const 15)
      (i32.const 10)
     )
     (unreachable)
    )
   )
  )
 )
 (func $~lib/array/Array<assert-nonnull/Foo>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<assert-nonnull/Foo>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<assert-nonnull/Foo>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<assert-nonnull/Foo>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 224)
     (i32.const 288)
     (i32.const 123)
     (i32.const 42)
    )
    (unreachable)
   )
  )
  (local.set $value
   (call $~lib/rt/__localtostack
    (i32.load
     (i32.add
      (call $~lib/array/Array<assert-nonnull/Foo>#get:dataStart
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.shl
       (local.get $index)
       (i32.const 2)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eqz
     (i32.const 0)
    )
   )
   (if
    (i32.eqz
     (local.get $value)
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 336)
      (i32.const 288)
      (i32.const 127)
      (i32.const 40)
     )
     (unreachable)
    )
   )
  )
  (return
   (local.get $value)
  )
 )
 (func $assert-nonnull/testArr (param $foo i32) (result i32)
  (local $1 i32)
  (return
   (call $~lib/array/Array<assert-nonnull/Foo>#__get
    (call $~lib/rt/__tmptostack
     (if (result i32)
      (local.tee $1
       (call $~lib/rt/__localtostack
        (local.get $foo)
       )
      )
      (then
       (local.get $1)
      )
      (else
       (call $~lib/builtins/abort
        (i32.const 32)
        (i32.const 160)
        (i32.const 19)
        (i32.const 10)
       )
       (unreachable)
      )
     )
    )
    (i32.const 0)
   )
  )
 )
 (func $~lib/array/Array<assert-nonnull/Foo|null>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<assert-nonnull/Foo|null>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<assert-nonnull/Foo|null>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<assert-nonnull/Foo|null>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 224)
     (i32.const 288)
     (i32.const 123)
     (i32.const 42)
    )
    (unreachable)
   )
  )
  (local.set $value
   (call $~lib/rt/__localtostack
    (i32.load
     (i32.add
      (call $~lib/array/Array<assert-nonnull/Foo|null>#get:dataStart
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.shl
       (local.get $index)
       (i32.const 2)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.eqz
    (i32.const 1)
   )
  )
  (return
   (local.get $value)
  )
 )
 (func $assert-nonnull/testElem (param $foo i32) (result i32)
  (local $1 i32)
  (return
   (if (result i32)
    (local.tee $1
     (call $~lib/rt/__localtostack
      (call $~lib/array/Array<assert-nonnull/Foo|null>#__get
       (call $~lib/rt/__tmptostack
        (local.get $foo)
       )
       (i32.const 0)
      )
     )
    )
    (then
     (local.get $1)
    )
    (else
     (call $~lib/builtins/abort
      (i32.const 32)
      (i32.const 160)
      (i32.const 23)
      (i32.const 10)
     )
     (unreachable)
    )
   )
  )
 )
 (func $assert-nonnull/testAll (param $foo i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (return
   (if (result i32)
    (local.tee $3
     (call $~lib/rt/__localtostack
      (call $assert-nonnull/Foo#get:bar
       (call $~lib/rt/__tmptostack
        (if (result i32)
         (local.tee $2
          (call $~lib/rt/__localtostack
           (call $~lib/array/Array<assert-nonnull/Foo|null>#__get
            (call $~lib/rt/__tmptostack
             (if (result i32)
              (local.tee $1
               (call $~lib/rt/__localtostack
                (local.get $foo)
               )
              )
              (then
               (local.get $1)
              )
              (else
               (call $~lib/builtins/abort
                (i32.const 32)
                (i32.const 160)
                (i32.const 27)
                (i32.const 10)
               )
               (unreachable)
              )
             )
            )
            (i32.const 0)
           )
          )
         )
         (then
          (local.get $2)
         )
         (else
          (call $~lib/builtins/abort
           (i32.const 32)
           (i32.const 160)
           (i32.const 27)
           (i32.const 10)
          )
          (unreachable)
         )
        )
       )
      )
     )
    )
    (then
     (local.get $3)
    )
    (else
     (call $~lib/builtins/abort
      (i32.const 32)
      (i32.const 160)
      (i32.const 27)
      (i32.const 10)
     )
     (unreachable)
    )
   )
  )
 )
 (func $assert-nonnull/testAll2 (param $foo i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (return
   (if (result i32)
    (local.tee $3
     (call $~lib/rt/__localtostack
      (call $assert-nonnull/Foo#get:bar
       (call $~lib/rt/__tmptostack
        (if (result i32)
         (local.tee $2
          (call $~lib/rt/__localtostack
           (call $~lib/array/Array<assert-nonnull/Foo|null>#__get
            (call $~lib/rt/__tmptostack
             (if (result i32)
              (local.tee $1
               (call $~lib/rt/__localtostack
                (local.get $foo)
               )
              )
              (then
               (local.get $1)
              )
              (else
               (call $~lib/builtins/abort
                (i32.const 32)
                (i32.const 160)
                (i32.const 31)
                (i32.const 10)
               )
               (unreachable)
              )
             )
            )
            (i32.const 0)
           )
          )
         )
         (then
          (local.get $2)
         )
         (else
          (call $~lib/builtins/abort
           (i32.const 32)
           (i32.const 160)
           (i32.const 31)
           (i32.const 10)
          )
          (unreachable)
         )
        )
       )
      )
     )
    )
    (then
     (local.get $3)
    )
    (else
     (call $~lib/builtins/abort
      (i32.const 32)
      (i32.const 160)
      (i32.const 31)
      (i32.const 10)
     )
     (unreachable)
    )
   )
  )
 )
 (func $assert-nonnull/testFn (param $fn i32) (result i32)
  (local $1 i32)
  (return
   (call_indirect (type $1)
    (i32.load
     (block (result i32)
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (if (result i32)
       (local.tee $1
        (call $~lib/rt/__localtostack
         (local.get $fn)
        )
       )
       (then
        (local.get $1)
       )
       (else
        (call $~lib/builtins/abort
         (i32.const 32)
         (i32.const 160)
         (i32.const 35)
         (i32.const 10)
        )
        (unreachable)
       )
      )
     )
    )
   )
  )
 )
 (func $assert-nonnull/testFn2 (param $fn i32) (result i32)
  (local $1 i32)
  (local $fn2 i32)
  (local.set $fn2
   (call $~lib/rt/__localtostack
    (if (result i32)
     (local.tee $1
      (call $~lib/rt/__localtostack
       (local.get $fn)
      )
     )
     (then
      (local.get $1)
     )
     (else
      (call $~lib/builtins/abort
       (i32.const 32)
       (i32.const 160)
       (i32.const 39)
       (i32.const 13)
      )
      (unreachable)
     )
    )
   )
  )
  (return
   (call_indirect (type $1)
    (i32.load
     (block (result i32)
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (local.get $fn2)
     )
    )
   )
  )
 )
 (func $assert-nonnull/testRet (param $fn i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (return
   (if (result i32)
    (local.tee $2
     (call $~lib/rt/__localtostack
      (call_indirect (type $1)
       (i32.load
        (block (result i32)
         (global.set $~argumentsLength
          (i32.const 0)
         )
         (if (result i32)
          (local.tee $1
           (call $~lib/rt/__localtostack
            (local.get $fn)
           )
          )
          (then
           (local.get $1)
          )
          (else
           (call $~lib/builtins/abort
            (i32.const 32)
            (i32.const 160)
            (i32.const 44)
            (i32.const 10)
           )
           (unreachable)
          )
         )
        )
       )
      )
     )
    )
    (then
     (local.get $2)
    )
    (else
     (call $~lib/builtins/abort
      (i32.const 32)
      (i32.const 160)
      (i32.const 44)
      (i32.const 10)
     )
     (unreachable)
    )
   )
  )
 )
 (func $assert-nonnull/Foo#get:baz (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $assert-nonnull/testObjFn (param $foo i32) (result i32)
  (local $1 i32)
  (return
   (call_indirect (type $1)
    (i32.load
     (block (result i32)
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (if (result i32)
       (local.tee $1
        (call $~lib/rt/__localtostack
         (call $assert-nonnull/Foo#get:baz
          (call $~lib/rt/__tmptostack
           (local.get $foo)
          )
         )
        )
       )
       (then
        (local.get $1)
       )
       (else
        (call $~lib/builtins/abort
         (i32.const 32)
         (i32.const 160)
         (i32.const 48)
         (i32.const 10)
        )
        (unreachable)
       )
      )
     )
    )
   )
  )
 )
 (func $assert-nonnull/testObjRet (param $foo i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (return
   (if (result i32)
    (local.tee $2
     (call $~lib/rt/__localtostack
      (call_indirect (type $1)
       (i32.load
        (block (result i32)
         (global.set $~argumentsLength
          (i32.const 0)
         )
         (if (result i32)
          (local.tee $1
           (call $~lib/rt/__localtostack
            (call $assert-nonnull/Foo#get:baz
             (call $~lib/rt/__tmptostack
              (local.get $foo)
             )
            )
           )
          )
          (then
           (local.get $1)
          )
          (else
           (call $~lib/builtins/abort
            (i32.const 32)
            (i32.const 160)
            (i32.const 52)
            (i32.const 10)
           )
           (unreachable)
          )
         )
        )
       )
      )
     )
    )
    (then
     (local.get $2)
    )
    (else
     (call $~lib/builtins/abort
      (i32.const 32)
      (i32.const 160)
      (i32.const 52)
      (i32.const 10)
     )
     (unreachable)
    )
   )
  )
 )
)
