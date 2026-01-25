(module
 (type $0 (func))
 (type $1 (func (param i32)))
 (type $2 (func (param i32 i32)))
 (type $3 (func (param i32 i32 f64 f64 f64 f64 f64)))
 (type $4 (func (param i32 i32 i32 i32)))
 (type $5 (func (result i32)))
 (type $6 (func (param i32 i32) (result i32)))
 (type $7 (func (param i32) (result i32)))
 (import "env" "trace" (func $~lib/builtins/trace (param i32 i32 f64 f64 f64 f64 f64)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/rt/itcms/visitCount (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/total (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/threshold (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/state (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/pinSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/iter (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/toSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/white (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/fromSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $~lib/rt/__rtti_base i32 (i32.const 1616))
 (memory $0 1)
 (data $0 (i32.const 1036) ",")
 (data $0.1 (i32.const 1048) "\02\00\00\00\1c\00\00\00a\00s\00c\00o\00n\00f\00i\00g\00 \00r\00e\00a\00d\00y")
 (data $1 (i32.const 1084) "<")
 (data $1.1 (i32.const 1096) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $2 (i32.const 1148) "<")
 (data $2.1 (i32.const 1160) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $5 (i32.const 1276) "<")
 (data $5.1 (i32.const 1288) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $6 (i32.const 1340) ",")
 (data $6.1 (i32.const 1352) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $8 (i32.const 1420) "<")
 (data $8.1 (i32.const 1432) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $9 (i32.const 1484) "<")
 (data $9.1 (i32.const 1496) "\02\00\00\00*\00\00\00O\00b\00j\00e\00c\00t\00 \00a\00l\00r\00e\00a\00d\00y\00 \00p\00i\00n\00n\00e\00d")
 (data $10 (i32.const 1548) "<")
 (data $10.1 (i32.const 1560) "\02\00\00\00(\00\00\00O\00b\00j\00e\00c\00t\00 \00i\00s\00 \00n\00o\00t\00 \00p\00i\00n\00n\00e\00d")
 (data $11 (i32.const 1616) "\04\00\00\00 \00\00\00 \00\00\00 ")
 (table $0 1 funcref)
 (export "_start" (func $assembly/index/_start))
 (export "__new" (func $~lib/rt/itcms/__new))
 (export "__pin" (func $~lib/rt/itcms/__pin))
 (export "__unpin" (func $~lib/rt/itcms/__unpin))
 (export "__collect" (func $~lib/rt/itcms/__collect))
 (export "__rtti_base" (global $~lib/rt/__rtti_base))
 (export "memory" (memory $0))
 (export "table" (table $0))
 (start $~start)
 (func $assembly/index/_start
  i32.const 1056
  i32.const 0
  f64.const 0
  f64.const 0
  f64.const 0
  f64.const 0
  f64.const 0
  call $~lib/builtins/trace
 )
 (func $~lib/rt/itcms/Object#makeGray (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  global.get $~lib/rt/itcms/iter
  i32.eq
  if
   local.get $0
   i32.load offset=8
   local.tee $1
   if (result i32)
    local.get $1
   else
    i32.const 0
    i32.const 1168
    i32.const 147
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   end
   global.set $~lib/rt/itcms/iter
  end
  block $__inlined_func$~lib/rt/itcms/Object#unlink$1
   local.get $0
   i32.load offset=4
   i32.const -4
   i32.and
   local.tee $2
   i32.eqz
   if
    local.get $0
    i32.load offset=8
    i32.eqz
    local.get $0
    i32.const 34404
    i32.lt_u
    i32.and
    i32.eqz
    if
     i32.const 0
     i32.const 1168
     i32.const 127
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    br $__inlined_func$~lib/rt/itcms/Object#unlink$1
   end
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 1168
    i32.const 131
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $2
   local.get $1
   i32.store offset=8
   local.get $1
   local.get $2
   local.get $1
   i32.load offset=4
   i32.const 3
   i32.and
   i32.or
   i32.store offset=4
  end
  global.get $~lib/rt/itcms/toSpace
  local.set $1
  local.get $0
  i32.load offset=12
  local.tee $2
  i32.const 2
  i32.le_u
  if (result i32)
   i32.const 1
  else
   local.get $2
   i32.const 1616
   i32.load
   i32.gt_u
   if
    i32.const 1296
    i32.const 1360
    i32.const 22
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $2
   i32.const 2
   i32.shl
   i32.const 1620
   i32.add
   i32.load
   i32.const 32
   i32.and
  end
  if (result i32)
   global.get $~lib/rt/itcms/white
   i32.eqz
  else
   i32.const 2
  end
  local.set $3
  local.get $1
  i32.load offset=8
  local.set $2
  local.get $0
  local.get $1
  local.get $3
  i32.or
  i32.store offset=4
  local.get $0
  local.get $2
  i32.store offset=8
  local.get $2
  local.get $0
  local.get $2
  i32.load offset=4
  i32.const 3
  i32.and
  i32.or
  i32.store offset=4
  local.get $1
  local.get $0
  i32.store offset=8
 )
 (func $~lib/rt/tlsf/removeBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $1
  i32.load
  local.tee $2
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1440
   i32.const 245
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const -4
  i32.and
  local.tee $2
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 1440
   i32.const 247
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $2
   i32.const 4
   i32.shr_u
   local.set $3
   i32.const 0
  else
   i32.const 31
   i32.const 1073741820
   local.get $2
   local.get $2
   i32.const 1073741820
   i32.ge_u
   select
   local.tee $3
   i32.clz
   i32.sub
   local.set $2
   local.get $3
   local.get $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $3
   local.get $2
   i32.const 7
   i32.sub
  end
  local.set $4
  local.get $3
  i32.const 16
  i32.lt_u
  local.get $4
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1440
   i32.const 261
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load offset=8
  local.set $2
  local.get $1
  i32.load offset=4
  local.tee $5
  if
   local.get $5
   local.get $2
   i32.store offset=8
  end
  local.get $2
  if
   local.get $2
   local.get $5
   i32.store offset=4
  end
  local.get $1
  local.get $0
  local.get $4
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.tee $5
  i32.load offset=96
  i32.eq
  if
   local.get $5
   local.get $2
   i32.store offset=96
   local.get $2
   i32.eqz
   if
    local.get $0
    local.get $4
    i32.const 2
    i32.shl
    i32.add
    local.tee $1
    local.get $1
    i32.load offset=4
    i32.const -2
    local.get $3
    i32.rotl
    i32.and
    local.tee $1
    i32.store offset=4
    local.get $1
    i32.eqz
    if
     local.get $0
     local.get $0
     i32.load
     i32.const -2
     local.get $4
     i32.rotl
     i32.and
     i32.store
    end
   end
  end
 )
 (func $~lib/rt/tlsf/insertBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $1
  i32.eqz
  if
   i32.const 0
   i32.const 1440
   i32.const 178
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load
  local.tee $2
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1440
   i32.const 180
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 4
  i32.add
  local.tee $5
  local.get $1
  i32.load
  i32.const -4
  i32.and
  i32.add
  local.tee $3
  i32.load
  local.tee $4
  i32.const 1
  i32.and
  if
   local.get $0
   local.get $3
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $2
   i32.const 4
   i32.add
   local.get $4
   i32.const -4
   i32.and
   i32.add
   local.tee $2
   i32.store
   local.get $1
   i32.load
   i32.const -4
   i32.and
   local.get $5
   i32.add
   local.tee $3
   i32.load
   local.set $4
  end
  local.get $2
  i32.const 2
  i32.and
  if
   local.get $1
   i32.const 4
   i32.sub
   i32.load
   local.tee $1
   i32.load
   local.tee $5
   i32.const 1
   i32.and
   i32.eqz
   if
    i32.const 0
    i32.const 1440
    i32.const 198
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   local.get $1
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $5
   i32.const 4
   i32.add
   local.get $2
   i32.const -4
   i32.and
   i32.add
   local.tee $2
   i32.store
  end
  local.get $3
  local.get $4
  i32.const 2
  i32.or
  i32.store
  local.get $2
  i32.const -4
  i32.and
  local.tee $2
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 1440
   i32.const 210
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  local.get $1
  i32.const 4
  i32.add
  local.get $2
  i32.add
  i32.ne
  if
   i32.const 0
   i32.const 1440
   i32.const 211
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  i32.const 4
  i32.sub
  local.get $1
  i32.store
  local.get $2
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $2
   i32.const 4
   i32.shr_u
   local.set $3
   i32.const 0
  else
   i32.const 31
   i32.const 1073741820
   local.get $2
   local.get $2
   i32.const 1073741820
   i32.ge_u
   select
   local.tee $3
   i32.clz
   i32.sub
   local.set $2
   local.get $3
   local.get $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $3
   local.get $2
   i32.const 7
   i32.sub
  end
  local.set $2
  local.get $3
  i32.const 16
  i32.lt_u
  local.get $2
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1440
   i32.const 228
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $2
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=96
  local.set $4
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
  local.get $4
  i32.store offset=8
  local.get $4
  if
   local.get $4
   local.get $1
   i32.store offset=4
  end
  local.get $0
  local.get $2
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.get $1
  i32.store offset=96
  local.get $0
  local.get $0
  i32.load
  i32.const 1
  local.get $2
  i32.shl
  i32.or
  i32.store
  local.get $0
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  local.tee $0
  local.get $0
  i32.load offset=4
  i32.const 1
  local.get $3
  i32.shl
  i32.or
  i32.store offset=4
 )
 (func $~lib/rt/itcms/step (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  block $folding-inner0
   block $break|0
    block $case2|0
     block $case1|0
      block $case0|0
       global.get $~lib/rt/itcms/state
       br_table $case0|0 $case1|0 $case2|0 $break|0
      end
      i32.const 1
      global.set $~lib/rt/itcms/state
      i32.const 0
      global.set $~lib/rt/itcms/visitCount
      global.get $~lib/rt/itcms/pinSpace
      local.tee $1
      i32.load offset=4
      i32.const -4
      i32.and
      local.set $0
      loop $while-continue|0
       local.get $0
       local.get $1
       i32.ne
       if
        local.get $0
        i32.load offset=4
        i32.const 3
        i32.and
        i32.const 3
        i32.ne
        if
         br $folding-inner0
        end
        block $__inlined_func$~lib/rt/__visit_members
         block $invalid
          block $~lib/arraybuffer/ArrayBufferView
           local.get $0
           i32.const 20
           i32.add
           local.tee $2
           i32.const 8
           i32.sub
           i32.load
           br_table $__inlined_func$~lib/rt/__visit_members $__inlined_func$~lib/rt/__visit_members $__inlined_func$~lib/rt/__visit_members $~lib/arraybuffer/ArrayBufferView $invalid
          end
          local.get $2
          i32.load
          local.tee $2
          if
           global.get $~lib/rt/itcms/white
           local.get $2
           i32.const 20
           i32.sub
           local.tee $2
           i32.load offset=4
           i32.const 3
           i32.and
           i32.eq
           if
            local.get $2
            call $~lib/rt/itcms/Object#makeGray
            global.get $~lib/rt/itcms/visitCount
            i32.const 1
            i32.add
            global.set $~lib/rt/itcms/visitCount
           end
          end
          br $__inlined_func$~lib/rt/__visit_members
         end
         unreachable
        end
        local.get $0
        i32.load offset=4
        i32.const -4
        i32.and
        local.set $0
        br $while-continue|0
       end
      end
      global.get $~lib/rt/itcms/toSpace
      global.set $~lib/rt/itcms/iter
      global.get $~lib/rt/itcms/visitCount
      return
     end
     global.get $~lib/rt/itcms/white
     i32.eqz
     local.set $1
     global.get $~lib/rt/itcms/iter
     i32.load offset=4
     i32.const -4
     i32.and
     local.set $0
     loop $while-continue|1
      local.get $0
      global.get $~lib/rt/itcms/toSpace
      i32.ne
      if
       local.get $0
       global.set $~lib/rt/itcms/iter
       local.get $1
       local.get $0
       i32.load offset=4
       local.tee $2
       i32.const 3
       i32.and
       i32.ne
       if
        local.get $0
        local.get $2
        i32.const -4
        i32.and
        local.get $1
        i32.or
        i32.store offset=4
        i32.const 0
        global.set $~lib/rt/itcms/visitCount
        block $__inlined_func$~lib/rt/__visit_members$4
         block $invalid0
          block $~lib/arraybuffer/ArrayBufferView1
           local.get $0
           i32.const 20
           i32.add
           local.tee $0
           i32.const 8
           i32.sub
           i32.load
           br_table $__inlined_func$~lib/rt/__visit_members$4 $__inlined_func$~lib/rt/__visit_members$4 $__inlined_func$~lib/rt/__visit_members$4 $~lib/arraybuffer/ArrayBufferView1 $invalid0
          end
          local.get $0
          i32.load
          local.tee $0
          if
           global.get $~lib/rt/itcms/white
           local.get $0
           i32.const 20
           i32.sub
           local.tee $0
           i32.load offset=4
           i32.const 3
           i32.and
           i32.eq
           if
            local.get $0
            call $~lib/rt/itcms/Object#makeGray
            global.get $~lib/rt/itcms/visitCount
            i32.const 1
            i32.add
            global.set $~lib/rt/itcms/visitCount
           end
          end
          br $__inlined_func$~lib/rt/__visit_members$4
         end
         unreachable
        end
        global.get $~lib/rt/itcms/visitCount
        return
       end
       local.get $0
       i32.load offset=4
       i32.const -4
       i32.and
       local.set $0
       br $while-continue|1
      end
     end
     i32.const 0
     global.set $~lib/rt/itcms/visitCount
     global.get $~lib/rt/itcms/pinSpace
     local.tee $2
     i32.load offset=4
     i32.const -4
     i32.and
     local.set $0
     loop $while-continue|05
      local.get $0
      local.get $2
      i32.ne
      if
       local.get $0
       i32.load offset=4
       i32.const 3
       i32.and
       i32.const 3
       i32.ne
       if
        br $folding-inner0
       end
       block $__inlined_func$~lib/rt/__visit_members6
        block $invalid7
         block $~lib/arraybuffer/ArrayBufferView8
          local.get $0
          i32.const 20
          i32.add
          local.tee $3
          i32.const 8
          i32.sub
          i32.load
          br_table $__inlined_func$~lib/rt/__visit_members6 $__inlined_func$~lib/rt/__visit_members6 $__inlined_func$~lib/rt/__visit_members6 $~lib/arraybuffer/ArrayBufferView8 $invalid7
         end
         local.get $3
         i32.load
         local.tee $3
         if
          global.get $~lib/rt/itcms/white
          local.get $3
          i32.const 20
          i32.sub
          local.tee $3
          i32.load offset=4
          i32.const 3
          i32.and
          i32.eq
          if
           local.get $3
           call $~lib/rt/itcms/Object#makeGray
           global.get $~lib/rt/itcms/visitCount
           i32.const 1
           i32.add
           global.set $~lib/rt/itcms/visitCount
          end
         end
         br $__inlined_func$~lib/rt/__visit_members6
        end
        unreachable
       end
       local.get $0
       i32.load offset=4
       i32.const -4
       i32.and
       local.set $0
       br $while-continue|05
      end
     end
     global.get $~lib/rt/itcms/toSpace
     global.get $~lib/rt/itcms/iter
     i32.load offset=4
     i32.const -4
     i32.and
     i32.eq
     if
      i32.const 34404
      local.set $0
      loop $while-continue|013
       local.get $0
       i32.const 34404
       i32.lt_u
       if
        local.get $0
        i32.load
        local.tee $2
        if
         global.get $~lib/rt/itcms/white
         local.get $2
         i32.const 20
         i32.sub
         local.tee $2
         i32.load offset=4
         i32.const 3
         i32.and
         i32.eq
         if
          local.get $2
          call $~lib/rt/itcms/Object#makeGray
          global.get $~lib/rt/itcms/visitCount
          i32.const 1
          i32.add
          global.set $~lib/rt/itcms/visitCount
         end
        end
        local.get $0
        i32.const 4
        i32.add
        local.set $0
        br $while-continue|013
       end
      end
      global.get $~lib/rt/itcms/iter
      i32.load offset=4
      i32.const -4
      i32.and
      local.set $0
      loop $while-continue|2
       local.get $0
       global.get $~lib/rt/itcms/toSpace
       i32.ne
       if
        local.get $1
        local.get $0
        i32.load offset=4
        local.tee $2
        i32.const 3
        i32.and
        i32.ne
        if
         local.get $0
         local.get $2
         i32.const -4
         i32.and
         local.get $1
         i32.or
         i32.store offset=4
         block $__inlined_func$~lib/rt/__visit_members$6
          block $invalid014
           block $~lib/arraybuffer/ArrayBufferView115
            local.get $0
            i32.const 20
            i32.add
            local.tee $2
            i32.const 8
            i32.sub
            i32.load
            br_table $__inlined_func$~lib/rt/__visit_members$6 $__inlined_func$~lib/rt/__visit_members$6 $__inlined_func$~lib/rt/__visit_members$6 $~lib/arraybuffer/ArrayBufferView115 $invalid014
           end
           local.get $2
           i32.load
           local.tee $2
           if
            global.get $~lib/rt/itcms/white
            local.get $2
            i32.const 20
            i32.sub
            local.tee $2
            i32.load offset=4
            i32.const 3
            i32.and
            i32.eq
            if
             local.get $2
             call $~lib/rt/itcms/Object#makeGray
             global.get $~lib/rt/itcms/visitCount
             i32.const 1
             i32.add
             global.set $~lib/rt/itcms/visitCount
            end
           end
           br $__inlined_func$~lib/rt/__visit_members$6
          end
          unreachable
         end
        end
        local.get $0
        i32.load offset=4
        i32.const -4
        i32.and
        local.set $0
        br $while-continue|2
       end
      end
      global.get $~lib/rt/itcms/fromSpace
      local.set $0
      global.get $~lib/rt/itcms/toSpace
      global.set $~lib/rt/itcms/fromSpace
      local.get $0
      global.set $~lib/rt/itcms/toSpace
      local.get $1
      global.set $~lib/rt/itcms/white
      local.get $0
      i32.load offset=4
      i32.const -4
      i32.and
      global.set $~lib/rt/itcms/iter
      i32.const 2
      global.set $~lib/rt/itcms/state
     end
     global.get $~lib/rt/itcms/visitCount
     return
    end
    global.get $~lib/rt/itcms/iter
    local.tee $0
    global.get $~lib/rt/itcms/toSpace
    i32.ne
    if
     local.get $0
     i32.load offset=4
     local.tee $1
     i32.const -4
     i32.and
     global.set $~lib/rt/itcms/iter
     global.get $~lib/rt/itcms/white
     i32.eqz
     local.get $1
     i32.const 3
     i32.and
     i32.ne
     if
      i32.const 0
      i32.const 1168
      i32.const 229
      i32.const 20
      call $~lib/builtins/abort
      unreachable
     end
     local.get $0
     i32.const 34404
     i32.lt_u
     if
      local.get $0
      i32.const 0
      i32.store offset=4
      local.get $0
      i32.const 0
      i32.store offset=8
     else
      global.get $~lib/rt/itcms/total
      local.get $0
      i32.load
      i32.const -4
      i32.and
      i32.const 4
      i32.add
      i32.sub
      global.set $~lib/rt/itcms/total
      local.get $0
      i32.const 4
      i32.add
      local.tee $2
      i32.const 34404
      i32.ge_u
      if
       global.get $~lib/rt/tlsf/ROOT
       i32.eqz
       if
        memory.size
        local.tee $0
        i32.const 0
        i32.le_s
        if (result i32)
         i32.const 1
         local.get $0
         i32.sub
         memory.grow
         i32.const 0
         i32.lt_s
        else
         i32.const 0
        end
        if
         unreachable
        end
        i32.const 34416
        i32.const 0
        i32.store
        i32.const 35984
        i32.const 0
        i32.store
        i32.const 0
        local.set $0
        loop $for-loop|0
         local.get $0
         i32.const 23
         i32.lt_u
         if
          local.get $0
          i32.const 2
          i32.shl
          i32.const 34416
          i32.add
          i32.const 0
          i32.store offset=4
          i32.const 0
          local.set $1
          loop $for-loop|1
           local.get $1
           i32.const 16
           i32.lt_u
           if
            local.get $0
            i32.const 4
            i32.shl
            local.get $1
            i32.add
            i32.const 2
            i32.shl
            i32.const 34416
            i32.add
            i32.const 0
            i32.store offset=96
            local.get $1
            i32.const 1
            i32.add
            local.set $1
            br $for-loop|1
           end
          end
          local.get $0
          i32.const 1
          i32.add
          local.set $0
          br $for-loop|0
         end
        end
        memory.size
        i64.extend_i32_s
        i64.const 16
        i64.shl
        local.tee $4
        i64.const 35988
        i64.lt_u
        if
         i32.const 0
         i32.const 1440
         i32.const 357
         i32.const 14
         call $~lib/builtins/abort
         unreachable
        end
        i32.const 35996
        local.set $0
        i32.const 35984
        i32.load
        local.tee $1
        if
         local.get $1
         i32.const 4
         i32.add
         i32.const 35996
         i32.gt_u
         if
          i32.const 0
          i32.const 1440
          i32.const 365
          i32.const 16
          call $~lib/builtins/abort
          unreachable
         end
         local.get $1
         i32.const 35980
         i32.eq
         if (result i32)
          local.get $1
          i32.load
          local.set $3
          i32.const 35980
         else
          i32.const 35996
         end
         local.set $0
        end
        local.get $4
        i32.wrap_i64
        i32.const -16
        i32.and
        local.get $0
        i32.sub
        local.tee $1
        i32.const 20
        i32.ge_u
        if
         local.get $0
         local.get $3
         i32.const 2
         i32.and
         local.get $1
         i32.const 8
         i32.sub
         local.tee $1
         i32.const 1
         i32.or
         i32.or
         i32.store
         local.get $0
         i32.const 0
         i32.store offset=4
         local.get $0
         i32.const 0
         i32.store offset=8
         local.get $0
         i32.const 4
         i32.add
         local.get $1
         i32.add
         local.tee $1
         i32.const 2
         i32.store
         i32.const 35984
         local.get $1
         i32.store
         i32.const 34416
         local.get $0
         call $~lib/rt/tlsf/insertBlock
        end
        i32.const 34416
        global.set $~lib/rt/tlsf/ROOT
       end
       global.get $~lib/rt/tlsf/ROOT
       local.set $1
       local.get $2
       i32.const 4
       i32.sub
       local.set $0
       local.get $2
       i32.const 15
       i32.and
       i32.const 1
       local.get $2
       select
       if (result i32)
        i32.const 1
       else
        local.get $0
        i32.load
        i32.const 1
        i32.and
       end
       if
        i32.const 0
        i32.const 1440
        i32.const 532
        i32.const 3
        call $~lib/builtins/abort
        unreachable
       end
       local.get $0
       local.get $0
       i32.load
       i32.const 1
       i32.or
       i32.store
       local.get $1
       local.get $0
       call $~lib/rt/tlsf/insertBlock
      end
     end
     i32.const 10
     return
    end
    global.get $~lib/rt/itcms/toSpace
    global.get $~lib/rt/itcms/toSpace
    i32.store offset=4
    global.get $~lib/rt/itcms/toSpace
    global.get $~lib/rt/itcms/toSpace
    i32.store offset=8
    i32.const 0
    global.set $~lib/rt/itcms/state
   end
   i32.const 0
   return
  end
  i32.const 0
  i32.const 1168
  i32.const 159
  i32.const 16
  call $~lib/builtins/abort
  unreachable
 )
 (func $~lib/rt/itcms/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i64)
  (local $8 i32)
  local.get $0
  i32.const 1073741804
  i32.ge_u
  if
   i32.const 1104
   i32.const 1168
   i32.const 262
   i32.const 31
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/itcms/total
  global.get $~lib/rt/itcms/threshold
  i32.ge_u
  if
   block $__inlined_func$~lib/rt/itcms/interrupt$69
    i32.const 2048
    local.set $2
    loop $do-loop|0
     local.get $2
     call $~lib/rt/itcms/step
     i32.sub
     local.set $2
     global.get $~lib/rt/itcms/state
     i32.eqz
     if
      global.get $~lib/rt/itcms/total
      i64.extend_i32_u
      i64.const 200
      i64.mul
      i64.const 100
      i64.div_u
      i32.wrap_i64
      i32.const 1024
      i32.add
      global.set $~lib/rt/itcms/threshold
      br $__inlined_func$~lib/rt/itcms/interrupt$69
     end
     local.get $2
     i32.const 0
     i32.gt_s
     br_if $do-loop|0
    end
    global.get $~lib/rt/itcms/total
    global.get $~lib/rt/itcms/total
    global.get $~lib/rt/itcms/threshold
    i32.sub
    i32.const 1024
    i32.lt_u
    i32.const 10
    i32.shl
    i32.add
    global.set $~lib/rt/itcms/threshold
   end
  end
  block $folding-inner3
   block $folding-inner2
    block $folding-inner1
     block $folding-inner0
      global.get $~lib/rt/tlsf/ROOT
      i32.eqz
      if
       memory.size
       local.tee $3
       i32.const 0
       i32.le_s
       if (result i32)
        i32.const 1
        local.get $3
        i32.sub
        memory.grow
        i32.const 0
        i32.lt_s
       else
        i32.const 0
       end
       if
        unreachable
       end
       i32.const 34416
       i32.const 0
       i32.store
       i32.const 35984
       i32.const 0
       i32.store
       i32.const 0
       local.set $3
       loop $for-loop|0
        local.get $3
        i32.const 23
        i32.lt_u
        if
         local.get $3
         i32.const 2
         i32.shl
         i32.const 34416
         i32.add
         i32.const 0
         i32.store offset=4
         i32.const 0
         local.set $4
         loop $for-loop|1
          local.get $4
          i32.const 16
          i32.lt_u
          if
           local.get $3
           i32.const 4
           i32.shl
           local.get $4
           i32.add
           i32.const 2
           i32.shl
           i32.const 34416
           i32.add
           i32.const 0
           i32.store offset=96
           local.get $4
           i32.const 1
           i32.add
           local.set $4
           br $for-loop|1
          end
         end
         local.get $3
         i32.const 1
         i32.add
         local.set $3
         br $for-loop|0
        end
       end
       i32.const 0
       local.set $2
       memory.size
       i64.extend_i32_s
       i64.const 16
       i64.shl
       local.tee $7
       i64.const 35988
       i64.lt_u
       if
        br $folding-inner0
       end
       i32.const 35996
       local.set $3
       i32.const 35984
       i32.load
       local.tee $4
       if
        local.get $4
        i32.const 4
        i32.add
        i32.const 35996
        i32.gt_u
        if
         br $folding-inner1
        end
        local.get $4
        i32.const 35980
        i32.eq
        if (result i32)
         local.get $4
         i32.load
         local.set $2
         i32.const 35980
        else
         i32.const 35996
        end
        local.set $3
       end
       local.get $7
       i32.wrap_i64
       i32.const -16
       i32.and
       local.get $3
       i32.sub
       local.tee $4
       i32.const 20
       i32.ge_u
       if
        local.get $3
        local.get $2
        i32.const 2
        i32.and
        local.get $4
        i32.const 8
        i32.sub
        local.tee $4
        i32.const 1
        i32.or
        i32.or
        i32.store
        local.get $3
        i32.const 0
        i32.store offset=4
        local.get $3
        i32.const 0
        i32.store offset=8
        local.get $3
        i32.const 4
        i32.add
        local.get $4
        i32.add
        local.tee $4
        i32.const 2
        i32.store
        i32.const 35984
        local.get $4
        i32.store
        i32.const 34416
        local.get $3
        call $~lib/rt/tlsf/insertBlock
       end
       i32.const 34416
       global.set $~lib/rt/tlsf/ROOT
      end
      global.get $~lib/rt/tlsf/ROOT
      local.set $3
      local.get $0
      i32.const 16
      i32.add
      local.tee $4
      i32.const 1073741820
      i32.gt_u
      if
       i32.const 1104
       i32.const 1440
       i32.const 435
       i32.const 29
       call $~lib/builtins/abort
       unreachable
      end
      local.get $4
      i32.const 12
      i32.le_u
      if (result i32)
       i32.const 12
      else
       local.get $4
       i32.const 19
       i32.add
       i32.const -16
       i32.and
       i32.const 4
       i32.sub
      end
      local.tee $4
      local.tee $2
      i32.const 256
      i32.lt_u
      if (result i32)
       local.get $2
       i32.const 4
       i32.shr_u
       local.set $2
       i32.const 0
      else
       local.get $2
       i32.const 536870910
       i32.lt_u
       if
        local.get $2
        i32.const 1
        i32.const 27
        local.get $2
        i32.clz
        i32.sub
        i32.shl
        i32.add
        i32.const 1
        i32.sub
        local.set $2
       end
       local.get $2
       i32.const 31
       local.get $2
       i32.clz
       i32.sub
       local.tee $5
       i32.const 4
       i32.sub
       i32.shr_u
       i32.const 16
       i32.xor
       local.set $2
       local.get $5
       i32.const 7
       i32.sub
      end
      local.set $5
      local.get $2
      i32.const 16
      i32.lt_u
      local.get $5
      i32.const 23
      i32.lt_u
      i32.and
      i32.eqz
      if
       br $folding-inner2
      end
      local.get $3
      local.get $5
      i32.const 2
      i32.shl
      i32.add
      i32.load offset=4
      i32.const -1
      local.get $2
      i32.shl
      i32.and
      local.tee $2
      if (result i32)
       local.get $3
       local.get $2
       i32.ctz
       local.get $5
       i32.const 4
       i32.shl
       i32.add
       i32.const 2
       i32.shl
       i32.add
       i32.load offset=96
      else
       local.get $3
       i32.load
       i32.const -1
       local.get $5
       i32.const 1
       i32.add
       i32.shl
       i32.and
       local.tee $2
       if (result i32)
        local.get $3
        local.get $2
        i32.ctz
        local.tee $2
        i32.const 2
        i32.shl
        i32.add
        i32.load offset=4
        local.tee $5
        i32.eqz
        if
         br $folding-inner3
        end
        local.get $3
        local.get $5
        i32.ctz
        local.get $2
        i32.const 4
        i32.shl
        i32.add
        i32.const 2
        i32.shl
        i32.add
        i32.load offset=96
       else
        i32.const 0
       end
      end
      local.tee $2
      i32.eqz
      if
       memory.size
       local.tee $2
       local.get $4
       i32.const 256
       i32.ge_u
       if (result i32)
        local.get $4
        i32.const 536870910
        i32.lt_u
        if (result i32)
         local.get $4
         i32.const 1
         i32.const 27
         local.get $4
         i32.clz
         i32.sub
         i32.shl
         i32.add
         i32.const 1
         i32.sub
        else
         local.get $4
        end
       else
        local.get $4
       end
       i32.const 4
       local.get $3
       i32.load offset=1568
       local.get $2
       i32.const 16
       i32.shl
       i32.const 4
       i32.sub
       i32.ne
       i32.shl
       i32.add
       i32.const 65535
       i32.add
       i32.const -65536
       i32.and
       i32.const 16
       i32.shr_u
       local.tee $5
       local.get $2
       local.get $5
       i32.gt_s
       select
       memory.grow
       i32.const 0
       i32.lt_s
       if
        local.get $5
        memory.grow
        i32.const 0
        i32.lt_s
        if
         unreachable
        end
       end
       memory.size
       i64.extend_i32_s
       i64.const 16
       i64.shl
       local.tee $7
       local.get $2
       i32.const 16
       i32.shl
       local.tee $2
       i64.extend_i32_u
       i64.lt_u
       if
        br $folding-inner0
       end
       local.get $2
       i32.const 19
       i32.add
       i32.const -16
       i32.and
       i32.const 4
       i32.sub
       local.set $2
       local.get $3
       i32.load offset=1568
       local.tee $6
       if
        local.get $6
        i32.const 4
        i32.add
        local.get $2
        i32.gt_u
        if
         br $folding-inner1
        end
        local.get $2
        i32.const 16
        i32.sub
        local.tee $5
        local.get $6
        i32.eq
        if
         local.get $6
         i32.load
         local.set $8
         local.get $5
         local.set $2
        end
       else
        local.get $3
        i32.const 1572
        i32.add
        local.get $2
        i32.gt_u
        if
         i32.const 0
         i32.const 1440
         i32.const 378
         i32.const 5
         call $~lib/builtins/abort
         unreachable
        end
       end
       local.get $7
       i32.wrap_i64
       i32.const -16
       i32.and
       local.get $2
       i32.sub
       local.tee $5
       i32.const 20
       i32.ge_u
       if
        local.get $2
        local.get $8
        i32.const 2
        i32.and
        local.get $5
        i32.const 8
        i32.sub
        local.tee $5
        i32.const 1
        i32.or
        i32.or
        i32.store
        local.get $2
        i32.const 0
        i32.store offset=4
        local.get $2
        i32.const 0
        i32.store offset=8
        local.get $2
        i32.const 4
        i32.add
        local.get $5
        i32.add
        local.tee $5
        i32.const 2
        i32.store
        local.get $3
        local.get $5
        i32.store offset=1568
        local.get $3
        local.get $2
        call $~lib/rt/tlsf/insertBlock
       end
       local.get $4
       local.tee $2
       i32.const 256
       i32.lt_u
       if (result i32)
        local.get $2
        i32.const 4
        i32.shr_u
        local.set $2
        i32.const 0
       else
        local.get $2
        i32.const 536870910
        i32.lt_u
        if
         local.get $2
         i32.const 1
         i32.const 27
         local.get $2
         i32.clz
         i32.sub
         i32.shl
         i32.add
         i32.const 1
         i32.sub
         local.set $2
        end
        local.get $2
        i32.const 31
        local.get $2
        i32.clz
        i32.sub
        local.tee $5
        i32.const 4
        i32.sub
        i32.shr_u
        i32.const 16
        i32.xor
        local.set $2
        local.get $5
        i32.const 7
        i32.sub
       end
       local.set $5
       local.get $2
       i32.const 16
       i32.lt_u
       local.get $5
       i32.const 23
       i32.lt_u
       i32.and
       i32.eqz
       if
        br $folding-inner2
       end
       local.get $3
       local.get $5
       i32.const 2
       i32.shl
       i32.add
       i32.load offset=4
       i32.const -1
       local.get $2
       i32.shl
       i32.and
       local.tee $2
       if (result i32)
        local.get $3
        local.get $2
        i32.ctz
        local.get $5
        i32.const 4
        i32.shl
        i32.add
        i32.const 2
        i32.shl
        i32.add
        i32.load offset=96
       else
        local.get $3
        i32.load
        i32.const -1
        local.get $5
        i32.const 1
        i32.add
        i32.shl
        i32.and
        local.tee $2
        if (result i32)
         local.get $3
         local.get $2
         i32.ctz
         local.tee $2
         i32.const 2
         i32.shl
         i32.add
         i32.load offset=4
         local.tee $5
         i32.eqz
         if
          br $folding-inner3
         end
         local.get $3
         local.get $5
         i32.ctz
         local.get $2
         i32.const 4
         i32.shl
         i32.add
         i32.const 2
         i32.shl
         i32.add
         i32.load offset=96
        else
         i32.const 0
        end
       end
       local.tee $2
       i32.eqz
       if
        i32.const 0
        i32.const 1440
        i32.const 472
        i32.const 16
        call $~lib/builtins/abort
        unreachable
       end
      end
      local.get $4
      local.get $2
      i32.load
      i32.const -4
      i32.and
      i32.gt_u
      if
       i32.const 0
       i32.const 1440
       i32.const 474
       i32.const 14
       call $~lib/builtins/abort
       unreachable
      end
      local.get $3
      local.get $2
      call $~lib/rt/tlsf/removeBlock
      local.get $2
      i32.load
      local.set $5
      local.get $4
      i32.const 4
      i32.add
      i32.const 15
      i32.and
      if
       i32.const 0
       i32.const 1440
       i32.const 336
       i32.const 14
       call $~lib/builtins/abort
       unreachable
      end
      local.get $5
      i32.const -4
      i32.and
      local.get $4
      i32.sub
      local.tee $6
      i32.const 16
      i32.ge_u
      if
       local.get $2
       local.get $4
       local.get $5
       i32.const 2
       i32.and
       i32.or
       i32.store
       local.get $2
       i32.const 4
       i32.add
       local.get $4
       i32.add
       local.tee $4
       local.get $6
       i32.const 4
       i32.sub
       i32.const 1
       i32.or
       i32.store
       local.get $3
       local.get $4
       call $~lib/rt/tlsf/insertBlock
      else
       local.get $2
       local.get $5
       i32.const -2
       i32.and
       i32.store
       local.get $2
       i32.const 4
       i32.add
       local.tee $3
       local.get $2
       i32.load
       i32.const -4
       i32.and
       local.tee $4
       i32.add
       local.get $3
       local.get $4
       i32.add
       i32.load
       i32.const -3
       i32.and
       i32.store
      end
      local.get $2
      local.get $1
      i32.store offset=12
      local.get $2
      local.get $0
      i32.store offset=16
      global.get $~lib/rt/itcms/fromSpace
      local.tee $3
      i32.load offset=8
      local.set $1
      local.get $2
      global.get $~lib/rt/itcms/white
      local.get $3
      i32.or
      i32.store offset=4
      local.get $2
      local.get $1
      i32.store offset=8
      local.get $1
      local.get $2
      local.get $1
      i32.load offset=4
      i32.const 3
      i32.and
      i32.or
      i32.store offset=4
      local.get $3
      local.get $2
      i32.store offset=8
      global.get $~lib/rt/itcms/total
      local.get $2
      i32.load
      i32.const -4
      i32.and
      i32.const 4
      i32.add
      i32.add
      global.set $~lib/rt/itcms/total
      local.get $2
      i32.const 20
      i32.add
      local.tee $1
      i32.const 0
      local.get $0
      memory.fill
      local.get $1
      return
     end
     i32.const 0
     i32.const 1440
     i32.const 357
     i32.const 14
     call $~lib/builtins/abort
     unreachable
    end
    i32.const 0
    i32.const 1440
    i32.const 365
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 0
   i32.const 1440
   i32.const 309
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  i32.const 1440
  i32.const 322
  i32.const 18
  call $~lib/builtins/abort
  unreachable
 )
 (func $~lib/rt/itcms/__pin (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  if
   local.get $0
   i32.const 20
   i32.sub
   local.tee $1
   i32.load offset=4
   i32.const 3
   i32.and
   i32.const 3
   i32.eq
   if
    i32.const 1504
    i32.const 1168
    i32.const 338
    i32.const 7
    call $~lib/builtins/abort
    unreachable
   end
   block $__inlined_func$~lib/rt/itcms/Object#unlink$11
    local.get $1
    i32.load offset=4
    i32.const -4
    i32.and
    local.tee $3
    i32.eqz
    if
     local.get $1
     i32.load offset=8
     i32.eqz
     local.get $1
     i32.const 34404
     i32.lt_u
     i32.and
     i32.eqz
     if
      i32.const 0
      i32.const 1168
      i32.const 127
      i32.const 18
      call $~lib/builtins/abort
      unreachable
     end
     br $__inlined_func$~lib/rt/itcms/Object#unlink$11
    end
    local.get $1
    i32.load offset=8
    local.tee $2
    i32.eqz
    if
     i32.const 0
     i32.const 1168
     i32.const 131
     i32.const 16
     call $~lib/builtins/abort
     unreachable
    end
    local.get $3
    local.get $2
    i32.store offset=8
    local.get $2
    local.get $3
    local.get $2
    i32.load offset=4
    i32.const 3
    i32.and
    i32.or
    i32.store offset=4
   end
   global.get $~lib/rt/itcms/pinSpace
   local.tee $3
   i32.load offset=8
   local.set $2
   local.get $1
   local.get $3
   i32.const 3
   i32.or
   i32.store offset=4
   local.get $1
   local.get $2
   i32.store offset=8
   local.get $2
   local.get $1
   local.get $2
   i32.load offset=4
   i32.const 3
   i32.and
   i32.or
   i32.store offset=4
   local.get $3
   local.get $1
   i32.store offset=8
  end
  local.get $0
 )
 (func $~lib/rt/itcms/__unpin (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  if
   local.get $0
   i32.const 20
   i32.sub
   local.tee $0
   i32.load offset=4
   i32.const 3
   i32.and
   i32.const 3
   i32.ne
   if
    i32.const 1568
    i32.const 1168
    i32.const 352
    i32.const 5
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/rt/itcms/state
   i32.const 1
   i32.eq
   if
    local.get $0
    call $~lib/rt/itcms/Object#makeGray
   else
    block $__inlined_func$~lib/rt/itcms/Object#unlink$13
     local.get $0
     i32.load offset=4
     i32.const -4
     i32.and
     local.tee $2
     i32.eqz
     if
      local.get $0
      i32.load offset=8
      i32.eqz
      local.get $0
      i32.const 34404
      i32.lt_u
      i32.and
      i32.eqz
      if
       i32.const 0
       i32.const 1168
       i32.const 127
       i32.const 18
       call $~lib/builtins/abort
       unreachable
      end
      br $__inlined_func$~lib/rt/itcms/Object#unlink$13
     end
     local.get $0
     i32.load offset=8
     local.tee $1
     i32.eqz
     if
      i32.const 0
      i32.const 1168
      i32.const 131
      i32.const 16
      call $~lib/builtins/abort
      unreachable
     end
     local.get $2
     local.get $1
     i32.store offset=8
     local.get $1
     local.get $2
     local.get $1
     i32.load offset=4
     i32.const 3
     i32.and
     i32.or
     i32.store offset=4
    end
    global.get $~lib/rt/itcms/fromSpace
    local.tee $2
    i32.load offset=8
    local.set $1
    local.get $0
    global.get $~lib/rt/itcms/white
    local.get $2
    i32.or
    i32.store offset=4
    local.get $0
    local.get $1
    i32.store offset=8
    local.get $1
    local.get $0
    local.get $1
    i32.load offset=4
    i32.const 3
    i32.and
    i32.or
    i32.store offset=4
    local.get $2
    local.get $0
    i32.store offset=8
   end
  end
 )
 (func $~lib/rt/itcms/__collect
  global.get $~lib/rt/itcms/state
  i32.const 0
  i32.gt_s
  if
   loop $while-continue|0
    global.get $~lib/rt/itcms/state
    if
     call $~lib/rt/itcms/step
     drop
     br $while-continue|0
    end
   end
  end
  call $~lib/rt/itcms/step
  drop
  loop $while-continue|1
   global.get $~lib/rt/itcms/state
   if
    call $~lib/rt/itcms/step
    drop
    br $while-continue|1
   end
  end
  global.get $~lib/rt/itcms/total
  i64.extend_i32_u
  i64.const 200
  i64.mul
  i64.const 100
  i64.div_u
  i32.wrap_i64
  i32.const 1024
  i32.add
  global.set $~lib/rt/itcms/threshold
 )
 (func $~start
  memory.size
  i32.const 16
  i32.shl
  i32.const 34404
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 1220
  i32.const 1216
  i32.store
  i32.const 1224
  i32.const 1216
  i32.store
  i32.const 1216
  global.set $~lib/rt/itcms/pinSpace
  i32.const 1252
  i32.const 1248
  i32.store
  i32.const 1256
  i32.const 1248
  i32.store
  i32.const 1248
  global.set $~lib/rt/itcms/toSpace
  i32.const 1396
  i32.const 1392
  i32.store
  i32.const 1400
  i32.const 1392
  i32.store
  i32.const 1392
  global.set $~lib/rt/itcms/fromSpace
 )
)
