/*
Disassembly of Andrew Holme's QPU FFT for Raspberry Pi.
From: https://github.com/raspberrypi/firmware/tree/master/opt/vc/src/hello_pi/hello_fft
*/

/*
Copyright (c) 2013, Andrew Holme.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the copyright holder nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

shader_2k:
/* 00000000: 00000010 e0021727 */  ldi rb28, 0x00000010
/* 00000008: 00000040 e0021767 */  ldi rb29, 0x00000040
/* 00000010: 000000f0 e00217a7 */  ldi rb30, 0x000000f0
/* 00000018: 000001d0 e00217e7 */  ldi rb31, 0x000001d0
/* 00000020: 00005555 e0020727 */  ldi ra28, 0x00005555
/* 00000028: 00003333 e0020767 */  ldi ra29, 0x00003333
/* 00000030: 00000f0f e00207a7 */  ldi ra30, 0x00000f0f
/* 00000038: 000000ff e00207e7 */  ldi ra31, 0x000000ff
/* 00000040: 00000080 e00208e7 */  ldi r3, 0x00000080
/* 00000048: 15827d80 10020827 */  mov r0, unif
/* 00000050: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000058: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000060: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000068: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000070: 159e7900 100203e7 */  mov ra15, r4
/* 00000078: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000080: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000088: 159e7900 10020427 */  mov ra16, r4
/* 00000090: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000098: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000a0: 159e7900 10020467 */  mov ra17, r4
/* 000000a8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000b0: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000b8: 159e7900 100204a7 */  mov ra18, r4
/* 000000c0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000c8: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000d0: 159e7900 100204e7 */  mov ra19, r4
/* 000000d8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000e0: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000e8: 159e7900 10020527 */  mov ra20, r4
/* 000000f0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000f8: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000100: 159e7900 100213e7 */  mov rb15, r4
/* 00000108: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000110: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000118: 159e7900 10021427 */  mov rb16, r4
/* 00000120: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000128: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000130: 159e7900 10021467 */  mov rb17, r4
/* 00000138: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000140: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000148: 159e7900 100214a7 */  mov rb18, r4
/* 00000150: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000158: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000160: 159e7900 100214e7 */  mov rb19, r4
/* 00000168: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000170: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000178: 159e7900 10021527 */  mov rb20, r4
/* 00000180: 15827d80 10020827 */  mov r0, unif
/* 00000188: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000190: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000198: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000001a0: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000001a8: 159e7900 10020567 */  mov ra21, r4
/* 000001b0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000001b8: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000001c0: 159e7900 100205a7 */  mov ra22, r4
/* 000001c8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000001d0: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 000001d8: 159e7900 10021567 */  mov rb21, r4
/* 000001e0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000001e8: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 000001f0: 159e7900 100215a7 */  mov rb22, r4
/* 000001f8: 15827d80 10021167 */  mov rb5, unif
/* 00000200: 00101200 e0020827 */  ldi r0, 0x00101200
/* 00000208: 00000010 e0020867 */  ldi r1, 0x00000010
/* 00000210: 00000002 e00208a7 */  ldi r2, 0x00000002
/* 00000218: 409c5017 100049e2 */  nop; mul24 r2, r2, rb5
/* 00000220: cc9e7081 10025020 */  add rb0, r0, r2; v8adds r0, r0, r1
/* 00000228: cc9e7081 10025060 */  add rb1, r0, r2; v8adds r0, r0, r1
/* 00000230: cc9e7081 100250a0 */  add rb2, r0, r2; v8adds r0, r0, r1
/* 00000238: 0c9e7080 100211e7 */  add rb7, r0, r2
/* 00000240: 000000c8 f0f80127 */  brr ra4, +200 // 0x00000328
/* 00000248: 009e7000 100009e7 */  nop
/* 00000250: 009e7000 100009e7 */  nop
/* 00000258: 009e7000 100009e7 */  nop
/* 00000260: 152e7d80 10021c67 */  mov vw_setup, ra11
/* 00000268: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000270: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000278: 15327d80 10021c67 */  mov vw_setup, ra12
/* 00000280: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000288: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000290: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000298: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000002a0: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000002a8: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000002b0: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000002b8: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000002c0: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000002c8: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000002d0: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000002d8: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000002e0: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000002e8: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 000002f0: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000002f8: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000300: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000308: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000310: 15367d80 10021c67 */  mov vw_setup, ra13
/* 00000318: c00001c0 e0021c67 */  ldi vw_setup, 0xc00001c0
/* 00000320: 8c05ddf6 10024072 */  add ra1, ra1, rb29; mov vw_addr, ra1
/* 00000328: 00000050 f0f81127 */  brr rb4, +80 // 0x00000398
/* 00000330: 009e7000 100009e7 */  nop
/* 00000338: 009e7000 100009e7 */  nop
/* 00000340: 009e7000 100009e7 */  nop
/* 00000348: 152e7d80 10021c67 */  mov vw_setup, ra11
/* 00000350: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000358: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000360: 15327d80 10021c67 */  mov vw_setup, ra12
/* 00000368: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000370: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000378: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 00000380: 009e7000 100009e7 */  nop
/* 00000388: 152e7d80 10020c67 */  mov vr_setup, ra11
/* 00000390: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000398: 000000f8 f0f802a7 */  brr ra10, +248 // 0x000004b0
/* 000003a0: 009e7000 100009e7 */  nop
/* 000003a8: 009e7000 100009e7 */  nop
/* 000003b0: 009e7000 100009e7 */  nop
/* 000003b8: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 000003c0: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000003c8: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000003d0: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000003d8: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000003e0: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000003e8: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000003f0: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 000003f8: 159c0fc0 10021c67 */  mov vw_setup, rb0
/* 00000400: 012cbdc0 10020c27 */  fadd vpm, ra11, rb11
/* 00000408: 0130cdc0 10020c27 */  fadd vpm, ra12, rb12
/* 00000410: 159c1fc0 10021c67 */  mov vw_setup, rb1
/* 00000418: 0134ddc0 10020c27 */  fadd vpm, ra13, rb13
/* 00000420: 0138edc0 10020c27 */  fadd vpm, ra14, rb14
/* 00000428: 159c2fc0 10021c67 */  mov vw_setup, rb2
/* 00000430: 022cbdc0 10020c27 */  fsub vpm, ra11, rb11
/* 00000438: 0230cdc0 10020c27 */  fsub vpm, ra12, rb12
/* 00000440: 159c7fc0 10021c67 */  mov vw_setup, rb7
/* 00000448: 0234ddc0 10020c27 */  fsub vpm, ra13, rb13
/* 00000450: 0238edc0 10020c27 */  fsub vpm, ra14, rb14
/* 00000458: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000460: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000468: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000470: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000478: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000480: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000488: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000490: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000498: a0104000 e0021c67 */  ldi vw_setup, 0xa0104000
/* 000004a0: c00000c0 e0021c67 */  ldi vw_setup, 0xc00000c0
/* 000004a8: 8c05ddf6 10024072 */  add ra1, ra1, rb29; mov vw_addr, ra1
/* 000004b0: 000002b8 f0f812a7 */  brr rb10, +696 // 0x00000788
/* 000004b8: 009e7000 100009e7 */  nop
/* 000004c0: 009e7000 100009e7 */  nop
/* 000004c8: 009e7000 100009e7 */  nop
/* 000004d0: 159c5fc0 10020827 */  mov r0, rb5
/* 000004d8: 119c51c0 d00200a7 */  shl ra2, r0, 5; nop
/* 000004e0: 009e7000 100009e7 */  nop
/* 000004e8: 00000000 f0fc49e7 */  brr -, ra2+0
/* 000004f0: 009e7000 100009e7 */  nop
/* 000004f8: 009e7000 100009e7 */  nop
/* 00000500: 009e7000 100009e7 */  nop
/* 00000508: 000000e0 f0f809e7 */  brr -, +224 // 0x00000608
/* 00000510: 00000010 e80009e7 */  sacq.never -, 0x00000000
/* 00000518: 009e7000 100009e7 */  nop
/* 00000520: 009e7000 100009e7 */  nop
/* 00000528: 000000c0 f0f809e7 */  brr -, +192 // 0x00000608
/* 00000530: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 00000538: 009e7000 100009e7 */  nop
/* 00000540: 009e7000 100009e7 */  nop
/* 00000548: 000000a0 f0f809e7 */  brr -, +160 // 0x00000608
/* 00000550: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 00000558: 009e7000 100009e7 */  nop
/* 00000560: 009e7000 100009e7 */  nop
/* 00000568: 00000080 f0f809e7 */  brr -, +128 // 0x00000608
/* 00000570: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 00000578: 009e7000 100009e7 */  nop
/* 00000580: 009e7000 100009e7 */  nop
/* 00000588: 00000060 f0f809e7 */  brr -, +96 // 0x00000608
/* 00000590: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 00000598: 009e7000 100009e7 */  nop
/* 000005a0: 009e7000 100009e7 */  nop
/* 000005a8: 00000040 f0f809e7 */  brr -, +64 // 0x00000608
/* 000005b0: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 000005b8: 009e7000 100009e7 */  nop
/* 000005c0: 009e7000 100009e7 */  nop
/* 000005c8: 00000020 f0f809e7 */  brr -, +32 // 0x00000608
/* 000005d0: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 000005d8: 009e7000 100009e7 */  nop
/* 000005e0: 009e7000 100009e7 */  nop
/* 000005e8: 00000000 f0f809e7 */  brr -, +0 // 0x00000608
/* 000005f0: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 000005f8: 009e7000 100009e7 */  nop
/* 00000600: 009e7000 100009e7 */  nop
/* 00000608: 159c0fc0 10021c67 */  mov vw_setup, rb0
/* 00000610: 012cbdc0 10020c27 */  fadd vpm, ra11, rb11
/* 00000618: 0130cdc0 10020c27 */  fadd vpm, ra12, rb12
/* 00000620: 159c1fc0 10021c67 */  mov vw_setup, rb1
/* 00000628: 0134ddc0 10020c27 */  fadd vpm, ra13, rb13
/* 00000630: 0138edc0 10020c27 */  fadd vpm, ra14, rb14
/* 00000638: 159c2fc0 10021c67 */  mov vw_setup, rb2
/* 00000640: 022cbdc0 10020c27 */  fsub vpm, ra11, rb11
/* 00000648: 0230cdc0 10020c27 */  fsub vpm, ra12, rb12
/* 00000650: 159c7fc0 10021c67 */  mov vw_setup, rb7
/* 00000658: 0234ddc0 10020c27 */  fsub vpm, ra13, rb13
/* 00000660: 0238edc0 10020c27 */  fsub vpm, ra14, rb14
/* 00000668: 00000000 f0fc49e7 */  brr -, ra2+0
/* 00000670: 009e7000 100009e7 */  nop
/* 00000678: 009e7000 100009e7 */  nop
/* 00000680: 009e7000 100009e7 */  nop
/* 00000688: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000690: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000698: 15c27d80 100009e7 */  mov.never -, vpm
/* 000006a0: 00000008 e80009e7 */  srel.never -, 0x00000008
/* 000006a8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000006b0: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 000006b8: 15c27d80 100009e7 */  mov.never -, vpm
/* 000006c0: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 000006c8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000006d0: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 000006d8: 15c27d80 100009e7 */  mov.never -, vpm
/* 000006e0: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 000006e8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000006f0: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 000006f8: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000700: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 00000708: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000710: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000718: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000720: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 00000728: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000730: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000738: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000740: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 00000748: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000750: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000758: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000760: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 00000768: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000770: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000778: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000780: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 00000788: 00000080 f0f801a7 */  brr ra6, +128 // 0x00000828
/* 00000790: 009e7000 100009e7 */  nop
/* 00000798: 009e7000 100009e7 */  nop
/* 000007a0: 009e7000 100009e7 */  nop
/* 000007a8: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 000007b0: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000007b8: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000007c0: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000007c8: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000007d0: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000007d8: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000007e0: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000007e8: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000007f0: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000007f8: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000800: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000808: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000810: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000818: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000820: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000828: 00000858 f0f811a7 */  brr rb6, +2136 // 0x000010a0
/* 00000830: 009e7000 100009e7 */  nop
/* 00000838: 009e7000 100009e7 */  nop
/* 00000840: 009e7000 100009e7 */  nop
/* 00000848: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000850: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 00000858: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 00000860: 009e7000 100009e7 */  nop
/* 00000868: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000870: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 00000878: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 00000880: 009e7000 100009e7 */  nop
/* 00000888: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000890: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 00000898: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 000008a0: 009e7000 100009e7 */  nop
/* 000008a8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000008b0: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 000008b8: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 000008c0: 009e7000 100009e7 */  nop
/* 000008c8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000008d0: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 000008d8: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 000008e0: 009e7000 100009e7 */  nop
/* 000008e8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000008f0: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 000008f8: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 00000900: 009e7000 100009e7 */  nop
/* 00000908: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000910: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 00000918: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 00000920: 009e7000 100009e7 */  nop
/* 00000928: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000930: 20627030 1000d9c2 */  nop; fmul.zc ra2, ra24, r0
/* 00000938: 209d8039 1000c9e2 */  nop; fmul.zc r2, rb24, r1
/* 00000940: 22098cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb24, r0
/* 00000948: 20627031 1000c9e1 */  nop; fmul.zc r1, ra24, r1
/* 00000950: 819ff2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 15
/* 00000958: 819f1400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 1
/* 00000960: 829ff609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 15
/* 00000968: 819f1449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 1
/* 00000970: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000978: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000980: 20667030 1000d9c2 */  nop; fmul.zc ra2, ra25, r0
/* 00000988: 209d9039 1000c9e2 */  nop; fmul.zc r2, rb25, r1
/* 00000990: 22099cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb25, r0
/* 00000998: 20667031 1000c9e1 */  nop; fmul.zc r1, ra25, r1
/* 000009a0: 819fe2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 14
/* 000009a8: 819f2400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 2
/* 000009b0: 829fe609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 14
/* 000009b8: 819f2449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 2
/* 000009c0: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000009c8: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000009d0: 206a7030 1000d9c2 */  nop; fmul.zc ra2, ra26, r0
/* 000009d8: 209da039 1000c9e2 */  nop; fmul.zc r2, rb26, r1
/* 000009e0: 2209acb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb26, r0
/* 000009e8: 206a7031 1000c9e1 */  nop; fmul.zc r1, ra26, r1
/* 000009f0: 819fc2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 12
/* 000009f8: 819f4400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 4
/* 00000a00: 829fc609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 12
/* 00000a08: 819f4449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 4
/* 00000a10: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000a18: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000a20: 206e7030 1000d9c2 */  nop; fmul.zc ra2, ra27, r0
/* 00000a28: 209db039 1000c9e2 */  nop; fmul.zc r2, rb27, r1
/* 00000a30: 2209bcb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb27, r0
/* 00000a38: 206e7031 1000c9e1 */  nop; fmul.zc r1, ra27, r1
/* 00000a40: 819f82c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 8
/* 00000a48: 819f8400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 8
/* 00000a50: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000a58: 829f8609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 8
/* 00000a60: 819f8449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 8
/* 00000a68: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000a70: 8c15cdf6 10024160 */  add ra5, ra5, rb28; mov r0, ra5
/* 00000a78: 14727180 10020867 */  and r1, r0, ra28
/* 00000a80: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000a88: 14727180 10020827 */  and r0, r0, ra28
/* 00000a90: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000a98: 159e7040 10020827 */  or r0, r0, r1
/* 00000aa0: 14767180 10020867 */  and r1, r0, ra29
/* 00000aa8: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000ab0: 14767180 10020827 */  and r0, r0, ra29
/* 00000ab8: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000ac0: 159e7040 10020827 */  or r0, r0, r1
/* 00000ac8: 147a7180 10020867 */  and r1, r0, ra30
/* 00000ad0: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000ad8: 147a7180 10020827 */  and r0, r0, ra30
/* 00000ae0: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000ae8: 159e7040 10020827 */  or r0, r0, r1
/* 00000af0: 147e7180 10020867 */  and r1, r0, ra31
/* 00000af8: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000b00: 147e7180 10020827 */  and r0, r0, ra31
/* 00000b08: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000b10: 159e7040 10020827 */  or r0, r0, r1
/* 00000b18: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000b20: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000b28: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000b30: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000b38: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000b40: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000b48: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000b50: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000b58: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000b60: 159e7900 10020867 */  mov r1, r4
/* 00000b68: fffffda0 f0f80027 */  brr ra0, -608 // 0x00000928
/* 00000b70: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000b78: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000b80: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000b88: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000b90: 8c15cdf6 10024160 */  add ra5, ra5, rb28; mov r0, ra5
/* 00000b98: 14727180 10020867 */  and r1, r0, ra28
/* 00000ba0: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000ba8: 14727180 10020827 */  and r0, r0, ra28
/* 00000bb0: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000bb8: 159e7040 10020827 */  or r0, r0, r1
/* 00000bc0: 14767180 10020867 */  and r1, r0, ra29
/* 00000bc8: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000bd0: 14767180 10020827 */  and r0, r0, ra29
/* 00000bd8: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000be0: 159e7040 10020827 */  or r0, r0, r1
/* 00000be8: 147a7180 10020867 */  and r1, r0, ra30
/* 00000bf0: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000bf8: 147a7180 10020827 */  and r0, r0, ra30
/* 00000c00: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000c08: 159e7040 10020827 */  or r0, r0, r1
/* 00000c10: 147e7180 10020867 */  and r1, r0, ra31
/* 00000c18: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000c20: 147e7180 10020827 */  and r0, r0, ra31
/* 00000c28: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000c30: 159e7040 10020827 */  or r0, r0, r1
/* 00000c38: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000c40: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000c48: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000c50: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000c58: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000c60: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000c68: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000c70: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000c78: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000c80: 159e7900 10020867 */  mov r1, r4
/* 00000c88: fffffc80 f0f80027 */  brr ra0, -896 // 0x00000928
/* 00000c90: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000c98: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000ca0: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000ca8: 205e7006 100059c2 */  nop; fmul ra2, r0, ra23
/* 00000cb0: 209d700f 100049e2 */  nop; fmul r2, r1, rb23
/* 00000cb8: 205e700e 100049e3 */  nop; fmul r3, r1, ra23
/* 00000cc0: 22097c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb23
/* 00000cc8: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00000cd0: 01267c00 100202e7 */  fadd ra11, ra9, r0
/* 00000cd8: 019c9e40 10020327 */  fadd ra12, rb9, r1
/* 00000ce0: 02267c00 10020367 */  fsub ra13, ra9, r0
/* 00000ce8: 029c9e40 100203a7 */  fsub ra14, rb9, r1
/* 00000cf0: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 00000cf8: 14727180 10020867 */  and r1, r0, ra28
/* 00000d00: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000d08: 14727180 10020827 */  and r0, r0, ra28
/* 00000d10: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000d18: 159e7040 10020827 */  or r0, r0, r1
/* 00000d20: 14767180 10020867 */  and r1, r0, ra29
/* 00000d28: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000d30: 14767180 10020827 */  and r0, r0, ra29
/* 00000d38: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000d40: 159e7040 10020827 */  or r0, r0, r1
/* 00000d48: 147a7180 10020867 */  and r1, r0, ra30
/* 00000d50: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000d58: 147a7180 10020827 */  and r0, r0, ra30
/* 00000d60: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000d68: 159e7040 10020827 */  or r0, r0, r1
/* 00000d70: 147e7180 10020867 */  and r1, r0, ra31
/* 00000d78: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000d80: 147e7180 10020827 */  and r0, r0, ra31
/* 00000d88: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000d90: 159e7040 10020827 */  or r0, r0, r1
/* 00000d98: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000da0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000da8: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000db0: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000db8: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000dc0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000dc8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000dd0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000dd8: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000de0: 159e7900 10020867 */  mov r1, r4
/* 00000de8: fffffb20 f0f80027 */  brr ra0, -1248 // 0x00000928
/* 00000df0: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000df8: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000e00: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000e08: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000e10: 8c15cdf6 10024160 */  add ra5, ra5, rb28; mov r0, ra5
/* 00000e18: 14727180 10020867 */  and r1, r0, ra28
/* 00000e20: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000e28: 14727180 10020827 */  and r0, r0, ra28
/* 00000e30: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000e38: 159e7040 10020827 */  or r0, r0, r1
/* 00000e40: 14767180 10020867 */  and r1, r0, ra29
/* 00000e48: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000e50: 14767180 10020827 */  and r0, r0, ra29
/* 00000e58: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000e60: 159e7040 10020827 */  or r0, r0, r1
/* 00000e68: 147a7180 10020867 */  and r1, r0, ra30
/* 00000e70: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000e78: 147a7180 10020827 */  and r0, r0, ra30
/* 00000e80: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000e88: 159e7040 10020827 */  or r0, r0, r1
/* 00000e90: 147e7180 10020867 */  and r1, r0, ra31
/* 00000e98: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000ea0: 147e7180 10020827 */  and r0, r0, ra31
/* 00000ea8: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000eb0: 159e7040 10020827 */  or r0, r0, r1
/* 00000eb8: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000ec0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000ec8: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000ed0: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000ed8: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000ee0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000ee8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000ef0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000ef8: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000f00: 159e7900 10020867 */  mov r1, r4
/* 00000f08: fffffa00 f0f80027 */  brr ra0, -1536 // 0x00000928
/* 00000f10: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000f18: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000f20: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000f28: 205e7006 100059c2 */  nop; fmul ra2, r0, ra23
/* 00000f30: 209d700f 100049e2 */  nop; fmul r2, r1, rb23
/* 00000f38: 205e700e 100049e3 */  nop; fmul r3, r1, ra23
/* 00000f40: 22097c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb23
/* 00000f48: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00000f50: 029c9e40 100208e7 */  fsub r3, rb9, r1
/* 00000f58: 02267c00 100208a7 */  fsub r2, ra9, r0
/* 00000f60: 019c9e40 10020867 */  fadd r1, rb9, r1
/* 00000f68: 01267c00 10020827 */  fadd r0, ra9, r0
/* 00000f70: 203e700e 100049c9 */  nop; fmul rb9, r1, ra15
/* 00000f78: 209cf00f 100059c9 */  nop; fmul ra9, r1, rb15
/* 00000f80: 209cf007 100049e1 */  nop; fmul r1, r0, rb15
/* 00000f88: 213c93c6 10025320 */  fadd rb12, r1, rb9; fmul r0, r0, ra15
/* 00000f90: 2225019f 100252c9 */  fsub rb11, r0, ra9; fmul ra9, r3, rb16
/* 00000f98: 2042701e 100049c9 */  nop; fmul rb9, r3, ra16
/* 00000fa0: 00000000 f0f549e7 */  bra -, ra10+0
/* 00000fa8: 209d0017 100049e3 */  nop; fmul r3, r2, rb16
/* 00000fb0: 214097d6 100253a2 */  fadd rb14, r3, rb9; fmul r2, r2, ra16
/* 00000fb8: 02267580 10021367 */  fsub rb13, r2, ra9
/* 00000fc0: 8c15edf6 10024160 */  add ra5, ra5, rb30; mov r0, ra5
/* 00000fc8: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000fd0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000fd8: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000fe0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000fe8: fffff920 f0f80027 */  brr ra0, -1760 // 0x00000928
/* 00000ff0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000ff8: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00001000: 159e7900 10020867 */  mov r1, r4
/* 00001008: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00001010: 8c15cdf6 10024160 */  add ra5, ra5, rb28; mov r0, ra5
/* 00001018: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00001020: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00001028: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00001030: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00001038: fffff8d0 f0f80027 */  brr ra0, -1840 // 0x00000928
/* 00001040: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00001048: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00001050: 159e7900 10020867 */  mov r1, r4
/* 00001058: 205e7006 100059c2 */  nop; fmul ra2, r0, ra23
/* 00001060: 209d700f 100049e2 */  nop; fmul r2, r1, rb23
/* 00001068: 205e700e 100049e3 */  nop; fmul r3, r1, ra23
/* 00001070: 22097c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb23
/* 00001078: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00001080: 00000000 f0f489e7 */  bra -, ra4+0
/* 00001088: 952c2ff6 100242c2 */  mov ra11, rb2; mov rb2, ra11
/* 00001090: 95307ff6 10024307 */  mov ra12, rb7; mov rb7, ra12
/* 00001098: 9534dff6 1002434d */  mov ra13, rb13; mov rb13, ra13
/* 000010a0: 159c5fc0 10022827 */  mov.setf r0, rb5
/* 000010a8: 0d9c11c0 d0020827 */  sub r0, r0, 1; nop
/* 000010b0: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 000010b8: 0c9c6e00 100601a7 */  add.zc ra6, rb6, r0
/* 000010c0: 159c4fc0 10060127 */  mov.zc ra4, rb4
/* 000010c8: 159cafc0 100602a7 */  mov.zc ra10, rb10
/* 000010d0: 15827d80 100220e7 */  mov.setf ra3, unif
/* 000010d8: 15827d80 100210e7 */  mov rb3, unif
/* 000010e0: 00000418 f00809e7 */  brr.allz -, +1048 // 0x00001518
/* 000010e8: 95451dbf 100245d7 */  mov ra23, ra17; mov rb23, rb17
/* 000010f0: 95492dbf 100248a3 */  mov r2, ra18; mov r3, rb18
/* 000010f8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00001100: 959f8492 d002c6e2 */  mov ra27, r2; mov.zc r2, r2 >> 8
/* 00001108: 959f86db d002d6e3 */  mov rb27, r3; mov.zc r3, r3 >> 8
/* 00001110: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00001118: 959f4492 d002c6a2 */  mov ra26, r2; mov.zc r2, r2 >> 4
/* 00001120: 959f46db d002d6a3 */  mov rb26, r3; mov.zc r3, r3 >> 4
/* 00001128: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00001130: 959f2492 d002c662 */  mov ra25, r2; mov.zc r2, r2 >> 2
/* 00001138: 959f26db d002d663 */  mov rb25, r3; mov.zc r3, r3 >> 2
/* 00001140: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00001148: 959f1492 d002c622 */  mov ra24, r2; mov.zc r2, r2 >> 1
/* 00001150: 959f16db d002d623 */  mov rb24, r3; mov.zc r3, r3 >> 1
/* 00001158: 159c5fc0 10020827 */  mov r0, rb5
/* 00001160: 119c61c0 d0020827 */  shl r0, r0, 6; nop
/* 00001168: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00001170: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00001178: 159c3fc0 10020067 */  mov ra1, rb3
/* 00001180: 8c15cdf6 10024160 */  add ra5, ra5, rb28; mov r0, ra5
/* 00001188: 14727180 10020867 */  and r1, r0, ra28
/* 00001190: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00001198: 14727180 10020827 */  and r0, r0, ra28
/* 000011a0: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 000011a8: 159e7040 10020827 */  or r0, r0, r1
/* 000011b0: 14767180 10020867 */  and r1, r0, ra29
/* 000011b8: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 000011c0: 14767180 10020827 */  and r0, r0, ra29
/* 000011c8: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 000011d0: 159e7040 10020827 */  or r0, r0, r1
/* 000011d8: 147a7180 10020867 */  and r1, r0, ra30
/* 000011e0: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000011e8: 147a7180 10020827 */  and r0, r0, ra30
/* 000011f0: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 000011f8: 159e7040 10020827 */  or r0, r0, r1
/* 00001200: 147e7180 10020867 */  and r1, r0, ra31
/* 00001208: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00001210: 147e7180 10020827 */  and r0, r0, ra31
/* 00001218: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00001220: 159e7040 10020827 */  or r0, r0, r1
/* 00001228: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00001230: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00001238: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00001240: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00001248: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00001250: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00001258: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00001260: fffff7f0 f0f80227 */  brr ra8, -2064 // 0x00000a70
/* 00001268: 009e7000 100009e7 */  nop
/* 00001270: 00000200 e0020827 */  ldi r0, 0x00000200
/* 00001278: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 00001280: 0e1cbdc0 d00229e7 */  shr.setf -, ra7, 11; nop
/* 00001288: fffff7c8 f00809e7 */  brr.allz -, -2104 // 0x00000a70
/* 00001290: 009e7000 100009e7 */  nop
/* 00001298: 00000200 e0020827 */  ldi r0, 0x00000200
/* 000012a0: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 000012a8: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 000012b0: 009e7000 100009e7 */  nop
/* 000012b8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000012c0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000012c8: 159c0fc0 100202e7 */  mov ra11, rb0
/* 000012d0: 159c1fc0 10020327 */  mov ra12, rb1
/* 000012d8: 90104000 e0020367 */  ldi ra13, 0x90104000
/* 000012e0: 90105000 e0021367 */  ldi rb13, 0x90105000
/* 000012e8: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 000012f0: 95555dbf 100245d7 */  mov ra23, ra21; mov rb23, rb21
/* 000012f8: 95596dbf 100248a3 */  mov r2, ra22; mov r3, rb22
/* 00001300: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00001308: 959f8492 d002c6e2 */  mov ra27, r2; mov.zc r2, r2 >> 8
/* 00001310: 959f86db d002d6e3 */  mov rb27, r3; mov.zc r3, r3 >> 8
/* 00001318: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00001320: 959f4492 d002c6a2 */  mov ra26, r2; mov.zc r2, r2 >> 4
/* 00001328: 959f46db d002d6a3 */  mov rb26, r3; mov.zc r3, r3 >> 4
/* 00001330: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00001338: 959f2492 d002c662 */  mov ra25, r2; mov.zc r2, r2 >> 2
/* 00001340: 959f26db d002d663 */  mov rb25, r3; mov.zc r3, r3 >> 2
/* 00001348: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00001350: 959f1492 d002c622 */  mov ra24, r2; mov.zc r2, r2 >> 1
/* 00001358: 959f16db d002d623 */  mov rb24, r3; mov.zc r3, r3 >> 1
/* 00001360: 159c5fc0 10020827 */  mov r0, rb5
/* 00001368: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00001370: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00001378: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00001380: 159c3fc0 10020067 */  mov ra1, rb3
/* 00001388: 8c15cdf6 10024160 */  add ra5, ra5, rb28; mov r0, ra5
/* 00001390: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00001398: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000013a0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 000013a8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000013b0: fffffbf0 f0f80227 */  brr ra8, -1040 // 0x00000fc0
/* 000013b8: 009e7000 100009e7 */  nop
/* 000013c0: 00000100 e0020827 */  ldi r0, 0x00000100
/* 000013c8: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 000013d0: 955d7dbf 100248a3 */  mov r2, ra23; mov r3, rb23
/* 000013d8: 204e7016 100049e0 */  nop; fmul r0, r2, ra19
/* 000013e0: 209d3017 100049e1 */  nop; fmul r1, r2, rb19
/* 000013e8: 209d301f 100049e2 */  nop; fmul r2, r3, rb19
/* 000013f0: 214e709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra19
/* 000013f8: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00001400: 025e7c80 100205e7 */  fsub ra23, ra23, r2
/* 00001408: 029d7ec0 100215e7 */  fsub rb23, rb23, r3
/* 00001410: 956dbdbf 100248a3 */  mov r2, ra27; mov r3, rb27
/* 00001418: 20527016 100049e0 */  nop; fmul r0, r2, ra20
/* 00001420: 209d4017 100049e1 */  nop; fmul r1, r2, rb20
/* 00001428: 209d401f 100049e2 */  nop; fmul r2, r3, rb20
/* 00001430: 2152709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra20
/* 00001438: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00001440: 026e7c80 100208a7 */  fsub r2, ra27, r2
/* 00001448: 029dbec0 100208e7 */  fsub r3, rb27, r3
/* 00001450: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00001458: 959f8492 d002c6e2 */  mov ra27, r2; mov.zc r2, r2 >> 8
/* 00001460: 959f86db d002d6e3 */  mov rb27, r3; mov.zc r3, r3 >> 8
/* 00001468: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00001470: 959f4492 d002c6a2 */  mov ra26, r2; mov.zc r2, r2 >> 4
/* 00001478: 959f46db d002d6a3 */  mov rb26, r3; mov.zc r3, r3 >> 4
/* 00001480: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00001488: 959f2492 d002c662 */  mov ra25, r2; mov.zc r2, r2 >> 2
/* 00001490: 959f26db d002d663 */  mov rb25, r3; mov.zc r3, r3 >> 2
/* 00001498: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 000014a0: 959f1492 d002c622 */  mov ra24, r2; mov.zc r2, r2 >> 1
/* 000014a8: 959f16db d002d623 */  mov rb24, r3; mov.zc r3, r3 >> 1
/* 000014b0: 0e1cbdc0 d00229e7 */  shr.setf -, ra7, 11; nop
/* 000014b8: fffffae8 f00809e7 */  brr.allz -, -1304 // 0x00000fc0
/* 000014c0: 009e7000 100009e7 */  nop
/* 000014c8: 00000100 e0020827 */  ldi r0, 0x00000100
/* 000014d0: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 000014d8: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 000014e0: 009e7000 100009e7 */  nop
/* 000014e8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000014f0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000014f8: fffffbb8 f0f809e7 */  brr -, -1096 // 0x000010d0
/* 00001500: 009e7000 100009e7 */  nop
/* 00001508: 009e7000 100009e7 */  nop
/* 00001510: 009e7000 100009e7 */  nop
/* 00001518: 159c3fc0 100209a7 */  mov irq, rb3
/* 00001520: 009e7000 300009e7 */  nop; nop; thrend
/* 00001528: 009e7000 100009e7 */  nop
/* 00001530: 009e7000 100009e7 */  nop


