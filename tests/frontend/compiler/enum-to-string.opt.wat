(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02\00\00\00\04\00\00\00E\002")
 (data $1 (i32.const 44) "\1c")
 (data $1.1 (i32.const 56) "\02\00\00\00\04\00\00\00E\001")
 (data $2 (i32.const 76) "\1c")
 (data $2.1 (i32.const 88) "\02\00\00\00\04\00\00\00E\000")
 (data $3 (i32.const 108) "<")
 (data $3.1 (i32.const 120) "\02\00\00\00\"\00\00\00e\00n\00u\00m\00-\00t\00o\00-\00s\00t\00r\00i\00n\00g\00.\00t\00s")
 (data $4 (i32.const 172) "\1c")
 (data $4.1 (i32.const 184) "\02\00\00\00\06\00\00\00C\00E\002")
 (data $5 (i32.const 204) "\1c")
 (data $5.1 (i32.const 216) "\02\00\00\00\06\00\00\00C\00E\001")
 (data $6 (i32.const 236) "\1c")
 (data $6.1 (i32.const 248) "\02\00\00\00\06\00\00\00C\00E\000")
 (export "memory" (memory $0))
 (start $~start)
 (func $enum-to-string/Enum#__enum_to_string (param $0 i32) (result i32)
  local.get $0
  i32.const 2
  i32.eq
  if
   i32.const 32
   return
  end
  local.get $0
  i32.const 1
  i32.eq
  if
   i32.const 64
   return
  end
  local.get $0
  i32.eqz
  if
   i32.const 96
   return
  end
  unreachable
 )
 (func $~lib/string/String.__eq (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  local.get $1
  i32.eq
  if
   i32.const 1
   return
  end
  local.get $1
  i32.eqz
  local.get $0
  i32.eqz
  i32.or
  if
   i32.const 0
   return
  end
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  local.tee $3
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.ne
  if
   i32.const 0
   return
  end
  block $__inlined_func$~lib/util/string/compareImpl$1 (result i32)
   local.get $0
   local.tee $2
   i32.const 7
   i32.and
   local.get $1
   i32.const 7
   i32.and
   i32.or
   i32.eqz
   local.get $3
   local.tee $0
   i32.const 4
   i32.ge_u
   i32.and
   if
    loop $do-loop|0
     local.get $2
     i64.load
     local.get $1
     i64.load
     i64.eq
     if
      local.get $2
      i32.const 8
      i32.add
      local.set $2
      local.get $1
      i32.const 8
      i32.add
      local.set $1
      local.get $0
      i32.const 4
      i32.sub
      local.tee $0
      i32.const 4
      i32.ge_u
      br_if $do-loop|0
     end
    end
   end
   loop $while-continue|1
    local.get $0
    local.tee $3
    i32.const 1
    i32.sub
    local.set $0
    local.get $3
    if
     local.get $2
     i32.load16_u
     local.tee $3
     local.get $1
     i32.load16_u
     local.tee $4
     i32.ne
     if
      local.get $3
      local.get $4
      i32.sub
      br $__inlined_func$~lib/util/string/compareImpl$1
     end
     local.get $2
     i32.const 2
     i32.add
     local.set $2
     local.get $1
     i32.const 2
     i32.add
     local.set $1
     br $while-continue|1
    end
   end
   i32.const 0
  end
  i32.eqz
 )
 (func $enum-to-string/InlineEnum#__enum_to_string (param $0 i32) (result i32)
  local.get $0
  i32.const 2
  i32.eq
  if
   i32.const 192
   return
  end
  local.get $0
  i32.const 1
  i32.eq
  if
   i32.const 224
   return
  end
  local.get $0
  i32.eqz
  if
   i32.const 256
   return
  end
  unreachable
 )
 (func $enum-to-string/EnumWithInit#__enum_to_string (param $0 i32) (result i32)
  block $__inlined_func$byn$mgfn-shared$enum-to-string/EnumWithInit#__enum_to_string$2 (result i32)
   i32.const 32
   local.get $0
   i32.const 4
   i32.eq
   br_if $__inlined_func$byn$mgfn-shared$enum-to-string/EnumWithInit#__enum_to_string$2
   drop
   i32.const 64
   local.get $0
   i32.const 2
   i32.eq
   br_if $__inlined_func$byn$mgfn-shared$enum-to-string/EnumWithInit#__enum_to_string$2
   drop
   i32.const 96
   local.get $0
   i32.const 1
   i32.eq
   br_if $__inlined_func$byn$mgfn-shared$enum-to-string/EnumWithInit#__enum_to_string$2
   drop
   unreachable
  end
 )
 (func $enum-to-string/EnumWithDup#__enum_to_string (param $0 i32) (result i32)
  (local $1 i32)
  block $__inlined_func$byn$mgfn-shared$enum-to-string/EnumWithInit#__enum_to_string$3 (result i32)
   i32.const 32
   local.get $0
   i32.const 1
   i32.eq
   local.tee $1
   br_if $__inlined_func$byn$mgfn-shared$enum-to-string/EnumWithInit#__enum_to_string$3
   drop
   i32.const 64
   local.get $0
   i32.const 2
   i32.eq
   br_if $__inlined_func$byn$mgfn-shared$enum-to-string/EnumWithInit#__enum_to_string$3
   drop
   i32.const 96
   local.get $1
   br_if $__inlined_func$byn$mgfn-shared$enum-to-string/EnumWithInit#__enum_to_string$3
   drop
   unreachable
  end
 )
 (func $~start
  i32.const 0
  call $enum-to-string/Enum#__enum_to_string
  i32.const 96
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 7
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  call $enum-to-string/Enum#__enum_to_string
  i32.const 64
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 8
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  call $enum-to-string/Enum#__enum_to_string
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 9
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  call $enum-to-string/Enum#__enum_to_string
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 12
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  call $enum-to-string/InlineEnum#__enum_to_string
  i32.const 256
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 22
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  call $enum-to-string/InlineEnum#__enum_to_string
  i32.const 224
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 23
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  call $enum-to-string/InlineEnum#__enum_to_string
  i32.const 192
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 24
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  call $enum-to-string/EnumWithInit#__enum_to_string
  i32.const 96
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 32
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  call $enum-to-string/EnumWithInit#__enum_to_string
  i32.const 64
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 33
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  call $enum-to-string/EnumWithInit#__enum_to_string
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 34
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  call $enum-to-string/EnumWithDup#__enum_to_string
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 42
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  call $enum-to-string/EnumWithDup#__enum_to_string
  i32.const 64
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 43
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  call $enum-to-string/EnumWithDup#__enum_to_string
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 128
   i32.const 44
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
