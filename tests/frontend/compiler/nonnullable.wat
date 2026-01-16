(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32)))
 (type $3 (func))
 (type $4 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $5 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $nonnullable/z (mut i32) (i32.const 224))
 (global $~lib/memory/__data_end i32 (i32.const 364))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33132))
 (global $~lib/memory/__heap_base i32 (i32.const 33132))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00u\003\002\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00n\00o\00n\00n\00u\00l\00l\00a\00b\00l\00e\00.\00t\00s\00")
 (data $2 (i32.const 92) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00S\00t\00r\00i\00n\00g\00")
 (data $3 (i32.const 124) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\002\00\00\00A\00r\00r\00a\00y\00<\00~\00l\00i\00b\00/\00s\00t\00r\00i\00n\00g\00/\00S\00t\00r\00i\00n\00g\00>\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 204) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00z\00\00\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 236) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00^\00\00\00U\00n\00e\00x\00p\00e\00c\00t\00e\00d\00 \00\'\00n\00u\00l\00l\00\'\00 \00(\00n\00o\00t\00 \00a\00s\00s\00i\00g\00n\00e\00d\00 \00o\00r\00 \00f\00a\00i\00l\00e\00d\00 \00c\00a\00s\00t\00)\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/common/OBJECT#get:rtSize (param $this i32) (result i32)
  (i32.load offset=16
   (local.get $this)
  )
 )
 (func $~lib/string/String#get:length (param $this i32) (result i32)
  (return
   (i32.shr_u
    (call $~lib/rt/common/OBJECT#get:rtSize
     (i32.sub
      (local.get $this)
      (i32.const 20)
     )
    )
    (i32.const 1)
   )
  )
 )
 (func $~lib/util/string/compareImpl (param $str1 i32) (param $index1 i32) (param $str2 i32) (param $index2 i32) (param $len i32) (result i32)
  (local $ptr1 i32)
  (local $ptr2 i32)
  (local $7 i32)
  (local $a i32)
  (local $b i32)
  (local.set $ptr1
   (i32.add
    (local.get $str1)
    (i32.shl
     (local.get $index1)
     (i32.const 1)
    )
   )
  )
  (local.set $ptr2
   (i32.add
    (local.get $str2)
    (i32.shl
     (local.get $index2)
     (i32.const 1)
    )
   )
  )
  (drop
   (i32.lt_s
    (i32.const 0)
    (i32.const 2)
   )
  )
  (if
   (if (result i32)
    (i32.ge_u
     (local.get $len)
     (i32.const 4)
    )
    (then
     (i32.eqz
      (i32.or
       (i32.and
        (local.get $ptr1)
        (i32.const 7)
       )
       (i32.and
        (local.get $ptr2)
        (i32.const 7)
       )
      )
     )
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (block $do-break|0
     (loop $do-loop|0
      (if
       (i64.ne
        (i64.load
         (local.get $ptr1)
        )
        (i64.load
         (local.get $ptr2)
        )
       )
       (then
        (br $do-break|0)
       )
      )
      (local.set $ptr1
       (i32.add
        (local.get $ptr1)
        (i32.const 8)
       )
      )
      (local.set $ptr2
       (i32.add
        (local.get $ptr2)
        (i32.const 8)
       )
      )
      (local.set $len
       (i32.sub
        (local.get $len)
        (i32.const 4)
       )
      )
      (br_if $do-loop|0
       (i32.ge_u
        (local.get $len)
        (i32.const 4)
       )
      )
     )
    )
   )
  )
  (block $while-break|1
   (loop $while-continue|1
    (if
     (block (result i32)
      (local.set $len
       (i32.sub
        (local.tee $7
         (local.get $len)
        )
        (i32.const 1)
       )
      )
      (local.get $7)
     )
     (then
      (local.set $a
       (i32.load16_u
        (local.get $ptr1)
       )
      )
      (local.set $b
       (i32.load16_u
        (local.get $ptr2)
       )
      )
      (if
       (i32.ne
        (local.get $a)
        (local.get $b)
       )
       (then
        (return
         (i32.sub
          (local.get $a)
          (local.get $b)
         )
        )
       )
      )
      (local.set $ptr1
       (i32.add
        (local.get $ptr1)
        (i32.const 2)
       )
      )
      (local.set $ptr2
       (i32.add
        (local.get $ptr2)
        (i32.const 2)
       )
      )
      (br $while-continue|1)
     )
    )
   )
  )
  (return
   (i32.const 0)
  )
 )
 (func $~lib/string/String.__eq (param $left i32) (param $right i32) (result i32)
  (local $leftLength i32)
  (if
   (i32.eq
    (local.get $left)
    (local.get $right)
   )
   (then
    (return
     (i32.const 1)
    )
   )
  )
  (if
   (if (result i32)
    (i32.eq
     (local.get $left)
     (i32.const 0)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.eq
      (local.get $right)
      (i32.const 0)
     )
    )
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (local.set $leftLength
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (local.get $left)
    )
   )
  )
  (if
   (i32.ne
    (local.get $leftLength)
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $right)
     )
    )
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (return
   (i32.eqz
    (call $~lib/util/string/compareImpl
     (call $~lib/rt/__tmptostack
      (local.get $left)
     )
     (i32.const 0)
     (call $~lib/rt/__tmptostack
      (local.get $right)
     )
     (i32.const 0)
     (local.get $leftLength)
    )
   )
  )
 )
 (func $~lib/string/String.__ne (param $left i32) (param $right i32) (result i32)
  (return
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (local.get $left)
     )
     (call $~lib/rt/__tmptostack
      (local.get $right)
     )
    )
   )
  )
 )
 (func $nonnullable/assertNonNull<~lib/string/String> (param $t i32)
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__ne
     (call $~lib/rt/__tmptostack
      (local.get $t)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 9)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $nonnullable/safetyCheck<~lib/string/String|null> (param $t i32)
  (if
   (call $~lib/string/String.__ne
    (call $~lib/rt/__tmptostack
     (local.get $t)
    )
    (i32.const 0)
   )
   (then
    (call $nonnullable/assertNonNull<~lib/string/String>
     (call $~lib/rt/__tmptostack
      (local.get $t)
     )
    )
   )
  )
 )
 (func $start:nonnullable
  (local $0 i32)
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (i32.const 32)
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 3)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (i32.const 112)
     (i32.const 112)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 4)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (i32.const 144)
     (i32.const 144)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 5)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (call $nonnullable/assertNonNull<~lib/string/String>
   (call $~lib/rt/__tmptostack
    (if (result i32)
     (local.tee $0
      (call $~lib/rt/__localtostack
       (global.get $nonnullable/z)
      )
     )
     (then
      (local.get $0)
     )
     (else
      (call $~lib/builtins/abort
       (i32.const 256)
       (i32.const 64)
       (i32.const 20)
       (i32.const 40)
      )
      (unreachable)
     )
    )
   )
  )
  (call $nonnullable/safetyCheck<~lib/string/String|null>
   (call $~lib/rt/__tmptostack
    (global.get $nonnullable/z)
   )
  )
 )
 (func $~start
  (call $start:nonnullable)
 )
)
