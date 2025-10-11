(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32 i32)))
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
 (func $start:std/pointer
  (local $this i32)
  (local $offset i32)
  (local $this|2 i32)
  (local $offset|3 i32)
  (local $this|4 i32)
  (local $this|5 i32)
  (local $this|6 i32)
  (local $this|7 i32)
  (local $this|8 i32)
  (local $this|9 i32)
  (local $this|10 i32)
  (local $other i32)
  (local $this|12 i32)
  (local $this|13 i32)
  (local $other|14 i32)
  (local $this|15 i32)
  (local $this|16 i32)
  (local $this|17 i32)
  (local $this|18 i32)
  (local $this|19 i32)
  (local $this|20 i32)
  (local $this|21 i32)
  (local $this|22 i32)
  (local $this|23 i32)
  (local $this|24 i32)
  (local $this|25 i32)
  (local $this|26 i32)
  (local $value i32)
  (local $this|28 i32)
  (local $this|29 i32)
  (local $this|30 i32)
  (local $this|31 i32)
  (local $this|32 i32)
  (local $offset|33 i32)
  (local $this|34 i32)
  (local $index i32)
  (local $value|36 f32)
  (local $this|37 i32)
  (local $index|38 i32)
  (local $value|39 f32)
  (local $this|40 i32)
  (local $index|41 i32)
  (local $this|42 i32)
  (local $index|43 i32)
  (local $this|44 i32)
  (local $index|45 i32)
  (local $this|46 i32)
  (local $index|47 i32)
  (local $this|48 i32)
  (local $index|49 i32)
  (local $value|50 f32)
  (local $this|51 i32)
  (local $index|52 i32)
  (local $this|53 i32)
  (local $index|54 i32)
  (local $this|55 i32)
  (local $value|56 f32)
  (local $this|57 i32)
  (global.set $std/pointer/one
   (block $std/pointer/Pointer<std/pointer/Entry>#constructor|inlined.0 (result i32)
    (local.set $this
     (i32.const 0)
    )
    (local.set $offset
     (i32.const 8)
    )
    (br $std/pointer/Pointer<std/pointer/Entry>#constructor|inlined.0
     (local.get $offset)
    )
   )
  )
  (global.set $std/pointer/two
   (block $std/pointer/Pointer<std/pointer/Entry>#constructor|inlined.1 (result i32)
    (local.set $this|2
     (i32.const 0)
    )
    (local.set $offset|3
     (i32.const 24)
    )
    (br $std/pointer/Pointer<std/pointer/Entry>#constructor|inlined.1
     (local.get $offset|3)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.0 (result i32)
      (local.set $this|4
       (global.get $std/pointer/one)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.0
       (local.get $this|4)
      )
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
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.1 (result i32)
      (local.set $this|5
       (global.get $std/pointer/two)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.1
       (local.get $this|5)
      )
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
   (block $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.0 (result i32)
    (local.set $this|6
     (global.get $std/pointer/one)
    )
    (drop
     (i32.const 1)
    )
    (br $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.0
     (local.get $this|6)
    )
   )
   (i32.const 1)
  )
  (call $std/pointer/Entry#set:val
   (block $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.1 (result i32)
    (local.set $this|7
     (global.get $std/pointer/one)
    )
    (drop
     (i32.const 1)
    )
    (br $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.1
     (local.get $this|7)
    )
   )
   (i32.const 2)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/pointer/Entry#get:key
      (block $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.2 (result i32)
       (local.set $this|8
        (global.get $std/pointer/one)
       )
       (drop
        (i32.const 1)
       )
       (br $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.2
        (local.get $this|8)
       )
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
      (block $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.3 (result i32)
       (local.set $this|9
        (global.get $std/pointer/one)
       )
       (drop
        (i32.const 1)
       )
       (br $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.3
        (local.get $this|9)
       )
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
   (block $std/pointer/Pointer<std/pointer/Entry>#add|inlined.0 (result i32)
    (local.set $this|10
     (global.get $std/pointer/one)
    )
    (local.set $other
     (global.get $std/pointer/two)
    )
    (br $std/pointer/Pointer<std/pointer/Entry>#add|inlined.0
     (i32.add
      (local.get $this|10)
      (local.get $other)
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.2 (result i32)
      (local.set $this|12
       (global.get $std/pointer/add)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.2
       (local.get $this|12)
      )
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
   (block $std/pointer/Pointer<std/pointer/Entry>#sub|inlined.0 (result i32)
    (local.set $this|13
     (global.get $std/pointer/two)
    )
    (local.set $other|14
     (global.get $std/pointer/one)
    )
    (br $std/pointer/Pointer<std/pointer/Entry>#sub|inlined.0
     (i32.sub
      (local.get $this|13)
      (local.get $other|14)
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.3 (result i32)
      (local.set $this|15
       (global.get $std/pointer/sub)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.3
       (local.get $this|15)
      )
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
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.4 (result i32)
      (local.set $this|16
       (global.get $std/pointer/one)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.4
       (local.get $this|16)
      )
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
     (block $std/pointer/Pointer<std/pointer/Entry>#inc|inlined.0 (result i32)
      (local.set $this|17
       (global.get $std/pointer/one)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#inc|inlined.0
       (i32.add
        (local.get $this|17)
        (i32.const 8)
       )
      )
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
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.5 (result i32)
      (local.set $this|18
       (global.get $std/pointer/one)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.5
       (local.get $this|18)
      )
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
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.6 (result i32)
      (local.set $this|19
       (global.get $std/pointer/two)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.6
       (local.get $this|19)
      )
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
   (block $std/pointer/Pointer<std/pointer/Entry>#dec|inlined.0 (result i32)
    (local.set $this|20
     (global.get $std/pointer/two)
    )
    (br $std/pointer/Pointer<std/pointer/Entry>#dec|inlined.0
     (i32.sub
      (local.get $this|20)
      (i32.const 8)
     )
    )
   )
  )
  (global.set $std/pointer/two
   (block $std/pointer/Pointer<std/pointer/Entry>#dec|inlined.1 (result i32)
    (local.set $this|21
     (global.get $std/pointer/two)
    )
    (br $std/pointer/Pointer<std/pointer/Entry>#dec|inlined.1
     (i32.sub
      (local.get $this|21)
      (i32.const 8)
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.7 (result i32)
      (local.set $this|22
       (global.get $std/pointer/two)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.7
       (local.get $this|22)
      )
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
      (block $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.4 (result i32)
       (local.set $this|23
        (global.get $std/pointer/two)
       )
       (drop
        (i32.const 1)
       )
       (br $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.4
        (local.get $this|23)
       )
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
      (block $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.5 (result i32)
       (local.set $this|24
        (global.get $std/pointer/two)
       )
       (drop
        (i32.const 1)
       )
       (br $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.5
        (local.get $this|24)
       )
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
  (block $std/pointer/Pointer<std/pointer/Entry>#set:value|inlined.0
   (local.set $this|26
    (global.get $std/pointer/one)
   )
   (local.set $value
    (block $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.6 (result i32)
     (local.set $this|25
      (global.get $std/pointer/two)
     )
     (drop
      (i32.const 1)
     )
     (br $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.6
      (local.get $this|25)
     )
    )
   )
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
       (local.get $this|26)
       (i32.const 0)
       (i32.const 8)
      )
     )
     (else
      (memory.copy
       (local.get $this|26)
       (local.get $value)
       (i32.const 8)
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.ne
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.8 (result i32)
      (local.set $this|28
       (global.get $std/pointer/one)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.8
       (local.get $this|28)
      )
     )
     (block $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.9 (result i32)
      (local.set $this|29
       (global.get $std/pointer/two)
      )
      (br $std/pointer/Pointer<std/pointer/Entry>#get:offset|inlined.9
       (local.get $this|29)
      )
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
      (block $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.7 (result i32)
       (local.set $this|30
        (global.get $std/pointer/one)
       )
       (drop
        (i32.const 1)
       )
       (br $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.7
        (local.get $this|30)
       )
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
      (block $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.8 (result i32)
       (local.set $this|31
        (global.get $std/pointer/one)
       )
       (drop
        (i32.const 1)
       )
       (br $std/pointer/Pointer<std/pointer/Entry>#get:value|inlined.8
        (local.get $this|31)
       )
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
   (block $std/pointer/Pointer<f32>#constructor|inlined.0 (result i32)
    (local.set $this|32
     (i32.const 0)
    )
    (local.set $offset|33
     (i32.const 0)
    )
    (br $std/pointer/Pointer<f32>#constructor|inlined.0
     (local.get $offset|33)
    )
   )
  )
  (block $std/pointer/Pointer<f32>#set|inlined.0
   (local.set $this|34
    (global.get $std/pointer/buf)
   )
   (local.set $index
    (i32.const 0)
   )
   (local.set $value|36
    (f32.const 1.100000023841858)
   )
   (f32.store
    (i32.add
     (local.get $this|34)
     (i32.mul
      (local.get $index)
      (i32.const 4)
     )
    )
    (local.get $value|36)
   )
  )
  (block $std/pointer/Pointer<f32>#set|inlined.1
   (local.set $this|37
    (global.get $std/pointer/buf)
   )
   (local.set $index|38
    (i32.const 1)
   )
   (local.set $value|39
    (f32.const 1.2000000476837158)
   )
   (f32.store
    (i32.add
     (local.get $this|37)
     (i32.mul
      (local.get $index|38)
      (i32.const 4)
     )
    )
    (local.get $value|39)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (block $std/pointer/Pointer<f32>#get|inlined.0 (result f32)
      (local.set $this|40
       (global.get $std/pointer/buf)
      )
      (local.set $index|41
       (i32.const 0)
      )
      (br $std/pointer/Pointer<f32>#get|inlined.0
       (f32.load
        (i32.add
         (local.get $this|40)
         (i32.mul
          (local.get $index|41)
          (i32.const 4)
         )
        )
       )
      )
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
     (block $std/pointer/Pointer<f32>#get|inlined.1 (result f32)
      (local.set $this|42
       (global.get $std/pointer/buf)
      )
      (local.set $index|43
       (i32.const 1)
      )
      (br $std/pointer/Pointer<f32>#get|inlined.1
       (f32.load
        (i32.add
         (local.get $this|42)
         (i32.mul
          (local.get $index|43)
          (i32.const 4)
         )
        )
       )
      )
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
     (block $std/pointer/Pointer<f32>#get|inlined.2 (result f32)
      (local.set $this|44
       (global.get $std/pointer/buf)
      )
      (local.set $index|45
       (i32.const 0)
      )
      (br $std/pointer/Pointer<f32>#get|inlined.2
       (f32.load
        (i32.add
         (local.get $this|44)
         (i32.mul
          (local.get $index|45)
          (i32.const 4)
         )
        )
       )
      )
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
     (block $std/pointer/Pointer<f32>#get|inlined.3 (result f32)
      (local.set $this|46
       (global.get $std/pointer/buf)
      )
      (local.set $index|47
       (i32.const 1)
      )
      (br $std/pointer/Pointer<f32>#get|inlined.3
       (f32.load
        (i32.add
         (local.get $this|46)
         (i32.mul
          (local.get $index|47)
          (i32.const 4)
         )
        )
       )
      )
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
  (block $std/pointer/Pointer<f32>#set|inlined.2
   (local.set $this|48
    (global.get $std/pointer/buf)
   )
   (local.set $index|49
    (i32.const 2)
   )
   (local.set $value|50
    (f32.const 1.2999999523162842)
   )
   (f32.store
    (i32.add
     (local.get $this|48)
     (i32.mul
      (local.get $index|49)
      (i32.const 4)
     )
    )
    (local.get $value|50)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (block $std/pointer/Pointer<f32>#get|inlined.4 (result f32)
      (local.set $this|51
       (global.get $std/pointer/buf)
      )
      (local.set $index|52
       (i32.const 2)
      )
      (br $std/pointer/Pointer<f32>#get|inlined.4
       (f32.load
        (i32.add
         (local.get $this|51)
         (i32.mul
          (local.get $index|52)
          (i32.const 4)
         )
        )
       )
      )
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
     (block $std/pointer/Pointer<f32>#get|inlined.5 (result f32)
      (local.set $this|53
       (global.get $std/pointer/buf)
      )
      (local.set $index|54
       (i32.const 2)
      )
      (br $std/pointer/Pointer<f32>#get|inlined.5
       (f32.load
        (i32.add
         (local.get $this|53)
         (i32.mul
          (local.get $index|54)
          (i32.const 4)
         )
        )
       )
      )
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
  (block $std/pointer/Pointer<f32>#set:value|inlined.0
   (local.set $this|55
    (global.get $std/pointer/buf)
   )
   (local.set $value|56
    (f32.const 1.399999976158142)
   )
   (drop
    (i32.const 0)
   )
   (f32.store
    (local.get $this|55)
    (local.get $value|56)
   )
  )
  (if
   (i32.eqz
    (f32.eq
     (block $std/pointer/Pointer<f32>#get:value|inlined.0 (result f32)
      (local.set $this|57
       (global.get $std/pointer/buf)
      )
      (drop
       (i32.const 0)
      )
      (br $std/pointer/Pointer<f32>#get:value|inlined.0
       (f32.load
        (local.get $this|57)
       )
      )
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
