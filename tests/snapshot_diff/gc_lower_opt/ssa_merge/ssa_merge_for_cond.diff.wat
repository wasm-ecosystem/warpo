;; ====================
(func $tests/snapshot_diff/gc_lower_opt/ssa_merge/ssa_merge_for_cond/_start)
  (local i32)
  (local i32)
  block ;;none
;; ======remove=======
;;    i32.const 12
;; =========add========
      i32.const 8
;; ====================
    call $~lib/rt/__decrease_sp
    block ;;none
        block ;;i32
            global.get $~lib/memory/__stack_pointer
            i32.const 0
          i32.store $0 align=1
          i32.const 0
        end
      local.set $0
      if ;;none
        global.get $tests/snapshot_diff/gc_lower_opt/ssa_merge/ssa_merge_for_cond/g
          block ;;i32
                i32.const 0
              call $tests/snapshot_diff/common_lib/normal/Normal#constructor
            local.set $1
              global.get $~lib/memory/__stack_pointer
              local.get $1
            i32.store $0 offset=4 align=1
            local.get $1
          end
        local.set $0
      end
;; ======remove=======
;;      block ;;i32
;;          global.get $~lib/memory/__stack_pointer
;; ====================
        local.get $0
;; ======remove=======
;;        i32.store $0 offset=8 align=1
;;        local.get $0
;;      end
;; ====================
      call $tests/snapshot_diff/gc_lower_opt/ssa_merge/ssa_merge_for_cond/foo
    end
;; ======remove=======
;;    i32.const 12
;; =========add========
      i32.const 8
;; ====================
    call $~lib/rt/__increase_sp
  end
)
