;; ====================
(func $tests/gc_leaf_filter/lifetime_with_collect/_start (type $func.0 (func (result i32)))
  (local i32)
  (local i32)
  block ;;i32
      i32.const 4
    call $~lib/rt/__decrease_sp
      block ;;unreachable
              i32.const 0
            call $tests/common_lib/normal/Normal#constructor
          call $~lib/rt/__tostack<0>
        local.set $0
        call $~lib/rt/itcms/__collect
        block ;;unreachable
            local.get $0
          local.set $1
            i32.const 4
          call $~lib/rt/__increase_sp
            local.get $1
          return
        end
      end
    local.tee $1
      i32.const 4
    call $~lib/rt/__increase_sp
    local.get $1
  end
)
