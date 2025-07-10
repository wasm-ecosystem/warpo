;; ====================
(func $tests/gc_ssa_merge/ssa_not_merge/_start (type $func.0 (func))
  block ;;none
      i32.const 4
    call $~lib/rt/__decrease_sp
          i32.const 0
        call $tests/common_lib/normal/Normal#constructor
      call $~lib/rt/__tostack<0>
    call $tests/gc_ssa_merge/ssa_not_merge/foo
      i32.const 4
    call $~lib/rt/__increase_sp
  end
)
