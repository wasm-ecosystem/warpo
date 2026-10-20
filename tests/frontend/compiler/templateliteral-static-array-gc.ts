// Poison freed payloads so premature collection becomes visible in the result.
// @ts-ignore: decorator
@global const ASC_GC_TESTING: i32 = 1;

// Use smaller allocation intervals and work budgets for incremental GC.
// @ts-ignore: decorator
@global const ASC_GC_GRANULARITY: usize = 64;

function main(): void {
  const radius: i32 = 5;
  for (let iteration = 0; iteration < 100; ++iteration) {
    const result = `Border Color: ${radius}, Area: ${radius}, Perimeter: ${radius}`;
    assert(result == "Border Color: 5, Area: 5, Perimeter: 5");
    if (iteration % 10 == 0) __collect();
  }
}

main();
