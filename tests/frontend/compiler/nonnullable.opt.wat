(module
 (type $0 (func))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func (result i32)))
 (type $4 (func (param i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33132))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02\00\00\00\06\00\00\00u\003\002")
 (data $1 (i32.const 44) ",")
 (data $1.1 (i32.const 56) "\02\00\00\00\1c\00\00\00n\00o\00n\00n\00u\00l\00l\00a\00b\00l\00e\00.\00t\00s")
 (data $2 (i32.const 92) "\1c")
 (data $2.1 (i32.const 104) "\02\00\00\00\0c\00\00\00S\00t\00r\00i\00n\00g")
 (data $3 (i32.const 124) "L")
 (data $3.1 (i32.const 136) "\02\00\00\002\00\00\00A\00r\00r\00a\00y\00<\00~\00l\00i\00b\00/\00s\00t\00r\00i\00n\00g\00/\00S\00t\00r\00i\00n\00g\00>")
 (data $4 (i32.const 204) "\1c")
 (data $4.1 (i32.const 216) "\02\00\00\00\02\00\00\00z")
 (data $5 (i32.const 236) "|")
 (data $5.1 (i32.const 248) "\02\00\00\00^\00\00\00U\00n\00e\00x\00p\00e\00c\00t\00e\00d\00 \00\'\00n\00u\00l\00l\00\'\00 \00(\00n\00o\00t\00 \00a\00s\00s\00i\00g\00n\00e\00d\00 \00o\00r\00 \00f\00a\00i\00l\00e\00d\00 \00c\00a\00s\00t\00)")
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/string/String.__eq (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  local.get $0
  local.get $1
  i32.eq
  if
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   i32.const 1
   return
  end
  block $folding-inner0
   local.get $1
   i32.eqz
   local.get $0
   i32.eqz
   i32.or
   if
    br $folding-inner0
   end
   global.get $~lib/memory/__stack_pointer
   local.tee $2
   local.get $0
   i32.store align=1
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 1
   i32.shr_u
   local.set $4
   local.get $2
   local.get $1
   i32.store align=1
   local.get $4
   local.get $1
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 1
   i32.shr_u
   i32.ne
   if
    br $folding-inner0
   end
   block $__inlined_func$~lib/util/string/compareImpl$1 (result i32)
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store align=1
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    local.get $1
    i32.store align=1
    local.get $0
    local.tee $2
    i32.const 7
    i32.and
    local.get $1
    local.tee $3
    i32.const 7
    i32.and
    i32.or
    i32.eqz
    local.get $4
    local.tee $0
    i32.const 4
    i32.ge_u
    i32.and
    if
     loop $do-loop|0
      local.get $2
      i64.load
      local.get $3
      i64.load
      i64.eq
      if
       local.get $2
       i32.const 8
       i32.add
       local.set $2
       local.get $3
       i32.const 8
       i32.add
       local.set $3
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
     local.tee $1
     i32.const 1
     i32.sub
     local.set $0
     local.get $1
     if
      local.get $2
      i32.load16_u
      local.tee $1
      local.get $3
      i32.load16_u
      local.tee $4
      i32.ne
      if
       local.get $1
       local.get $4
       i32.sub
       br $__inlined_func$~lib/util/string/compareImpl$1
      end
      local.get $2
      i32.const 2
      i32.add
      local.set $2
      local.get $3
      i32.const 2
      i32.add
      local.set $3
      br $while-continue|1
     end
    end
    i32.const 0
   end
   i32.eqz
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   return
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  i32.const 0
 )
 (func $~lib/string/String.__ne (result i32)
  (local $0 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  i32.const 224
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  i32.const 0
  i32.store align=1
  i32.const 224
  i32.const 0
  call $~lib/string/String.__eq
  i32.eqz
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $nonnullable/assertNonNull<~lib/string/String>
  i32.const 4
  call $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  i32.const 224
  i32.store align=1
  call $~lib/string/String.__ne
  i32.eqz
  if
   i32.const 0
   i32.const 64
   i32.const 9
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~start
  i32.const 8
  call $~lib/rt/__decrease_sp
  i32.const 32
  i32.const 32
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 64
   i32.const 3
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 112
  i32.const 112
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 64
   i32.const 4
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 144
  i32.const 144
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 64
   i32.const 5
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  i32.const 224
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 224
  i32.store align=1
  call $nonnullable/assertNonNull<~lib/string/String>
  global.get $~lib/memory/__stack_pointer
  i32.const 224
  i32.store align=1
  i32.const 4
  call $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  i32.const 224
  i32.store align=1
  call $~lib/string/String.__ne
  if
   global.get $~lib/memory/__stack_pointer
   i32.const 224
   i32.store align=1
   call $nonnullable/assertNonNull<~lib/string/String>
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $~lib/rt/__decrease_sp (param $0 i32)
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  local.get $0
  memory.fill
  global.get $~lib/memory/__stack_pointer
  i32.const 364
  i32.lt_s
  if
   unreachable
  end
 )
)
