;; ====================
(func $tests/snapshot_diff/gc_lower_opt/immutable_global_to_stack_remover/mutable_global/_start)
  block ;;none
      i32.const 8
    call $~lib/rt/__decrease_sp
      block ;;i32
          global.get $~lib/memory/__stack_pointer
          global.get $tests/snapshot_diff/gc_lower_opt/immutable_global_to_stack_remover/mutable_global/a
        i32.store $0 align=1
        global.get $tests/snapshot_diff/gc_lower_opt/immutable_global_to_stack_remover/mutable_global/a
      end
      block ;;i32
          global.get $~lib/memory/__stack_pointer
          global.get $tests/snapshot_diff/gc_lower_opt/immutable_global_to_stack_remover/mutable_global/a
        i32.store $0 offset=4 align=1
        global.get $tests/snapshot_diff/gc_lower_opt/immutable_global_to_stack_remover/mutable_global/a
      end
    call $tests/snapshot_diff/gc_lower_opt/immutable_global_to_stack_remover/mutable_global/bar
      i32.const 8
    call $~lib/rt/__increase_sp
  end
)
