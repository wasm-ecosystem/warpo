(module
 (type $0 (func (param i32)))
 (type $1 (func))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02")
 (data $1 (i32.const 44) "\1c")
 (data $1.1 (i32.const 56) "\02\00\00\00\02\00\00\00a")
 (data $2 (i32.const 76) "\1c")
 (data $2.1 (i32.const 88) "\02\00\00\00\04\00\00\00a\00b")
 (data $3 (i32.const 108) "\1c")
 (data $3.1 (i32.const 120) "\02\00\00\00\06\00\00\00a\00b\00c")
 (data $4 (i32.const 140) "\1c")
 (data $4.1 (i32.const 152) "\02\00\00\00\08\00\00\00a\00b\00c\00d")
 (data $5 (i32.const 172) "\1c")
 (data $5.1 (i32.const 184) "\02\00\00\00\n\00\00\00a\00b\00c\00d\00e")
 (data $6 (i32.const 204) "\1c")
 (data $6.1 (i32.const 216) "\02\00\00\00\0c\00\00\00a\00b\00c\00d\00e\00f")
 (data $7 (i32.const 236) ",")
 (data $7.1 (i32.const 248) "\02\00\00\00\0e\00\00\00a\00b\00c\00d\00e\00f\00g")
 (data $8 (i32.const 284) ",")
 (data $8.1 (i32.const 296) "\02\00\00\00\10\00\00\00a\00b\00c\00d\00e\00f\00g\00h")
 (data $9 (i32.const 332) ",")
 (data $9.1 (i32.const 344) "\02\00\00\00\12\00\00\00a\00b\00c\00d\00e\00f\00g\00h\00i")
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/util/hash/HASH<~lib/string/String|null> (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $0
  if
   local.get $0
   local.tee $1
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const -2
   i32.and
   local.tee $3
   i32.const 16
   i32.ge_u
   if (result i32)
    i32.const 606290984
    local.set $2
    i32.const -2048144777
    local.set $4
    i32.const 1640531535
    local.set $5
    local.get $1
    local.get $3
    i32.add
    i32.const 16
    i32.sub
    local.set $7
    loop $while-continue|0
     local.get $1
     local.get $7
     i32.le_u
     if
      local.get $2
      local.get $1
      i32.load
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $2
      local.get $4
      local.get $1
      i32.load offset=4
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $4
      local.get $6
      local.get $1
      i32.load offset=8
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $6
      local.get $5
      local.get $1
      i32.load offset=12
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $5
      local.get $1
      i32.const 16
      i32.add
      local.set $1
      br $while-continue|0
     end
    end
    local.get $3
    local.get $2
    i32.const 1
    i32.rotl
    local.get $4
    i32.const 7
    i32.rotl
    i32.add
    local.get $6
    i32.const 12
    i32.rotl
    i32.add
    local.get $5
    i32.const 18
    i32.rotl
    i32.add
    i32.add
   else
    local.get $3
    i32.const 374761393
    i32.add
   end
   local.set $2
   local.get $0
   local.get $3
   i32.add
   i32.const 4
   i32.sub
   local.set $4
   loop $while-continue|1
    local.get $1
    local.get $4
    i32.le_u
    if
     local.get $2
     local.get $1
     i32.load
     i32.const -1028477379
     i32.mul
     i32.add
     i32.const 17
     i32.rotl
     i32.const 668265263
     i32.mul
     local.set $2
     local.get $1
     i32.const 4
     i32.add
     local.set $1
     br $while-continue|1
    end
   end
   local.get $0
   local.get $3
   i32.add
   local.set $0
   loop $while-continue|2
    local.get $0
    local.get $1
    i32.gt_u
    if
     local.get $2
     local.get $1
     i32.load8_u
     i32.const 374761393
     i32.mul
     i32.add
     i32.const 11
     i32.rotl
     i32.const -1640531535
     i32.mul
     local.set $2
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $while-continue|2
    end
   end
  end
 )
 (func $~start
  i32.const 0
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 32
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 64
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 96
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 128
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 160
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 192
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 224
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 256
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 304
  call $~lib/util/hash/HASH<~lib/string/String|null>
  i32.const 352
  call $~lib/util/hash/HASH<~lib/string/String|null>
 )
)
