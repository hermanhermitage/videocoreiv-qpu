# Simple QPU Fragment Sniffer
Walks vcdbg relocs looking for OpenGL ES data, including QPU shader fragments.

### Building
Checkout the code and under a modern release of Rasbian:
<pre>
$ make
cc  -I/opt/vc/include/ -I/opt/vc/include/interface/vmcs_host/linux -I./ -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux  testgl.c -c
cc -std=c99  -L/opt/vc/lib/ -lGLESv2 -lEGL -lbcm_host -lvcos   qpu-sniff.c vcdbg_qpu.c testgl.o   -o qpu-sniff
</pre>

## Usage

### Shader Testing

Compiles a vertex and shader program and intercepts the generated QPU shaders.  Be careful not to have any other
OpenGL ES or VG programs running or you will pick up stray fragments.
<pre>
$ ./qpu-sniff --testgl vs/null.vs fs/null.fs

vs/null.vs:
void main(void) {
}


fs/null.fs:
void main(void) {
}

('shader code' 1c50a040 48)
00000000: 009e7000 100009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01
00000002: 009e7000 400009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op04
00000004: 15827d80 10020ba7 packbits=0x00; addop21<cc1> io46, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000006: 009e7000 300009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op03
00000008: 009e7000 100009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01
0000000a: 009e7000 500009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op05

('shader code' 1c50a0a0 104)
00000000: 15827d80 10120027 packbits=0x01; addop21<cc1> ra0, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000002: 15827d80 10220027 packbits=0x02; addop21<cc1> ra0, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000004: 15827d80 10021c67 packbits=0x00; addop21<cc1> io49, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000006: 15827d80 10020c27 packbits=0x00; addop21<cc1> io48, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000008: 15827d80 10020c27 packbits=0x00; addop21<cc1> io48, io32, io32; mulop00<cc0> io39, A0, A0; op01
0000000a: 15827d80 10020c27 packbits=0x00; addop21<cc1> io48, io32, io32; mulop00<cc0> io39, A0, A0; op01
0000000c: 15827d80 10020c27 packbits=0x00; addop21<cc1> io48, io32, io32; mulop00<cc0> io39, A0, A0; op01
0000000e: 95020dbf 10024c20 packbits=0x00; addop21<cc1> io48, ra0, ra0; mulop04<cc1> io32, io32, io32; op01
00000010: 01827c00 10020c27 packbits=0x00; addop01<cc1> io48, io32, A0; mulop00<cc0> io39, A0, A0; op01
00000012: 15827d80 10020c27 packbits=0x00; addop21<cc1> io48, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000014: 009e7000 300009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op03
00000016: 009e7000 100009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01
00000018: 009e7000 100009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01

('shader code' 1c50a1c0 72)
00000000: 15827d80 10120027 packbits=0x01; addop21<cc1> ra0, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000002: 15827d80 10220027 packbits=0x02; addop21<cc1> ra0, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000004: 15827d80 10021c67 packbits=0x00; addop21<cc1> io49, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000006: 95020dbf 10024c20 packbits=0x00; addop21<cc1> io48, ra0, ra0; mulop04<cc1> io32, io32, io32; op01
00000008: 01827c00 10020c27 packbits=0x00; addop01<cc1> io48, io32, A0; mulop00<cc0> io39, A0, A0; op01
0000000a: 15827d80 10020c27 packbits=0x00; addop21<cc1> io48, io32, io32; mulop00<cc0> io39, A0, A0; op01
0000000c: 009e7000 300009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op03
0000000e: 009e7000 100009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01
00000010: 009e7000 100009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01
</pre>

### Scan for Shaders from other Processes
In one terminal session:
<pre>
$ ./hello-triangle  # or any OpenGL application
# Leave OpenGL program active so programs, shaders, uniforms are static in memory.
</pre>
And then in another terminal session:
<pre>
$ ./qpu-sniff --qpuscan

...
type = 'GL20_PROGRAM_T.uniform_data'                                                                                                     
size = 20
.......? 00000000 3f800000          0          1                                                                                        
.......@ bf800000 40000000         -1          2                                         
...?.... 3f000000 8000000b        0.5 -1.541e-44     

...
'shader code':
00000000: 009e7000 100009e7 ra=39, rb=39, adda=0, addb=0, mula=0, mulb=0, wa=39, wb=39, F=0, X=0, packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01
00000002: 009e7000 400009e7 ra=39, rb=39, adda=0, addb=0, mula=0, mulb=0, wa=39, wb=39, F=0, X=0, packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op04
00000004: 15827d80 10020ba7 ra=32, rb=39, adda=6, addb=6, mula=0, mulb=0, wa=46, wb=39, F=0, X=0, packbits=0x00; addop21<cc1> io46, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000006: 009e7000 300009e7 ra=39, rb=39, adda=0, addb=0, mula=0, mulb=0, wa=39, wb=39, F=0, X=0, packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op03
00000008: 009e7000 100009e7 ra=39, rb=39, adda=0, addb=0, mula=0, mulb=0, wa=39, wb=39, F=0, X=0, packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01
0000000a: 009e7000 500009e7 ra=39, rb=39, adda=0, addb=0, mula=0, mulb=0, wa=39, wb=39, F=0, X=0, packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op05

...

</pre>

### Raw Memory Scanner
This scans SDRAM (excluding start.elf) for likely QPU fragments.
<pre>
$ sudo ./qpu-sniff --qpuscan-old

Scanning for QPU code fragments...
1dcc7c78: 009e7000 300009e7 009e7000 100009e7 009e7000 500009e7 00000000 00000000
1dcc7d80: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 00000000 00000000
1dcc7ef8: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 00000000 00000000
1e9c1888: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 009e7000 200009e7
1e9c24d0: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 00000000 00000000
1e9c2590: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 00000000 00000000
1e9c2768: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 80904780 e0021c67
1e9c2890: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 00000000 00000000
1e9c42f0: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 cc781dff d0024822
1e9c44c0: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 00100a00 e0020c67
1e9c53f8: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 15727d80 10021967
1e9c8608: 009e7000 300009e7 009e7000 100009e7 009e7000 100009e7 00100a00 e0020c67
</pre>

### Fragment Disassembly:
This disassembles a binary file.
<pre>
$ ./qpu-sniff --qpudis capture1/shader_code_1 

Disassembling capture1/shader_code_1
Fragment capture1/shader_code_1, size 24
00000000: 009e7000 100009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01
00000002: 009e7000 400009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op04
00000004: 15827d80 10020ba7 packbits=0x00; addop21<cc1> io46, io32, io32; mulop00<cc0> io39, A0, A0; op01
00000006: 009e7000 300009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op03
00000008: 009e7000 100009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op01
0000000a: 009e7000 500009e7 packbits=0x00; addop00<cc0> io39, A0, A0; mulop00<cc0> io39, A0, A0; op05
0000000c: 00000000 00000000 packbits=0x00; addop00<cc0> ra0, A0, A0; mulop00<cc0> rb0, A0, A0; op00
0000000e: 00000000 ffffffff data=0x00000000, unknown=0xff, addcc=7, mulcc=7, F=1, X=1, wa=63, wb=63
</pre>
