(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $4 (func (param i32 i32 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 284))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33052))
 (global $~lib/memory/__heap_base i32 (i32.const 33052))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 76) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00")
 (data $2 (i32.const 124) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 252) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "i32ArrayArrayElementAccess" (func $std/array-access/i32ArrayArrayElementAccess))
 (export "stringArrayPropertyAccess" (func $std/array-access/stringArrayPropertyAccess))
 (export "stringArrayMethodCall" (func $std/array-access/stringArrayMethodCall))
 (export "stringArrayArrayPropertyAccess" (func $std/array-access/stringArrayArrayPropertyAccess))
 (export "stringArrayArrayMethodCall" (func $std/array-access/stringArrayArrayMethodCall))
 (export "functionArrayElementCall" (func $std/array-access/functionArrayElementCall))
 (export "memory" (memory $0))
 (func $~lib/array/Array<~lib/array/Array<i32>>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<~lib/array/Array<i32>>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 32)
     (i32.const 96)
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
      (call $~lib/array/Array<~lib/array/Array<i32>>#get:dataStart
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
      (i32.const 144)
      (i32.const 96)
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
 (func $~lib/array/Array<i32>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<i32>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<i32>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<i32>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 32)
     (i32.const 96)
     (i32.const 123)
     (i32.const 42)
    )
    (unreachable)
   )
  )
  (local.set $value
   (i32.load
    (i32.add
     (call $~lib/array/Array<i32>#get:dataStart
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
  (drop
   (i32.const 0)
  )
  (return
   (local.get $value)
  )
 )
 (func $std/array-access/i32ArrayArrayElementAccess (param $a i32) (result i32)
  (return
   (call $~lib/array/Array<i32>#__get
    (call $~lib/rt/__tmptostack
     (call $~lib/array/Array<~lib/array/Array<i32>>#__get
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
      (i32.const 0)
     )
    )
    (i32.const 1)
   )
  )
 )
 (func $~lib/array/Array<~lib/string/String>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/string/String>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/string/String>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<~lib/string/String>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 32)
     (i32.const 96)
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
      (call $~lib/array/Array<~lib/string/String>#get:dataStart
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
      (i32.const 144)
      (i32.const 96)
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
 (func $std/array-access/stringArrayPropertyAccess (param $a i32) (result i32)
  (return
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (call $~lib/array/Array<~lib/string/String>#__get
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
      (i32.const 0)
     )
    )
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
 (func $~lib/string/String#startsWith (param $this i32) (param $search i32) (param $start i32) (result i32)
  (local $len i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $searchStart i32)
  (local $searchLength i32)
  (local.set $len
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $searchStart
   (select
    (local.tee $6
     (select
      (local.tee $4
       (local.get $start)
      )
      (local.tee $5
       (i32.const 0)
      )
      (i32.gt_s
       (local.get $4)
       (local.get $5)
      )
     )
    )
    (local.tee $7
     (local.get $len)
    )
    (i32.lt_s
     (local.get $6)
     (local.get $7)
    )
   )
  )
  (local.set $searchLength
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (local.get $search)
    )
   )
  )
  (if
   (i32.gt_s
    (i32.add
     (local.get $searchLength)
     (local.get $searchStart)
    )
    (local.get $len)
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
      (local.get $this)
     )
     (local.get $searchStart)
     (call $~lib/rt/__tmptostack
      (local.get $search)
     )
     (i32.const 0)
     (local.get $searchLength)
    )
   )
  )
 )
 (func $std/array-access/stringArrayMethodCall (param $a i32) (result i32)
  (return
   (call $~lib/string/String#startsWith
    (call $~lib/rt/__tmptostack
     (call $~lib/array/Array<~lib/string/String>#__get
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
      (i32.const 0)
     )
    )
    (i32.const 272)
    (i32.const 0)
   )
  )
 )
 (func $~lib/array/Array<~lib/array/Array<~lib/string/String>>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<~lib/string/String>>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<~lib/string/String>>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<~lib/array/Array<~lib/string/String>>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 32)
     (i32.const 96)
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
      (call $~lib/array/Array<~lib/array/Array<~lib/string/String>>#get:dataStart
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
      (i32.const 144)
      (i32.const 96)
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
 (func $std/array-access/stringArrayArrayPropertyAccess (param $a i32) (result i32)
  (return
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (call $~lib/array/Array<~lib/string/String>#__get
      (call $~lib/rt/__tmptostack
       (call $~lib/array/Array<~lib/array/Array<~lib/string/String>>#__get
        (call $~lib/rt/__tmptostack
         (local.get $a)
        )
        (i32.const 0)
       )
      )
      (i32.const 1)
     )
    )
   )
  )
 )
 (func $std/array-access/stringArrayArrayMethodCall (param $a i32) (result i32)
  (return
   (call $~lib/string/String#startsWith
    (call $~lib/rt/__tmptostack
     (call $~lib/array/Array<~lib/string/String>#__get
      (call $~lib/rt/__tmptostack
       (call $~lib/array/Array<~lib/array/Array<~lib/string/String>>#__get
        (call $~lib/rt/__tmptostack
         (local.get $a)
        )
        (i32.const 0)
       )
      )
      (i32.const 1)
     )
    )
    (i32.const 272)
    (i32.const 0)
   )
  )
 )
 (func $~lib/array/Array<%28i32%29=>i32>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<%28i32%29=>i32>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<%28i32%29=>i32>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<%28i32%29=>i32>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 32)
     (i32.const 96)
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
      (call $~lib/array/Array<%28i32%29=>i32>#get:dataStart
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
      (i32.const 144)
      (i32.const 96)
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
 (func $std/array-access/functionArrayElementCall (param $a i32) (result i32)
  (return
   (call_indirect (type $0)
    (i32.const 123)
    (i32.load
     (block (result i32)
      (global.set $~argumentsLength
       (i32.const 1)
      )
      (call $~lib/array/Array<%28i32%29=>i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $a)
       )
       (i32.const 0)
      )
     )
    )
   )
  )
 )
)
