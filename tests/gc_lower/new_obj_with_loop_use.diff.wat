;; ====================
(func $tests/gc_lower/new_obj_with_loop_use/_start (type $func.0 (func))
  (local i32)
  (local i32)
  block ;;none
;; =========add========
      i32.const 8
    call $~lib/rt/__decrease_sp
    block ;;none
;; ====================
          i32.const 0
;; ======remove=======
;;    call $~lib/rt/__localtostack
;; =========add========
        call $~lib/rt/__tostack<0>
;; ====================
      local.set $0
;; ======remove=======
;;  block ;;none
;; ====================
      loop ;;none
        if ;;none
          global.get $tests/gc_lower/new_obj_with_loop_use/v
          block ;;unreachable
                local.get $0
                i32.const 0
              i32.eq
            local.set $1
                  i32.const 0
                call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;            call $~lib/rt/__localtostack
;; =========add========
              call $~lib/rt/__tostack<4>
;; ====================
            local.set $0
            br $while-continue|0
          end
        end
      end
    end
;; =========add========
      i32.const 8
    call $~lib/rt/__increase_sp
;; ====================
  end
)
