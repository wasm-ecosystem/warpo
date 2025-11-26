(module
 (type $0 (func (param i32 i32 f64 f64 f64 f64 f64)))
 (type $1 (func))
 (import "env" "trace" (func $~lib/builtins/trace (param i32 i32 f64 f64 f64 f64 f64)))
 (global $~started (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) ",")
 (data $0.1 (i32.const 24) "\02\00\00\00\1a\00\00\00z\00e\00r\00o\00_\00i\00m\00p\00l\00i\00c\00i\00t")
 (data $1 (i32.const 60) ",")
 (data $1.1 (i32.const 72) "\02\00\00\00\1a\00\00\00z\00e\00r\00o\00_\00e\00x\00p\00l\00i\00c\00i\00t")
 (data $2 (i32.const 108) ",")
 (data $2.1 (i32.const 120) "\02\00\00\00\0e\00\00\00o\00n\00e\00_\00i\00n\00t")
 (data $3 (i32.const 156) ",")
 (data $3.1 (i32.const 168) "\02\00\00\00\0e\00\00\00t\00w\00o\00_\00i\00n\00t")
 (data $4 (i32.const 204) ",")
 (data $4.1 (i32.const 216) "\02\00\00\00\12\00\00\00t\00h\00r\00e\00e\00_\00i\00n\00t")
 (data $5 (i32.const 252) ",")
 (data $5.1 (i32.const 264) "\02\00\00\00\10\00\00\00f\00o\00u\00r\00_\00i\00n\00t")
 (data $6 (i32.const 300) ",")
 (data $6.1 (i32.const 312) "\02\00\00\00\10\00\00\00f\00i\00v\00e\00_\00i\00n\00t")
 (data $7 (i32.const 348) ",")
 (data $7.1 (i32.const 360) "\02\00\00\00\10\00\00\00f\00i\00v\00e\00_\00d\00b\00l")
 (export "memory" (memory $0))
 (export "_start" (func $~start))
 (func $~start
  global.get $~started
  i32.eqz
  if
   i32.const 1
   global.set $~started
   i32.const 32
   i32.const 0
   f64.const 0
   f64.const 0
   f64.const 0
   f64.const 0
   f64.const 0
   call $~lib/builtins/trace
   i32.const 80
   i32.const 0
   f64.const 0
   f64.const 0
   f64.const 0
   f64.const 0
   f64.const 0
   call $~lib/builtins/trace
   i32.const 128
   i32.const 1
   f64.const 1
   f64.const 0
   f64.const 0
   f64.const 0
   f64.const 0
   call $~lib/builtins/trace
   i32.const 176
   i32.const 2
   f64.const 1
   f64.const 2
   f64.const 0
   f64.const 0
   f64.const 0
   call $~lib/builtins/trace
   i32.const 224
   i32.const 3
   f64.const 1
   f64.const 2
   f64.const 3
   f64.const 0
   f64.const 0
   call $~lib/builtins/trace
   i32.const 272
   i32.const 4
   f64.const 1
   f64.const 2
   f64.const 3
   f64.const 4
   f64.const 0
   call $~lib/builtins/trace
   i32.const 320
   i32.const 5
   f64.const 1
   f64.const 2
   f64.const 3
   f64.const 4
   f64.const 5
   call $~lib/builtins/trace
   i32.const 368
   i32.const 5
   f64.const 1.1
   f64.const 2.2
   f64.const 3.3
   f64.const 4.4
   f64.const 5.5
   call $~lib/builtins/trace
  end
 )
)
