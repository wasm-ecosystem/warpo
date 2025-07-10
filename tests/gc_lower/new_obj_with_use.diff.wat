;; ====================
(func $tests/gc_lower/new_obj_with_use/_start (type $func.0 (func (result i32)))
  (local i32)
;; =========add========
  (local i32)
;; ====================
  block ;;i32
;; =========add========
      i32.const 4
    call $~lib/rt/__decrease_sp
      block ;;unreachable
;; ====================
              i32.const 0
            call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;    call $~lib/rt/__localtostack
;; =========add========
          call $~lib/rt/__tostack<0>
;; ====================
        local.set $0
;; =========add========
        block ;;unreachable
;; ====================
            local.get $0
;; =========add========
          local.set $1
            i32.const 4
          call $~lib/rt/__increase_sp
            local.get $1
;; ====================
          return
        end
;; =========add========
      end
    local.tee $1
      i32.const 4
    call $~lib/rt/__increase_sp
    local.get $1
  end
;; ====================
)
