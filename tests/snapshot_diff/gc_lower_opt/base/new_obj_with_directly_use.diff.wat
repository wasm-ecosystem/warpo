;; ====================
(func $tests/snapshot_diff/gc_lower_opt/base/new_obj_with_directly_use/_start)
;; =========add========
  (local i32)
  block ;;none
      i32.const 4
    call $~lib/rt/__decrease_sp
      block ;;i32
;; ====================
            i32.const 0
          call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; ======remove=======
;;  call $~lib/rt/__tmptostack
;; =========add========
        local.set $0
          global.get $~lib/memory/__stack_pointer
          local.get $0
        i32.store $0 align=1
        local.get $0
      end
;; ====================
    call $tests/snapshot_diff/gc_lower_opt/base/new_obj_with_directly_use/foo
;; =========add========
      i32.const 4
    call $~lib/rt/__increase_sp
  end
;; ====================
)
