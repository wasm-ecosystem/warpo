(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32 i32)))
 (type $3 (func))
 (type $4 (func (param i32 i32 i32 i32)))
 (type $5 (func (param i32 i32 f32)))
 (type $6 (func (param i32 i32) (result f32)))
 (type $7 (func (param i32 f32)))
 (type $8 (func (param i32) (result f32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $std/pointer/one (mut i32) (i32.const 0))
 (global $std/pointer/two (mut i32) (i32.const 0))
 (global $std/pointer/add (mut i32) (i32.const 0))
 (global $std/pointer/sub (mut i32) (i32.const 0))
 (global $std/pointer/nextOne (mut i32) (i32.const 0))
 (global $std/pointer/buf (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00s\00t\00d\00/\00p\00o\00i\00n\00t\00e\00r\00.\00t\00s\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $std/pointer/Pointer<std/pointer/Entry>#constructor (param $this i32) (param $offset i32) (result i32)
  (return
   (local.get $offset)
  )
 )
 (func $std/pointer/Pointer<std/pointer/Entry>#get:offset (param $this i32) (result i32)
  (return
   (local.get $this)
  )
 )
 (func $std/pointer/Pointer<std/pointer/Entry>#get:value (param $this i32) (result i32)
  (drop
   (i32.const 1)
  )
  (return
   (local.get $this)
  )
 )
 (func $std/pointer/Entry#set:key (param $this i32) (param $key i32)
  (i32.store
   (local.get $this)
   (local.get $key)
  )
 )
 (func $std/pointer/Entry#set:val (param $this i32) (param $val i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $val)
  )
 )
 (func $std/pointer/Entry#get:key (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $std/pointer/Entry#get:val (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $std/pointer/Pointer<std/pointer/Entry>#add (param $this i32) (param $other i32) (result i32)
  (return
   (i32.add
    (local.get $this)
    (local.get $other)
   )
  )
 )
 (func $std/pointer/Pointer<std/pointer/Entry>#sub (param $this i32) (param $other i32) (result i32)
  (return
   (i32.sub
    (local.get $this)
    (local.get $other)
   )
  )
 )
 (func $std/pointer/Pointer<std/pointer/Entry>#inc (param $this i32) (result i32)
  (return
   (i32.add
    (local.get $this)
    (i32.const 8)
   )
  )
 )
 (func $std/pointer/Pointer<std/pointer/Entry>#dec (param $this i32) (result i32)
  (return
   (i32.sub
    (local.get $this)
    (i32.const 8)
   )
  )
 )
 (func $std/pointer/Pointer<std/pointer/Entry>#set:value (param $this i32) (param $value i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.const 0)
   )
   (if
    (i32.eq
     (local.get $value)
     (i32.const 0)
    )
    (then
     (memory.fill
      (local.get $this)
      (i32.const 0)
      (i32.const 8)
     )
    )
    (else
     (memory.copy
      (local.get $this)
      (local.get $value)
      (i32.const 8)
     )
    )
   )
  )
 )
 (func $std/pointer/Pointer<f32>#constructor (param $this i32) (param $offset i32) (result i32)
  (return
   (local.get $offset)
  )
 )
 (func $std/pointer/Pointer<f32>#set (param $this i32) (param $index i32) (param $value f32)
  (f32.store
   (i32.add
    (local.get $this)
    (i32.mul
     (local.get $index)
     (i32.const 4)
    )
   )
   (local.get $value)
  )
 )
 (func $std/pointer/Pointer<f32>#get (param $this i32) (param $index i32) (result f32)
  (return
   (f32.load
    (i32.add
     (local.get $this)
     (i32.mul
      (local.get $index)
      (i32.const 4)
     )
    )
   )
  )
 )
 (func $std/pointer/Pointer<f32>#set:value (param $this i32) (param $value f32)
  (drop
   (i32.const 0)
  )
  (f32.store
   (local.get $this)
   (local.get $value)
  )
 )
 (func $std/pointer/Pointer<f32>#get:value (param $this i32) (result f32)
  (drop
   (i32.const 0)
  )
  (return
   (f32.load
    (local.get $this)
   )
  )
 )
 (func $start:std/pointer
  (global.set $std/pointer/one
   (call $std/pointer/Pointer<std/pointer/Entry>#constructor
    (i32.const 0)
    (i32.const 8)
   )
  )
  (global.set $std/pointer/two
   (call $std/pointer/Pointer<std/pointer/Entry>#constructor
    (i32.const 0)
    (i32.const 24)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/one)
     )
     (i32.const 8)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 87)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/two)
     )
     (i32.const 24)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 88)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (call $std/pointer/Entry#set:key
   (call $std/pointer/Pointer<std/pointer/Entry>#get:value
    (global.get $std/pointer/one)
   )
   (i32.const 1)
  )
  (call $std/pointer/Entry#set:val
   (call $std/pointer/Pointer<std/pointer/Entry>#get:value
    (global.get $std/pointer/one)
   )
   (i32.const 2)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Entry#get:key
      (call $std/pointer/Pointer<std/pointer/Entry>#get:value
       (global.get $std/pointer/one)
      )
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 92)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Entry#get:val
      (call $std/pointer/Pointer<std/pointer/Entry>#get:value
       (global.get $std/pointer/one)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 93)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/pointer/add
   (call $std/pointer/Pointer<std/pointer/Entry>#add
    (global.get $std/pointer/one)
    (global.get $std/pointer/two)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/add)
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 96)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/pointer/sub
   (call $std/pointer/Pointer<std/pointer/Entry>#sub
    (global.get $std/pointer/two)
    (global.get $std/pointer/one)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/sub)
     )
     (i32.const 16)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 99)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/one)
     )
     (i32.const 8)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 101)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/pointer/nextOne
   (block (result i32)
    (global.set $std/pointer/one
     (call $std/pointer/Pointer<std/pointer/Entry>#inc
      (global.get $std/pointer/one)
     )
    )
    (global.get $std/pointer/one)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/pointer/nextOne)
     (global.get $std/pointer/one)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 103)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/one)
     )
     (i32.const 16)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 104)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/two)
     )
     (i32.const 24)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 106)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/pointer/two
   (call $std/pointer/Pointer<std/pointer/Entry>#dec
    (global.get $std/pointer/two)
   )
  )
  (global.set $std/pointer/two
   (call $std/pointer/Pointer<std/pointer/Entry>#dec
    (global.get $std/pointer/two)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/two)
     )
     (i32.const 8)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 109)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Entry#get:key
      (call $std/pointer/Pointer<std/pointer/Entry>#get:value
       (global.get $std/pointer/two)
      )
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 110)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Entry#get:val
      (call $std/pointer/Pointer<std/pointer/Entry>#get:value
       (global.get $std/pointer/two)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 111)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (call $std/pointer/Pointer<std/pointer/Entry>#set:value
   (global.get $std/pointer/one)
   (call $std/pointer/Pointer<std/pointer/Entry>#get:value
    (global.get $std/pointer/two)
   )
  )
  (if
   (i32.eqz
    (i32.ne
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/one)
     )
     (call $std/pointer/Pointer<std/pointer/Entry>#get:offset
      (global.get $std/pointer/two)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 114)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Entry#get:key
      (call $std/pointer/Pointer<std/pointer/Entry>#get:value
       (global.get $std/pointer/one)
      )
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 115)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Entry#get:val
      (call $std/pointer/Pointer<std/pointer/Entry>#get:value
       (global.get $std/pointer/one)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 116)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/pointer/buf
   (call $std/pointer/Pointer<f32>#constructor
    (i32.const 0)
    (i32.const 0)
   )
  )
  (call $std/pointer/Pointer<f32>#set
   (global.get $std/pointer/buf)
   (i32.const 0)
   (f32.const 1.100000023841858)
  )
  (call $std/pointer/Pointer<f32>#set
   (global.get $std/pointer/buf)
   (i32.const 1)
   (f32.const 1.2000000476837158)
  )
  (if
   (i32.eqz
    (f32.eq
     (call $std/pointer/Pointer<f32>#get
      (global.get $std/pointer/buf)
      (i32.const 0)
     )
     (f32.const 1.100000023841858)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 122)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (call $std/pointer/Pointer<f32>#get
      (global.get $std/pointer/buf)
      (i32.const 1)
     )
     (f32.const 1.2000000476837158)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 123)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (call $std/pointer/Pointer<f32>#get
      (global.get $std/pointer/buf)
      (i32.const 0)
     )
     (f32.const 1.100000023841858)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 125)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (call $std/pointer/Pointer<f32>#get
      (global.get $std/pointer/buf)
      (i32.const 1)
     )
     (f32.const 1.2000000476837158)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 126)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (f32.load
      (i32.const 0)
     )
     (f32.const 1.100000023841858)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 128)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (f32.load
      (i32.const 4)
     )
     (f32.const 1.2000000476837158)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 129)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (call $std/pointer/Pointer<f32>#set
   (global.get $std/pointer/buf)
   (i32.const 2)
   (f32.const 1.2999999523162842)
  )
  (if
   (i32.eqz
    (f32.eq
     (call $std/pointer/Pointer<f32>#get
      (global.get $std/pointer/buf)
      (i32.const 2)
     )
     (f32.const 1.2999999523162842)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 132)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (call $std/pointer/Pointer<f32>#get
      (global.get $std/pointer/buf)
      (i32.const 2)
     )
     (f32.const 1.2999999523162842)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 133)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (f32.load
      (i32.const 8)
     )
     (f32.const 1.2999999523162842)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 134)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (call $std/pointer/Pointer<f32>#set:value
   (global.get $std/pointer/buf)
   (f32.const 1.399999976158142)
  )
  (if
   (i32.eqz
    (f32.eq
     (call $std/pointer/Pointer<f32>#get:value
      (global.get $std/pointer/buf)
     )
     (f32.const 1.399999976158142)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 137)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (f32.load
      (i32.const 0)
     )
     (f32.const 1.399999976158142)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 138)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:std/pointer)
 )
)
