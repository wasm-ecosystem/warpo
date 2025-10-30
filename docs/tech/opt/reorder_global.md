### Concept

GC.\_\_stack_pointer fetched by `global.get`, normally `global.get 0`.

But in warp, global stored in memory which means this high-frequency operation will frequently read and write memory, which is inefficient.  
So, if warpo can reorder the most used global to index 0 -> in warp, global 0 can be optimized to store in a register.
