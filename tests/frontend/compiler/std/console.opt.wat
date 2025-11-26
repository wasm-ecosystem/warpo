(module
 (type $0 (func (param i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func))
 (import "env" "console.assert" (func $~lib/bindings/dom/console.assert (param i32 i32)))
 (import "env" "console.log" (func $~lib/bindings/dom/console.log (param i32)))
 (import "env" "console.debug" (func $~lib/bindings/dom/console.debug (param i32)))
 (import "env" "console.info" (func $~lib/bindings/dom/console.info (param i32)))
 (import "env" "console.warn" (func $~lib/bindings/dom/console.warn (param i32)))
 (import "env" "console.error" (func $~lib/bindings/dom/console.error (param i32)))
 (import "env" "console.time" (func $~lib/bindings/dom/console.time (param i32)))
 (import "env" "console.timeLog" (func $~lib/bindings/dom/console.timeLog (param i32)))
 (import "env" "console.timeEnd" (func $~lib/bindings/dom/console.timeEnd (param i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02\00\00\00\0c\00\00\00w\00h\00o\00o\00p\00s")
 (data $1 (i32.const 44) "\1c")
 (data $1.1 (i32.const 56) "\02\00\00\00\08\00\00\00p\00h\00e\00w")
 (data $2 (i32.const 76) ",")
 (data $2.1 (i32.const 88) "\02\00\00\00\12\00\00\00h\00e\00l\00l\00o\00 \00l\00o\00g")
 (data $3 (i32.const 124) ",")
 (data $3.1 (i32.const 136) "\02\00\00\00\16\00\00\00h\00e\00l\00l\00o\00 \00d\00e\00b\00u\00g")
 (data $4 (i32.const 172) ",")
 (data $4.1 (i32.const 184) "\02\00\00\00\14\00\00\00h\00e\00l\00l\00o\00 \00i\00n\00f\00o")
 (data $5 (i32.const 220) ",")
 (data $5.1 (i32.const 232) "\02\00\00\00\14\00\00\00h\00e\00l\00l\00o\00 \00w\00a\00r\00n")
 (data $6 (i32.const 268) ",")
 (data $6.1 (i32.const 280) "\02\00\00\00\16\00\00\00h\00e\00l\00l\00o\00 \00e\00r\00r\00o\00r")
 (data $7 (i32.const 316) ",")
 (data $7.1 (i32.const 328) "\02\00\00\00\12\00\00\00s\00o\00m\00e\00L\00a\00b\00e\00l")
 (data $8 (i32.const 364) ",")
 (data $8.1 (i32.const 376) "\02\00\00\00\14\00\00\00w\00r\00o\00n\00g\00L\00a\00b\00e\00l")
 (data $9 (i32.const 412) ",")
 (data $9.1 (i32.const 424) "\02\00\00\00\1c\00\00\00d\00u\00p\00l\00i\00c\00a\00t\00e\00L\00a\00b\00e\00l")
 (data $10 (i32.const 460) "\1c")
 (data $10.1 (i32.const 472) "\02\00\00\00\02\00\00\001")
 (data $11 (i32.const 492) "\1c")
 (data $11.1 (i32.const 504) "\02\00\00\00\04\00\00\001\002")
 (data $12 (i32.const 524) "\1c")
 (data $12.1 (i32.const 536) "\02\00\00\00\06\00\00\001\002\003")
 (data $13 (i32.const 556) "\1c")
 (data $13.1 (i32.const 568) "\02\00\00\00\08\00\00\001\002\003\004")
 (export "memory" (memory $0))
 (start $~start)
 (func $~start
  i32.const 0
  i32.const 32
  call $~lib/bindings/dom/console.assert
  i32.const 1
  i32.const 64
  call $~lib/bindings/dom/console.assert
  i32.const 96
  call $~lib/bindings/dom/console.log
  i32.const 144
  call $~lib/bindings/dom/console.debug
  i32.const 192
  call $~lib/bindings/dom/console.info
  i32.const 240
  call $~lib/bindings/dom/console.warn
  i32.const 288
  call $~lib/bindings/dom/console.error
  i32.const 336
  call $~lib/bindings/dom/console.time
  i32.const 336
  call $~lib/bindings/dom/console.timeLog
  i32.const 336
  call $~lib/bindings/dom/console.timeEnd
  i32.const 384
  call $~lib/bindings/dom/console.timeLog
  i32.const 384
  call $~lib/bindings/dom/console.timeEnd
  i32.const 432
  call $~lib/bindings/dom/console.time
  i32.const 432
  call $~lib/bindings/dom/console.time
  i32.const 480
  call $~lib/bindings/dom/console.log
  i32.const 512
  call $~lib/bindings/dom/console.log
  i32.const 544
  call $~lib/bindings/dom/console.log
  i32.const 576
  call $~lib/bindings/dom/console.log
 )
)
