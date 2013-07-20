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

### Instruction Encodings
<pre>
  mulop:3 addop:5 ra:6 rb:6 adda:3 addb:3 mula:3 mulb:3, op:4 packbits:8 addcc:3 mulcc:3 F:1 W:1 wa:6 wb:6
</pre>

