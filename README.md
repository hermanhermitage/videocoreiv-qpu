videocoreiv-qpu
===============

Fun and Games with the Videocoreiv Quad Processor Units

The BCM2835 SoC (System on a Chip) in the RaspberryPi has the following significant computation units:
- ARM1176JZF-S 700 MHz processor which acts as the "main" processor and typically runs Linux.
- Dualcore Videocore IV CPU @250MHz with SIMD Parallel Pixel Units (PPU) which runs scalar (integer and float) and vector (integer only) programs.
Runs ThreadX OS, and generally coordinates all functional blocks such as video codecs, power management, video out.
- Image Sensor Pipeline (ISP) providing lens shading, satistics and distortion correction.
- QPU units which provide 24 GFLOPS compute performance for coordinate, vertex and pixel shaders.

Let's focus on the QPU here.

<pre>
Disclaimer:

There is good precedent in Copyright Law for the following assumption:
- Given, an input I, with copyright holder C(I)
- a program or algorithm A with copyright holder C(A)
- a program output O, given by O=A(I)
that C(O) = C(I), given C(A) injects no artistic work during the operation of A().

We aim to feed different inputs into functions provided by the blob, and
document and analyse the outputs - without violating copyright law.

We will feed various inputs such as shader programs into the blob via entry
points (such as provided by OpenGL ES) and observe the outputs.

At all times we will obey:
  "This software may only be used for the purposes of developing for, 
    running or using a Raspberry Pi device."

as stipulated in the license: 
   https://github.com/raspberrypi/firmware/blob/master/boot/LICENCE.broadcom.
</pre>

