(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32) (result i64)))
 (type $2 (func (param i64) (result i32)))
 (type $3 (func (param i64) (result i64)))
 (type $4 (func))
 (type $5 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $"cast/test<i8,i8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i8,u8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i8,i16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.extend8_s
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i8,u16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.extend8_s
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i8,i32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.extend8_s
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i8,u32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.extend8_s
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i8,i64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_s
    (i32.extend8_s
     (local.get $x)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i8,u64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_s
    (i32.extend8_s
     (local.get $x)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i8,bool>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u8,i8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u8,u8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u8,i16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.and
    (local.get $x)
    (i32.const 255)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u8,u16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.and
    (local.get $x)
    (i32.const 255)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u8,i32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.and
    (local.get $x)
    (i32.const 255)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u8,u32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.and
    (local.get $x)
    (i32.const 255)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u8,i64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_u
    (i32.and
     (local.get $x)
     (i32.const 255)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u8,u64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_u
    (i32.and
     (local.get $x)
     (i32.const 255)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u8,bool>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i16,i8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i16,u8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i16,i16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i16,u16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i16,i32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.extend16_s
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i16,u32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.extend16_s
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i16,i64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_s
    (i32.extend16_s
     (local.get $x)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i16,u64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_s
    (i32.extend16_s
     (local.get $x)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i16,bool>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u16,i8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u16,u8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u16,i16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u16,u16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u16,i32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.and
    (local.get $x)
    (i32.const 65535)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u16,u32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.and
    (local.get $x)
    (i32.const 65535)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u16,i64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_u
    (i32.and
     (local.get $x)
     (i32.const 65535)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u16,u64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_u
    (i32.and
     (local.get $x)
     (i32.const 65535)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u16,bool>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i32,i8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i32,u8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i32,i16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i32,u16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i32,i32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i32,u32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i32,i64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_s
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i32,u64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_s
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i32,bool>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u32,i8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u32,u8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u32,i16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u32,u16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u32,i32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u32,u32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u32,i64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_u
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u32,u64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_u
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u32,bool>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i64,i8>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i64,u8>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i64,i16>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i64,u16>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i64,i32>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i64,u32>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i64,i64>" (param $x i64) (result i64)
  (local $y i64)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i64,u64>" (param $x i64) (result i64)
  (local $y i64)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<i64,bool>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i64.ne
    (local.get $x)
    (i64.const 0)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u64,i8>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u64,u8>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u64,i16>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u64,u16>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u64,i32>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u64,u32>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i32.wrap_i64
    (local.get $x)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u64,i64>" (param $x i64) (result i64)
  (local $y i64)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u64,u64>" (param $x i64) (result i64)
  (local $y i64)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<u64,bool>" (param $x i64) (result i32)
  (local $y i32)
  (local.set $y
   (i64.ne
    (local.get $x)
    (i64.const 0)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<bool,i8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.ne
    (local.get $x)
    (i32.const 0)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<bool,u8>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.ne
    (local.get $x)
    (i32.const 0)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<bool,i16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.ne
    (local.get $x)
    (i32.const 0)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<bool,u16>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.ne
    (local.get $x)
    (i32.const 0)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<bool,i32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.ne
    (local.get $x)
    (i32.const 0)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<bool,u32>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (i32.ne
    (local.get $x)
    (i32.const 0)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<bool,i64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_u
    (i32.ne
     (local.get $x)
     (i32.const 0)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<bool,u64>" (param $x i32) (result i64)
  (local $y i64)
  (local.set $y
   (i64.extend_i32_u
    (i32.ne
     (local.get $x)
     (i32.const 0)
    )
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $"cast/test<bool,bool>" (param $x i32) (result i32)
  (local $y i32)
  (local.set $y
   (local.get $x)
  )
  (return
   (local.get $y)
  )
 )
 (func $start:cast
  (drop
   (call $"cast/test<i8,i8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i8,u8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i8,i16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i8,u16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i8,i32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i8,u32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i8,i64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i8,u64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i8,bool>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u8,i8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u8,u8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u8,i16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u8,u16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u8,i32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u8,u32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u8,i64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u8,u64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u8,bool>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i16,i8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i16,u8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i16,i16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i16,u16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i16,i32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i16,u32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i16,i64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i16,u64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i16,bool>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u16,i8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u16,u8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u16,i16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u16,u16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u16,i32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u16,u32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u16,i64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u16,u64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u16,bool>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i32,i8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i32,u8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i32,i16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i32,u16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i32,i32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i32,u32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i32,i64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i32,u64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i32,bool>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u32,i8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u32,u8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u32,i16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u32,u16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u32,i32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u32,u32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u32,i64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u32,u64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<u32,bool>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<i64,i8>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<i64,u8>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<i64,i16>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<i64,u16>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<i64,i32>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<i64,u32>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<i64,i64>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<i64,u64>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<i64,bool>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<u64,i8>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<u64,u8>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<u64,i16>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<u64,u16>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<u64,i32>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<u64,u32>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<u64,i64>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<u64,u64>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<u64,bool>"
    (i64.const 0)
   )
  )
  (drop
   (call $"cast/test<bool,i8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<bool,u8>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<bool,i16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<bool,u16>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<bool,i32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<bool,u32>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<bool,i64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<bool,u64>"
    (i32.const 0)
   )
  )
  (drop
   (call $"cast/test<bool,bool>"
    (i32.const 0)
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
  (call $start:cast)
 )
)
