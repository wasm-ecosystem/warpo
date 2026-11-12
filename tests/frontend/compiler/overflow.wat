(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func (param i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00o\00v\00e\00r\00f\00l\00o\00w\00.\00t\00s\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:overflow
  (local $val i32)
  (local $ctx i32)
  (local $2 i32)
  (local $3 i32)
  (local $val|4 i32)
  (local $ctx|5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $val|8 i32)
  (local $ctx|9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $val|12 i32)
  (local $ctx|13 i32)
  (local $14 i32)
  (local $15 i32)
  (local $b4 i32)
  (local $b5 i32)
  (local $b6 i32)
  (local $c i32)
  (block
   (local.set $val
    (i32.const 127)
   )
   (local.set $val
    (i32.add
     (local.get $val)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend8_s
       (local.get $val)
      )
      (i32.const -128)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 10)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val
    (i32.sub
     (local.get $val)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend8_s
       (local.get $val)
      )
      (i32.const 127)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 13)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx
    (block (result i32)
     (local.set $val
      (i32.add
       (local.tee $2
        (local.get $val)
       )
       (i32.const 1)
      )
     )
     (local.get $2)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend8_s
       (local.get $val)
      )
      (i32.const -128)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 16)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx
    (block (result i32)
     (local.set $val
      (i32.sub
       (local.tee $3
        (local.get $val)
       )
       (i32.const 1)
      )
     )
     (local.get $3)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend8_s
       (local.get $val)
      )
      (i32.const 127)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 19)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val
    (i32.add
     (local.get $val)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend8_s
       (local.get $val)
      )
      (i32.const -128)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 22)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val
    (i32.sub
     (local.get $val)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend8_s
       (local.get $val)
      )
      (i32.const 127)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 25)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx
    (local.tee $val
     (i32.add
      (local.get $val)
      (i32.const 1)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend8_s
       (local.get $val)
      )
      (i32.const -128)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 28)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx
    (local.tee $val
     (i32.sub
      (local.get $val)
      (i32.const 1)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend8_s
       (local.get $val)
      )
      (i32.const 127)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 31)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend8_s
       (i32.add
        (local.get $val)
        (i32.const 1)
       )
      )
      (i32.const -128)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 33)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $val|4
    (i32.const 32767)
   )
   (local.set $val|4
    (i32.add
     (local.get $val|4)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend16_s
       (local.get $val|4)
      )
      (i32.const -32768)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 42)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val|4
    (i32.sub
     (local.get $val|4)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend16_s
       (local.get $val|4)
      )
      (i32.const 32767)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 45)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|5
    (block (result i32)
     (local.set $val|4
      (i32.add
       (local.tee $6
        (local.get $val|4)
       )
       (i32.const 1)
      )
     )
     (local.get $6)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend16_s
       (local.get $val|4)
      )
      (i32.const -32768)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 48)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|5
    (block (result i32)
     (local.set $val|4
      (i32.sub
       (local.tee $7
        (local.get $val|4)
       )
       (i32.const 1)
      )
     )
     (local.get $7)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend16_s
       (local.get $val|4)
      )
      (i32.const 32767)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 51)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val|4
    (i32.add
     (local.get $val|4)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend16_s
       (local.get $val|4)
      )
      (i32.const -32768)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 54)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val|4
    (i32.sub
     (local.get $val|4)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend16_s
       (local.get $val|4)
      )
      (i32.const 32767)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 57)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|5
    (local.tee $val|4
     (i32.add
      (local.get $val|4)
      (i32.const 1)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend16_s
       (local.get $val|4)
      )
      (i32.const -32768)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 60)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|5
    (local.tee $val|4
     (i32.sub
      (local.get $val|4)
      (i32.const 1)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend16_s
       (local.get $val|4)
      )
      (i32.const 32767)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 63)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.extend16_s
       (i32.add
        (local.get $val|4)
        (i32.const 1)
       )
      )
      (i32.const -32768)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 65)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $val|8
    (i32.const 0)
   )
   (local.set $val|8
    (i32.sub
     (local.get $val|8)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|8)
       (i32.const 255)
      )
      (i32.const 255)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 74)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val|8
    (i32.add
     (local.get $val|8)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|8)
       (i32.const 255)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 77)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|9
    (block (result i32)
     (local.set $val|8
      (i32.sub
       (local.tee $10
        (local.get $val|8)
       )
       (i32.const 1)
      )
     )
     (local.get $10)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|8)
       (i32.const 255)
      )
      (i32.const 255)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 80)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|9
    (block (result i32)
     (local.set $val|8
      (i32.add
       (local.tee $11
        (local.get $val|8)
       )
       (i32.const 1)
      )
     )
     (local.get $11)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|8)
       (i32.const 255)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 83)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val|8
    (i32.sub
     (local.get $val|8)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|8)
       (i32.const 255)
      )
      (i32.const 255)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 86)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val|8
    (i32.add
     (local.get $val|8)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|8)
       (i32.const 255)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 89)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|9
    (local.tee $val|8
     (i32.sub
      (local.get $val|8)
      (i32.const 1)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|8)
       (i32.const 255)
      )
      (i32.const 255)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 92)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|9
    (local.tee $val|8
     (i32.add
      (local.get $val|8)
      (i32.const 1)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|8)
       (i32.const 255)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 95)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (i32.sub
        (local.get $val|8)
        (i32.const 1)
       )
       (i32.const 255)
      )
      (i32.const 255)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 97)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $val|12
    (i32.const 0)
   )
   (local.set $val|12
    (i32.sub
     (local.get $val|12)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|12)
       (i32.const 65535)
      )
      (i32.const 65535)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 106)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val|12
    (i32.add
     (local.get $val|12)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|12)
       (i32.const 65535)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 109)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|13
    (block (result i32)
     (local.set $val|12
      (i32.sub
       (local.tee $14
        (local.get $val|12)
       )
       (i32.const 1)
      )
     )
     (local.get $14)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|12)
       (i32.const 65535)
      )
      (i32.const 65535)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 112)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|13
    (block (result i32)
     (local.set $val|12
      (i32.add
       (local.tee $15
        (local.get $val|12)
       )
       (i32.const 1)
      )
     )
     (local.get $15)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|12)
       (i32.const 65535)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 115)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val|12
    (i32.sub
     (local.get $val|12)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|12)
       (i32.const 65535)
      )
      (i32.const 65535)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 118)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $val|12
    (i32.add
     (local.get $val|12)
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|12)
       (i32.const 65535)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 121)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|13
    (local.tee $val|12
     (i32.sub
      (local.get $val|12)
      (i32.const 1)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|12)
       (i32.const 65535)
      )
      (i32.const 65535)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 124)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $ctx|13
    (local.tee $val|12
     (i32.add
      (local.get $val|12)
      (i32.const 1)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (local.get $val|12)
       (i32.const 65535)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 127)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.and
       (i32.sub
        (local.get $val|12)
        (i32.const 1)
       )
       (i32.const 65535)
      )
      (i32.const 65535)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 129)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (drop
    (i32.eq
     (i32.const 1)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 1)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 0)
     (i32.const 0)
    )
   )
   (local.set $b4
    (i32.const 2)
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.ne
       (local.get $b4)
       (i32.const 0)
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 144)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $b5
    (i32.const -1)
   )
   (if
    (i32.eqz
     (i32.eq
      (i32.ne
       (local.get $b5)
       (i32.const 0)
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 147)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $b6
    (i32.const 0)
   )
   (if
    (i32.eqz
     (i32.eq
      (local.get $b6)
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 150)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $c
    (i32.add
     (i32.const 65)
     (i32.and
      (i32.sub
       (i32.shr_u
        (i32.and
         (i32.const 63457)
         (i32.const 504)
        )
        (i32.and
         (i32.const 3)
         (i32.const 15)
        )
       )
       (i32.const 64)
      )
      (i32.const 65535)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (local.get $c)
      (i32.const 65597)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 159)
      (i32.const 3)
     )
     (unreachable)
    )
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
  (call $start:overflow)
 )
)