### Key Patent Applications
+In recommended reading order:
* [US20110227920](http://www.google.com/patents/US20110227920)  Method and System for a Shader Processor With Closely Couple Peripherals
* [US20110154307](http://www.google.com/patents/US20110154307)  Method and System for Utilizing Data Flow Graphs to Compile Shaders
* [US20110148901](http://www.google.com/patents/US20110148901)  Method and System for Tile Mode Renderer With Coordinate Shader
* [US20110216069](http://www.google.com/patents/US20110216069)  Method and System for Compressing Tile Lists Used for 3d Rendering
* [US20110221743](http://www.google.com/patents/US20110221743)  Method and System for Controlling a 3d Processor Using a Control List in Memory
* [US20110242113](http://www.google.com/patents/US20110242113)  Method and System for Processing Pixels Utilizing Scoreboarding
* [US20110261059](http://www.google.com/patents/US20110261059)  Method and System for Decomposing Complex Shapes Into Curvy RHTS For Rasterization
* [US20080291208](http://www.google.com/patents/US20080291208)  Method and System for Processing Data Via a 3d Pipeline Coupled to a Generic Video Processing Unit 
  
### QPU Instruction Set
* Fixed length instruction word of 64 bits.
* Instructions contain multiple issue slots.
* There is a slot for the **Add vector ALU** and **Multiply vector ALU**.
* Registers written in one cycle, should not be read back for 1 instruction cycle.
* Branch instructions have 3 delay slots.
* Thread switching is handled by (cooperative) thread switch instructions.
* Program may be terminated by instruction with program end signal, two delay slots will be executed before the unit becomes idle.

### Instruction and Register Pipeline
![3d Pipeline](https://raw.github.com/wiki/hermanhermitage/videocoreiv/images/US20110148901/FIG4.png)

- Decoupled memory access operations are: reciprocal, reciprocal square root, logarithm and exponential (US20110227920-0078).
- Accumulators written in one cycle are available immediately in the next instruction (US20110227920-0092).
- Accumulators are a0...a4 or r0...r5 (here) (US20110227920-0094).
- The two register files have 32 registers each (US20110227920-0095), whilst the other 32 register addresses refer to peripheral IO.
- The rotator allows a vector to be rotated by any one of 16 horizontal rotations (US20110227920-0096).
- The unpackers can unpack register data, whilst the packers pack it (US20110227920-0097).
- Support for zero-extension of 8-bit data, sign extension of 16-bit data, convert 16-bit floats to 32-bit floats. (US20110227920-0099).
- Values written to registers (not accumulators) are not available in the next cycle (US20110227920-0103).
- Condition field allows conditional write back of ALU results (US20110227920-0104), and updating of condition flags is optional.
- 32-bit bit data may be written back to registers/accumulators as an alternative to ALU results (US20110227920-0105).
- Branches have 3-delay slots (no prediction), and may be conditional based on ALU flag bits.  Branches may provide link functionality.  (US20110227920-0106).
- Instructions may include a signalling field (US20110227920-0107) without costing an additional instruction.  Typical uses include tile buffer access, or end of program / thread switch (both with 2 delay slots).

### Instruction Encodings

#### Add/Mul Operations:
<pre>
  &lt;addop&gt;&lt;addcc&gt; wa, radda, raddb [setf] ; &lt;mulop&gt;&lt;mulcc&gt; wb, rmula, rmulb [setf] ; &lt;op&gt;
  &lt;addop&gt;&lt;addcc&gt; wb, radda, raddb [setf] ; &lt;mulop&gt;&lt;mulcc&gt; wa, rmula, rmulb [setf] ; &lt;op&gt;
  
  radda = ra | ra >> shift | imm6 | rb | r0..r5
  raddb = rb | ra >> shift | imm6 | rb | r0..r5
  rmula = ra | ra >> shift | imm6 | rb | r0..r5
  rmulb = rb | ra >> shift | imm6 | rb | r0..r5
</pre>

Encoding:
<pre>
  mulop:3 addop:5 ra:6 rb:6 adda:3 addb:3 mula:3 mulb:3, op:4 packbits:8 addcc:3 mulcc:3 F:1 X:1 wa:6 wb:6
</pre>

Where:
<pre>
  op is the signaling or control flow operation.

  mulop is the multiplication ALU operation.
  addop is the add ALU operation.
  
  adda, addb encode which accumulator or ra, rb value will be supplied to the add ALU.
  mula, mulb encode which accumulator or ra, rb value will be supplied to the multiplication ALU.
  
  packbits control the packing/unpacking operation.
  
  addcc holds the cc predicate for conditional execution of the add instruction.
  mulcc holds the cc predicate for conditional execution of the mul instruction.
    000 never
    001 always
    010 zero set
    011 zero clear
    100 negative set
    101 negative clear
    110 carry set
    111 carry clear
    
  F is set to update cc flags (there are Zero, Negative and Carry flags per unit) - SETF
  X is set to exchange values on the writeback (ie the crossed lines in the diagram).

  ra is register bank A value to read.
  rb is register bank V value to read.
  wa is destination for the add or mul result (depends on X).
  wb is destination for the add or mul result (depends on X).
    ra0..ra31 are registers, whilst ra32..ra63 are peripheral addresses.
    rb0..rb31 are registers, whilst rb32..rb63 are peripheral addresses.
    for wa, except addresses 32...35 write back to accumulators a0...a3
    for wb, except addresses 32...35 write back to accumulators a0...a3
</pre>

#### Branches:
<pre>
  # Branch absolute to addr+ra, optionally save return address to wa and/or wb.
  bra[&lt;cond&gt;] [wa|wb], addr[+ra]
  
  # Branch relative to pc+addr+ra, optionally save return address to wa and/or wb.
  brr[&lt;cond&gt;] [wa|wb], addr[+ra]
</pre>
Encoding:
<pre>
  addr:32, 1111 0000 cond:4 relative:1 register:1 ra:5 X:1 wa:6 wb:6
</pre>
Where:
<pre>
  addr is the target address

  cond is the condition code:
    0000 all zero set
    0001 all zero clear
    0010 any zero set
    0011 any zero clear
    0100 all negative set
    0101 all negative clear
    0110 any negative set
    0111 any negative clear
    1000 all carry set
    1001 all carry clear
    1010 any carry set
    1011 any carry clear
    xxxx unknown

  relative is set if the target is relative.
  register is set if the target should be addr + ra

  X, wa, wb are used to write the return address to a register
    (ie. branch and link).
</pre>


#### Move Immediate:
<pre>
  movi[&lt;addcc&gt;] wa, data [setf] ; movi[&lt;mulcc&gt;] wb, data [setf]
  movi[&lt;addcc&gt;] wb, data [setf] ; movi[&lt;mulcc&gt;] wa, data [setf]  
</pre>
Encoding:
<pre>
  data:32, 1110 unknown:8 addcc:3 mulcc:3 F:1 X:1 wa:6 wb:6
</pre>
Where:
<pre>
  data is constant to be loaded.
  addcc, mulcc, F, X, wa and wb as above.
</pre>
