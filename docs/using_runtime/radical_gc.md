# Radical GC runtime

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" />
  <img src="/stability/experimental.svg"  />
</p>

Radical Runtime is a lightweight garbage collection (GC) runtime with the following features:

- Stop-The-World (STW) Mechanism: Pauses execution during GC to ensure consistency.
- Two-Color Mark & Sweep (TCMS) Algorithm: Classifies objects as active (reachable) or inactive (unreachable) for efficient memory reclamation.
- Shadow Stack Integration: Dynamically tracks GC roots on the stack via a ["shadow stack"](/using_runtime/garbage_collection.md), eliminating the need for complex stack maps.

This design ensures determinism and simplicity in the GC process.

It is suitable for scenarios where application pause times are less sensitive, such as embedded systems or lightweight services prioritizing low runtime overhead over low-latency GC pauses.

## Performance

Radical runtime has higher throughput than incremental runtime. It uses TCMS algorithm and STW mechanism so that we don't need to insert the write barrier when update the field of class.

## Adjustable Parameters

`ASC_GC_GRANULARITY`<br/>
Once the total size of the allocated objects reaches `ASC_GC_GRANULARITY` bytes, a full garbage collection (GC) is triggered.<br/>
Increasing this parameter will use more ram but save the CPU time.<br/>
By default is 16 KiB (A quarter of WebAssembly page size).
