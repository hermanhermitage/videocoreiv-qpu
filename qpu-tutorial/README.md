qpu-tutorial
============

**Preliminary**

### Samples:
Some sample QPU programs for getting started.

* [qpu-01.c](qpu-01.c) Almost empty program that signals completion.
* [qpu-02.c](qpu-02.c) VPM writes and transfer of VPM to memory (sdram).

### Assembler:

A basic assembler [qpuasm.js](qpuasm.js) written in javascript is described in [qpuasm.md](qpuasm.md).

### Glossary:

* QPU - 16 way SIMD with add and multiply floating point units.
* VPM - Vertex and Primitive Memory.  A 8192 byte buffer for each QPU.  Typically vertices would be processed here.

### QPU Overview:
 
Some names first - Let's call the entire SoC the GPU.  The GPU contains lots of functional units, but in particular the ARM processor, along with a dual core VPU with the 16-way SIMD integer vector unit, and the V3D pipeline containing 12 (?) QPUs processors, each of which is a 16-way SIMD floating point processor with separate floating point add and multiply units.
 
Let's focus on the QPUs here.  Whilst the QPUs share some aspects of the V3D, for the sake of simplicity lets imagine they are 12 fully independent processors going about their business.
 
- A QPU is a fairly simple processor configured for stream/vertex/fragment shading.
 
- To understand the machinery of the QPU, a useful picture to hold in your head is the image of a vertex shader program running to transform batches of 16 vertices in parallel.  Each vertex would correspond to a lane in the 16-way SIMD.  All processing is in lock step, so all control flow is shared.  For those who have not programmed shaders before, a shader is just a pure function shader(constants, vertex) returning a new vertex.  A vertex is an array of floats.  Typically the shader is invoked on many different vertices, but with the same set of constants.  These constants are also called uniforms. A typical execution plan is like follows:
  - The vertex stream is configured to load in blocks of 16
  - Load 16 vertices
  - Reset unifom pointer to point to start of uniforms
  - Process 16 vertices in parallel
    - Shared constants are accessed in sequence as needed (same value in each SIMD lane)
    - Vertex attributes are accessed in sequence as needed (different vertex and hence value in each SIMD lane).
  - More vertices remaining? loop back to second step (load).
 
On a QPU the constants are called uniforms, and the on chip high speed storage area for vertices is called VPM (vertex and primitive memory).
 
So what machinery does the QPU have to support this?
 
Exposed pipeline:
 - This essentially means the 
programmer must directly deal with branch delay slots (3), thread switch
 delays (2), and hazards and latencies.
 - Basically there is just an additional set of rules to follow to make your program work correctly.
 
Mutliple slots:
 - Each instruction typically has three slots that execute concurrently: add-operation, mul-operation and control operations.  eg:
```
add r0, r1, r2; fmul ra0, r2, r3; ldtmu0
```
Registers:  All registers are 32 bits wide, and 16 lanes wide.
- 4 Fast Registers (accumulators), supporting back to back read/writes. r0, r1, r2, r3.
- 32 bank A registers. ra0, ra1, ..., ra31.  These need a cycle delay between writing and reading the same register.
- 32 bank B registers. rb0, rb1, ..., rb31.  These need a cycle delay between writing and reading the same register.
- The fast and bank registers are there to strike a balance between performance, latency, power usage and instruction encoding size.
 
Peripheral/IO Registers:
 - The tightly coupled support units are accessed by the QPU using peripheral registers.
 - r4 is typically the result of a maths functional unit (log, exp, etc) or a texture fetch.
 - ra32...ra63 to access vpm, unif, etc...
 - ra32...ra64 to access vpm, unif, etc...
  eg. 
```
mov r0, unif  // load next uniform into r0
```

Predication:
  eg.
```
mov.nz r0, r1, r2 // r0 is only updated in those lanes with zero flag not set
bra.anyz ... // branch is taken if any lane z flag is set
bra.allz ... // branch is taken if all lane's z flag is set
```

Rotator (lane shift)
  - Allows inter-lane data access, eg.
```
mov r0, r1 << 8 // r0 = [r1:8, r1:9, ..., r1:7] // not to be confused with bit shift
```
Packer/Unpacker
  - Allow exchange of data between packed byte and float formats etc.
 
Memory Access:
 - No direct loads and stores to memory.
 
 - Random access reads via texture lookup
```
mov t0s, address 
...
  as many instructions as you can here to hide latency of up to 16 fetches
...
<addop>; <mulop> ; ldtmu0 // texture value available in r4 in next cycle
mov r0, r4  // texture/memory result returns via r4 = [ *address:0, *address:1, ..., *address:15 ]
```

 - Common (same value per SIMD lane) sequential reads via Uniforms.  eg
```
mov r0, unif  // u = *unif++; r0 = [u, u, ...., u ]
```
 - Individual (unique value per SIMD lane) sequential reads via VPM.
```
mov r0, vpm // r0 = [*(vpm + vertex_stride*0), ..., *(vpm+vertex_stride*15], vpm += attribute_step
```

 - Individual (unique value per SIMD lane) squential writes via VPM.
```
mov vpm, r0 // *(vpm + vertex_stride*0) = r0:0, ... *(vpm + vertex_stride*1) = r0:15, vpm += attribute_step 
```

  - VPM management is explicit.  That is, it is typically transferred to and from L2/SDRAM in blocks using DMA.  So a program typically DMAs data into VPM, processes it and writes new results to VPM, and then does a DMA transfer to place the result in L2/SDRAM.
 
  - Tile Buffer.  The other main method of memory access for rasterization and blending is the tile buffer.  By rendering the scene in tiles (locality), this saves round tripping through the memory hierarchy for framebuffer access.
 
