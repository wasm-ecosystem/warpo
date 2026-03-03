;; ====================
(func $tests/snapshot_diff/gc_lower_opt/base/new_obj_with_return/_start (result i32))
;; =========add========
  (local i32)
  (local i32)
  block ;;i32
;; ====================
      i32.const 4
;; =========add========
    call $~lib/rt/__decrease_sp
      block ;;unreachable
            block ;;i32
;; ====================
                  i32.const 4
;; =========add========
                  i32.const 4
;; ====================
                call $~lib/rt/itcms/__new
;; ======remove=======
;;    call $~lib/rt/__tmptostack
;; =========add========
              local.set $1
                global.get $~lib/memory/__stack_pointer
                local.get $1
              i32.store $0 align=1
              local.get $1
            end
;; ====================
          call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; =========add========
        local.set $0
          i32.const 4
        call $~lib/rt/__increase_sp
          local.get $0
;; ====================
        return
;; =========add========
      end
    local.tee $0
      i32.const 4
    call $~lib/rt/__increase_sp
    local.get $0
  end
;; ====================
)
