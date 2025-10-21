;; ====================
(func $tests/snapshot_diff/gc_lower_opt/reuse_stack/reuse_stack_for_difference_ssa/_start)
  (local i32)
  (local i32)
  (local i32)
  block ;;none
;; ======remove=======
;;    i32.const 16
;; =========add========
      i32.const 4
;; ====================
    call $~lib/rt/__decrease_sp
    block ;;none
        block ;;i32
              i32.const 0
            call $tests/snapshot_diff/common_lib/normal/Normal#constructor
          local.set $2
            global.get $~lib/memory/__stack_pointer
            local.get $2
          i32.store $0 align=1
          local.get $2
        end
      local.set $0
        block ;;i32
            global.get $~lib/memory/__stack_pointer
            local.get $0
;; ======remove=======
;;        i32.store $0 offset=4 align=1
;; =========add========
          i32.store $0 align=1
;; ====================
          local.get $0
        end
      call $tests/snapshot_diff/gc_lower_opt/reuse_stack/reuse_stack_for_difference_ssa/foo
        block ;;i32
              i32.const 0
            call $tests/snapshot_diff/common_lib/normal/Normal#constructor
          local.set $2
            global.get $~lib/memory/__stack_pointer
            local.get $2
;; ======remove=======
;;        i32.store $0 offset=8 align=1
;; =========add========
          i32.store $0 align=1
;; ====================
          local.get $2
        end
      local.set $1
        block ;;i32
            global.get $~lib/memory/__stack_pointer
            local.get $1
;; ======remove=======
;;        i32.store $0 offset=12 align=1
;; =========add========
          i32.store $0 align=1
;; ====================
          local.get $1
        end
      call $tests/snapshot_diff/gc_lower_opt/reuse_stack/reuse_stack_for_difference_ssa/foo
    end
;; ======remove=======
;;    i32.const 16
;; =========add========
      i32.const 4
;; ====================
    call $~lib/rt/__increase_sp
  end
)
