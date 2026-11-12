(module
 (type $0 (func (result i32)))
 (type $1 (func))
 (type $2 (func (param i32) (result i32)))
 (type $3 (func (param i32 i32 i32 i32)))
 (type $4 (func (param i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $memory/ptr (mut i32) (i32.const 80))
 (global $~lib/memory/__data_end i32 (i32.const 212))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32980))
 (global $~lib/memory/__heap_base i32 (i32.const 32980))
 (memory $0 1)
 (data $0 (i32.const 16) "\00\00\00\00")
 (data $1 (i32.const 28) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00m\00e\00m\00o\00r\00y\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 80) "\00")
 (data $3 (i32.const 96) "\00")
 (data $4 (i32.const 104) "\00")
 (data $5 (i32.const 108) "\00")
 (data $6 (i32.const 110) "\00")
 (data $7 (i32.const 111) "\00")
 (data $8 (i32.const 112) "\00")
 (data $9 (i32.const 128) "\00")
 (data $10 (i32.const 144) "\00")
 (data $11 (i32.const 152) "\00")
 (data $12 (i32.const 156) "\00")
 (data $13 (i32.const 158) "\00")
 (data $14 (i32.const 159) "\00")
 (data $15 (i32.const 160) "\00")
 (data $16 (i32.const 161) "\01\02\03")
 (data $17 (i32.const 164) "\00\00\c0?\00\00 @\00\00`@")
 (data $18 (i32.const 176) "\00")
 (data $19 (i32.const 192) "\01")
 (data $20 (i32.const 200) "\01")
 (data $21 (i32.const 204) "\01")
 (data $22 (i32.const 206) "\01")
 (data $23 (i32.const 207) "\01")
 (data $24 (i32.const 208) "\01")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $memory/test (result i32)
  (local $value i32)
  (local.set $value
   (i32.load
    (i32.const 16)
   )
  )
  (i32.store
   (i32.const 16)
   (i32.add
    (local.get $value)
    (i32.const 1)
   )
  )
  (return
   (local.get $value)
  )
 )
 (func $memory/testGeneric<v128> (result i32)
  (return
   (i32.const 144)
  )
 )
 (func $memory/testGeneric<i64> (result i32)
  (return
   (i32.const 152)
  )
 )
 (func $memory/testGeneric<i32> (result i32)
  (return
   (i32.const 156)
  )
 )
 (func $memory/testGeneric<i16> (result i32)
  (return
   (i32.const 158)
  )
 )
 (func $memory/testGeneric<i8> (result i32)
  (return
   (i32.const 159)
  )
 )
 (func $start:memory
  (if
   (i32.eqz
    (i32.eq
     (call $memory/test)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 12)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $memory/test)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 13)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $memory/test)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 14)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 16)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 96)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 19)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 8)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 104)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 20)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 4)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 108)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 21)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 2)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 110)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 22)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 1)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 111)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 1)
     )
     (i32.const 112)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 24)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memory/ptr
   (i32.const 128)
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 16)
     )
     (block (result i32)
      (global.set $memory/ptr
       (call $memory/testGeneric<v128>)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 34)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 8)
     )
     (block (result i32)
      (global.set $memory/ptr
       (call $memory/testGeneric<i64>)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 35)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 4)
     )
     (block (result i32)
      (global.set $memory/ptr
       (call $memory/testGeneric<i32>)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 36)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 2)
     )
     (block (result i32)
      (global.set $memory/ptr
       (call $memory/testGeneric<i16>)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 37)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 1)
     )
     (block (result i32)
      (global.set $memory/ptr
       (call $memory/testGeneric<i8>)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 38)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 1)
     )
     (i32.const 160)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 39)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memory/ptr
   (i32.const 161)
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.load8_u
      (global.get $memory/ptr)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 44)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.load8_u offset=1
      (global.get $memory/ptr)
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 45)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.load8_u offset=2
      (global.get $memory/ptr)
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 46)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memory/ptr
   (i32.const 164)
  )
  (if
   (i32.eqz
    (f32.eq
     (f32.load
      (global.get $memory/ptr)
     )
     (f32.const 1.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 49)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (f32.load offset=4
      (global.get $memory/ptr)
     )
     (f32.const 2.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 50)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (f32.load offset=8
      (global.get $memory/ptr)
     )
     (f32.const 3.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 51)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $memory/ptr
   (i32.const 176)
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 16)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 192)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 56)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 8)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 200)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 57)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 4)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 204)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 58)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 2)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 206)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 59)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 1)
     )
     (block (result i32)
      (global.set $memory/ptr
       (i32.const 207)
      )
      (global.get $memory/ptr)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 60)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (global.get $memory/ptr)
      (i32.const 1)
     )
     (i32.const 208)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 61)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32) (param $2 i32)
  (memory.fill
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )
 (func $~start
  (call $start:memory)
 )
)
