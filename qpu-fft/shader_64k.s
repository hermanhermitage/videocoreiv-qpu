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

shader_64k:
/* 00000000: 00000010 e0021227 */  ldi rb8, 0x00000010
/* 00000008: 000001d0 e0021967 */  ldi r5rep, 0x000001d0
/* 00000010: 00005555 e00207a7 */  ldi ra30, 0x00005555
/* 00000018: 00003333 e00217a7 */  ldi rb30, 0x00003333
/* 00000020: 00000f0f e00207e7 */  ldi ra31, 0x00000f0f
/* 00000028: 000000ff e00217e7 */  ldi rb31, 0x000000ff
/* 00000030: 00000080 e00208e7 */  ldi r3, 0x00000080
/* 00000038: 15827d80 10020827 */  mov r0, unif
/* 00000040: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000048: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000050: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000058: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000060: 159e7900 100203e7 */  mov ra15, r4
/* 00000068: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000070: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000078: 159e7900 10020427 */  mov ra16, r4
/* 00000080: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000088: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000090: 159e7900 10020467 */  mov ra17, r4
/* 00000098: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000a0: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000a8: 159e7900 100204a7 */  mov ra18, r4
/* 000000b0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000b8: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000c0: 159e7900 100204e7 */  mov ra19, r4
/* 000000c8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000d0: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000d8: 159e7900 10020527 */  mov ra20, r4
/* 000000e0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000e8: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000f0: 159e7900 10020567 */  mov ra21, r4
/* 000000f8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000100: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000108: 159e7900 100205a7 */  mov ra22, r4
/* 00000110: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000118: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000120: 159e7900 100213e7 */  mov rb15, r4
/* 00000128: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000130: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000138: 159e7900 10021427 */  mov rb16, r4
/* 00000140: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000148: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000150: 159e7900 10021467 */  mov rb17, r4
/* 00000158: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000160: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000168: 159e7900 100214a7 */  mov rb18, r4
/* 00000170: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000178: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000180: 159e7900 100214e7 */  mov rb19, r4
/* 00000188: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000190: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000198: 159e7900 10021527 */  mov rb20, r4
/* 000001a0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000001a8: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 000001b0: 159e7900 10021567 */  mov rb21, r4
/* 000001b8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000001c0: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 000001c8: 159e7900 100215a7 */  mov rb22, r4
/* 000001d0: 15827d80 10020827 */  mov r0, unif
/* 000001d8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000001e0: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 000001e8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000001f0: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000001f8: 159e7900 100205e7 */  mov ra23, r4
/* 00000200: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000208: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000210: 159e7900 10020627 */  mov ra24, r4
/* 00000218: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000220: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000228: 159e7900 100215e7 */  mov rb23, r4
/* 00000230: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000238: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000240: 159e7900 10021627 */  mov rb24, r4
/* 00000248: 15827d80 10021167 */  mov rb5, unif
/* 00000250: 00101200 e0020827 */  ldi r0, 0x00101200
/* 00000258: 00000010 e0020867 */  ldi r1, 0x00000010
/* 00000260: 00000002 e00208a7 */  ldi r2, 0x00000002
/* 00000268: 409c5017 100049e2 */  nop; mul24 r2, r2, rb5
/* 00000270: cc9e7081 10025020 */  add rb0, r0, r2; v8adds r0, r0, r1
/* 00000278: cc9e7081 10025060 */  add rb1, r0, r2; v8adds r0, r0, r1
/* 00000280: cc9e7081 100250a0 */  add rb2, r0, r2; v8adds r0, r0, r1
/* 00000288: 0c9e7080 100211e7 */  add rb7, r0, r2
/* 00000290: 000000c8 f0f80127 */  brr ra4, +200 // 0x00000378
/* 00000298: 009e7000 100009e7 */  nop
/* 000002a0: 009e7000 100009e7 */  nop
/* 000002a8: 009e7000 100009e7 */  nop
/* 000002b0: 152e7d80 10021c67 */  mov vw_setup, ra11
/* 000002b8: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 000002c0: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 000002c8: 15327d80 10021c67 */  mov vw_setup, ra12
/* 000002d0: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 000002d8: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 000002e0: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 000002e8: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000002f0: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000002f8: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000300: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000308: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000310: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000318: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000320: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000328: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000330: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000338: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000340: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000348: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000350: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000358: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000360: 153a7d80 10021c67 */  mov vw_setup, ra14
/* 00000368: c0003fc0 e0021c67 */  ldi vw_setup, 0xc0003fc0
/* 00000370: 8c04ddf6 10024072 */  add ra1, ra1, rb13; mov vw_addr, ra1
/* 00000378: 00000050 f0f81127 */  brr rb4, +80 // 0x000003e8
/* 00000380: 009e7000 100009e7 */  nop
/* 00000388: 009e7000 100009e7 */  nop
/* 00000390: 009e7000 100009e7 */  nop
/* 00000398: 152e7d80 10021c67 */  mov vw_setup, ra11
/* 000003a0: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 000003a8: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 000003b0: 15327d80 10021c67 */  mov vw_setup, ra12
/* 000003b8: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 000003c0: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 000003c8: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 000003d0: 009e7000 100009e7 */  nop
/* 000003d8: 152e7d80 10020c67 */  mov vr_setup, ra11
/* 000003e0: 15c27d80 100009e7 */  mov.never -, vpm
/* 000003e8: 00000100 f0f802a7 */  brr ra10, +256 // 0x00000508
/* 000003f0: 009e7000 100009e7 */  nop
/* 000003f8: 009e7000 100009e7 */  nop
/* 00000400: 009e7000 100009e7 */  nop
/* 00000408: 00000040 e0020827 */  ldi r0, 0x00000040
/* 00000410: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000418: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000420: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000428: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000430: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000438: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000440: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000448: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000450: 159c0fc0 10021c67 */  mov vw_setup, rb0
/* 00000458: 012cbdc0 10020c27 */  fadd vpm, ra11, rb11
/* 00000460: 0130cdc0 10020c27 */  fadd vpm, ra12, rb12
/* 00000468: 159c1fc0 10021c67 */  mov vw_setup, rb1
/* 00000470: 0134ddc0 10020c27 */  fadd vpm, ra13, rb13
/* 00000478: 0138edc0 10020c27 */  fadd vpm, ra14, rb14
/* 00000480: 159c2fc0 10021c67 */  mov vw_setup, rb2
/* 00000488: 022cbdc0 10020c27 */  fsub vpm, ra11, rb11
/* 00000490: 0230cdc0 10020c27 */  fsub vpm, ra12, rb12
/* 00000498: 159c7fc0 10021c67 */  mov vw_setup, rb7
/* 000004a0: 0234ddc0 10020c27 */  fsub vpm, ra13, rb13
/* 000004a8: 0238edc0 10020c27 */  fsub vpm, ra14, rb14
/* 000004b0: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000004b8: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000004c0: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000004c8: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000004d0: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000004d8: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 000004e0: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 000004e8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000004f0: a0104000 e0021c67 */  ldi vw_setup, 0xa0104000
/* 000004f8: c0001fc0 e0021c67 */  ldi vw_setup, 0xc0001fc0
/* 00000500: 8c067c36 10024072 */  add ra1, ra1, r0; mov vw_addr, ra1
/* 00000508: 000002b8 f0f812a7 */  brr rb10, +696 // 0x000007e0
/* 00000510: 009e7000 100009e7 */  nop
/* 00000518: 009e7000 100009e7 */  nop
/* 00000520: 009e7000 100009e7 */  nop
/* 00000528: 159c5fc0 10020827 */  mov r0, rb5
/* 00000530: 119c51c0 d00200a7 */  shl ra2, r0, 5; nop
/* 00000538: 009e7000 100009e7 */  nop
/* 00000540: 00000000 f0fc49e7 */  brr -, ra2+0
/* 00000548: 009e7000 100009e7 */  nop
/* 00000550: 009e7000 100009e7 */  nop
/* 00000558: 009e7000 100009e7 */  nop
/* 00000560: 000000e0 f0f809e7 */  brr -, +224 // 0x00000660
/* 00000568: 00000010 e80009e7 */  sacq.never -, 0x00000000
/* 00000570: 009e7000 100009e7 */  nop
/* 00000578: 009e7000 100009e7 */  nop
/* 00000580: 000000c0 f0f809e7 */  brr -, +192 // 0x00000660
/* 00000588: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 00000590: 009e7000 100009e7 */  nop
/* 00000598: 009e7000 100009e7 */  nop
/* 000005a0: 000000a0 f0f809e7 */  brr -, +160 // 0x00000660
/* 000005a8: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 000005b0: 009e7000 100009e7 */  nop
/* 000005b8: 009e7000 100009e7 */  nop
/* 000005c0: 00000080 f0f809e7 */  brr -, +128 // 0x00000660
/* 000005c8: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 000005d0: 009e7000 100009e7 */  nop
/* 000005d8: 009e7000 100009e7 */  nop
/* 000005e0: 00000060 f0f809e7 */  brr -, +96 // 0x00000660
/* 000005e8: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 000005f0: 009e7000 100009e7 */  nop
/* 000005f8: 009e7000 100009e7 */  nop
/* 00000600: 00000040 f0f809e7 */  brr -, +64 // 0x00000660
/* 00000608: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 00000610: 009e7000 100009e7 */  nop
/* 00000618: 009e7000 100009e7 */  nop
/* 00000620: 00000020 f0f809e7 */  brr -, +32 // 0x00000660
/* 00000628: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 00000630: 009e7000 100009e7 */  nop
/* 00000638: 009e7000 100009e7 */  nop
/* 00000640: 00000000 f0f809e7 */  brr -, +0 // 0x00000660
/* 00000648: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 00000650: 009e7000 100009e7 */  nop
/* 00000658: 009e7000 100009e7 */  nop
/* 00000660: 159c0fc0 10021c67 */  mov vw_setup, rb0
/* 00000668: 012cbdc0 10020c27 */  fadd vpm, ra11, rb11
/* 00000670: 0130cdc0 10020c27 */  fadd vpm, ra12, rb12
/* 00000678: 159c1fc0 10021c67 */  mov vw_setup, rb1
/* 00000680: 0134ddc0 10020c27 */  fadd vpm, ra13, rb13
/* 00000688: 0138edc0 10020c27 */  fadd vpm, ra14, rb14
/* 00000690: 159c2fc0 10021c67 */  mov vw_setup, rb2
/* 00000698: 022cbdc0 10020c27 */  fsub vpm, ra11, rb11
/* 000006a0: 0230cdc0 10020c27 */  fsub vpm, ra12, rb12
/* 000006a8: 159c7fc0 10021c67 */  mov vw_setup, rb7
/* 000006b0: 0234ddc0 10020c27 */  fsub vpm, ra13, rb13
/* 000006b8: 0238edc0 10020c27 */  fsub vpm, ra14, rb14
/* 000006c0: 00000000 f0fc49e7 */  brr -, ra2+0
/* 000006c8: 009e7000 100009e7 */  nop
/* 000006d0: 009e7000 100009e7 */  nop
/* 000006d8: 009e7000 100009e7 */  nop
/* 000006e0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000006e8: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 000006f0: 15c27d80 100009e7 */  mov.never -, vpm
/* 000006f8: 00000008 e80009e7 */  srel.never -, 0x00000008
/* 00000700: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000708: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000710: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000718: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 00000720: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000728: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000730: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000738: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 00000740: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000748: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000750: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000758: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 00000760: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000768: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000770: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000778: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 00000780: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000788: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 00000790: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000798: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 000007a0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000007a8: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 000007b0: 15c27d80 100009e7 */  mov.never -, vpm
/* 000007b8: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 000007c0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000007c8: 159c0fc0 10020c67 */  mov vr_setup, rb0
/* 000007d0: 15c27d80 100009e7 */  mov.never -, vpm
/* 000007d8: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 000007e0: 00000080 f0f801a7 */  brr ra6, +128 // 0x00000880
/* 000007e8: 009e7000 100009e7 */  nop
/* 000007f0: 009e7000 100009e7 */  nop
/* 000007f8: 009e7000 100009e7 */  nop
/* 00000800: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000808: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000810: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000818: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000820: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000828: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000830: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000838: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000840: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000848: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000850: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000858: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000860: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000868: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000870: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000878: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000880: 00000858 f0f811a7 */  brr rb6, +2136 // 0x000010f8
/* 00000888: 009e7000 100009e7 */  nop
/* 00000890: 009e7000 100009e7 */  nop
/* 00000898: 009e7000 100009e7 */  nop
/* 000008a0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000008a8: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 000008b0: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 000008b8: 009e7000 100009e7 */  nop
/* 000008c0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000008c8: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 000008d0: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 000008d8: 009e7000 100009e7 */  nop
/* 000008e0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000008e8: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 000008f0: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 000008f8: 009e7000 100009e7 */  nop
/* 00000900: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000908: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 00000910: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 00000918: 009e7000 100009e7 */  nop
/* 00000920: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000928: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 00000930: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 00000938: 009e7000 100009e7 */  nop
/* 00000940: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000948: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 00000950: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 00000958: 009e7000 100009e7 */  nop
/* 00000960: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000968: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 00000970: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 00000978: 009e7000 100009e7 */  nop
/* 00000980: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000988: 206a7030 1000d9c2 */  nop; fmul.zc ra2, ra26, r0
/* 00000990: 209da039 1000c9e2 */  nop; fmul.zc r2, rb26, r1
/* 00000998: 2209acb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb26, r0
/* 000009a0: 206a7031 1000c9e1 */  nop; fmul.zc r1, ra26, r1
/* 000009a8: 819ff2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 15
/* 000009b0: 819f1400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 1
/* 000009b8: 829ff609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 15
/* 000009c0: 819f1449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 1
/* 000009c8: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000009d0: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 000009d8: 206e7030 1000d9c2 */  nop; fmul.zc ra2, ra27, r0
/* 000009e0: 209db039 1000c9e2 */  nop; fmul.zc r2, rb27, r1
/* 000009e8: 2209bcb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb27, r0
/* 000009f0: 206e7031 1000c9e1 */  nop; fmul.zc r1, ra27, r1
/* 000009f8: 819fe2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 14
/* 00000a00: 819f2400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 2
/* 00000a08: 829fe609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 14
/* 00000a10: 819f2449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 2
/* 00000a18: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000a20: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000a28: 20727030 1000d9c2 */  nop; fmul.zc ra2, ra28, r0
/* 00000a30: 209dc039 1000c9e2 */  nop; fmul.zc r2, rb28, r1
/* 00000a38: 2209ccb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb28, r0
/* 00000a40: 20727031 1000c9e1 */  nop; fmul.zc r1, ra28, r1
/* 00000a48: 819fc2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 12
/* 00000a50: 819f4400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 4
/* 00000a58: 829fc609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 12
/* 00000a60: 819f4449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 4
/* 00000a68: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000a70: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000a78: 20767030 1000d9c2 */  nop; fmul.zc ra2, ra29, r0
/* 00000a80: 209dd039 1000c9e2 */  nop; fmul.zc r2, rb29, r1
/* 00000a88: 2209dcb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb29, r0
/* 00000a90: 20767031 1000c9e1 */  nop; fmul.zc r1, ra29, r1
/* 00000a98: 819f82c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 8
/* 00000aa0: 819f8400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 8
/* 00000aa8: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000ab0: 829f8609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 8
/* 00000ab8: 819f8449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 8
/* 00000ac0: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000ac8: 8c148df6 10024160 */  add ra5, ra5, rb8; mov r0, ra5
/* 00000ad0: 147a7180 10020867 */  and r1, r0, ra30
/* 00000ad8: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000ae0: 147a7180 10020827 */  and r0, r0, ra30
/* 00000ae8: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000af0: 159e7040 10020827 */  or r0, r0, r1
/* 00000af8: 149de1c0 10020867 */  and r1, r0, rb30
/* 00000b00: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000b08: 149de1c0 10020827 */  and r0, r0, rb30
/* 00000b10: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000b18: 159e7040 10020827 */  or r0, r0, r1
/* 00000b20: 147e7180 10020867 */  and r1, r0, ra31
/* 00000b28: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000b30: 147e7180 10020827 */  and r0, r0, ra31
/* 00000b38: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000b40: 159e7040 10020827 */  or r0, r0, r1
/* 00000b48: 149df1c0 10020867 */  and r1, r0, rb31
/* 00000b50: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000b58: 149df1c0 10020827 */  and r0, r0, rb31
/* 00000b60: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000b68: 159e7040 10020827 */  or r0, r0, r1
/* 00000b70: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000b78: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000b80: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000b88: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000b90: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000b98: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000ba0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000ba8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000bb0: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000bb8: 159e7900 10020867 */  mov r1, r4
/* 00000bc0: fffffda0 f0f80027 */  brr ra0, -608 // 0x00000980
/* 00000bc8: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000bd0: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000bd8: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000be0: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000be8: 8c148df6 10024160 */  add ra5, ra5, rb8; mov r0, ra5
/* 00000bf0: 147a7180 10020867 */  and r1, r0, ra30
/* 00000bf8: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000c00: 147a7180 10020827 */  and r0, r0, ra30
/* 00000c08: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000c10: 159e7040 10020827 */  or r0, r0, r1
/* 00000c18: 149de1c0 10020867 */  and r1, r0, rb30
/* 00000c20: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000c28: 149de1c0 10020827 */  and r0, r0, rb30
/* 00000c30: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000c38: 159e7040 10020827 */  or r0, r0, r1
/* 00000c40: 147e7180 10020867 */  and r1, r0, ra31
/* 00000c48: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000c50: 147e7180 10020827 */  and r0, r0, ra31
/* 00000c58: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000c60: 159e7040 10020827 */  or r0, r0, r1
/* 00000c68: 149df1c0 10020867 */  and r1, r0, rb31
/* 00000c70: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000c78: 149df1c0 10020827 */  and r0, r0, rb31
/* 00000c80: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000c88: 159e7040 10020827 */  or r0, r0, r1
/* 00000c90: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000c98: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000ca0: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000ca8: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000cb0: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000cb8: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000cc0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000cc8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000cd0: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000cd8: 159e7900 10020867 */  mov r1, r4
/* 00000ce0: fffffc80 f0f80027 */  brr ra0, -896 // 0x00000980
/* 00000ce8: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000cf0: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000cf8: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000d00: 20667006 100059c2 */  nop; fmul ra2, r0, ra25
/* 00000d08: 209d900f 100049e2 */  nop; fmul r2, r1, rb25
/* 00000d10: 2066700e 100049e3 */  nop; fmul r3, r1, ra25
/* 00000d18: 22099c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb25
/* 00000d20: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00000d28: 01267c00 100202e7 */  fadd ra11, ra9, r0
/* 00000d30: 019c9e40 10020327 */  fadd ra12, rb9, r1
/* 00000d38: 02267c00 10020367 */  fsub ra13, ra9, r0
/* 00000d40: 029c9e40 100203a7 */  fsub ra14, rb9, r1
/* 00000d48: 8c167d76 10024160 */  add ra5, ra5, r5; mov r0, ra5
/* 00000d50: 147a7180 10020867 */  and r1, r0, ra30
/* 00000d58: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000d60: 147a7180 10020827 */  and r0, r0, ra30
/* 00000d68: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000d70: 159e7040 10020827 */  or r0, r0, r1
/* 00000d78: 149de1c0 10020867 */  and r1, r0, rb30
/* 00000d80: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000d88: 149de1c0 10020827 */  and r0, r0, rb30
/* 00000d90: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000d98: 159e7040 10020827 */  or r0, r0, r1
/* 00000da0: 147e7180 10020867 */  and r1, r0, ra31
/* 00000da8: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000db0: 147e7180 10020827 */  and r0, r0, ra31
/* 00000db8: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000dc0: 159e7040 10020827 */  or r0, r0, r1
/* 00000dc8: 149df1c0 10020867 */  and r1, r0, rb31
/* 00000dd0: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000dd8: 149df1c0 10020827 */  and r0, r0, rb31
/* 00000de0: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000de8: 159e7040 10020827 */  or r0, r0, r1
/* 00000df0: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000df8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000e00: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000e08: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000e10: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000e18: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000e20: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000e28: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000e30: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000e38: 159e7900 10020867 */  mov r1, r4
/* 00000e40: fffffb20 f0f80027 */  brr ra0, -1248 // 0x00000980
/* 00000e48: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000e50: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000e58: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000e60: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000e68: 8c148df6 10024160 */  add ra5, ra5, rb8; mov r0, ra5
/* 00000e70: 147a7180 10020867 */  and r1, r0, ra30
/* 00000e78: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000e80: 147a7180 10020827 */  and r0, r0, ra30
/* 00000e88: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000e90: 159e7040 10020827 */  or r0, r0, r1
/* 00000e98: 149de1c0 10020867 */  and r1, r0, rb30
/* 00000ea0: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000ea8: 149de1c0 10020827 */  and r0, r0, rb30
/* 00000eb0: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000eb8: 159e7040 10020827 */  or r0, r0, r1
/* 00000ec0: 147e7180 10020867 */  and r1, r0, ra31
/* 00000ec8: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000ed0: 147e7180 10020827 */  and r0, r0, ra31
/* 00000ed8: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000ee0: 159e7040 10020827 */  or r0, r0, r1
/* 00000ee8: 149df1c0 10020867 */  and r1, r0, rb31
/* 00000ef0: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000ef8: 149df1c0 10020827 */  and r0, r0, rb31
/* 00000f00: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000f08: 159e7040 10020827 */  or r0, r0, r1
/* 00000f10: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000f18: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000f20: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000f28: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000f30: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000f38: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000f40: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000f48: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000f50: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000f58: 159e7900 10020867 */  mov r1, r4
/* 00000f60: fffffa00 f0f80027 */  brr ra0, -1536 // 0x00000980
/* 00000f68: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000f70: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000f78: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000f80: 20667006 100059c2 */  nop; fmul ra2, r0, ra25
/* 00000f88: 209d900f 100049e2 */  nop; fmul r2, r1, rb25
/* 00000f90: 2066700e 100049e3 */  nop; fmul r3, r1, ra25
/* 00000f98: 22099c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb25
/* 00000fa0: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00000fa8: 029c9e40 100208e7 */  fsub r3, rb9, r1
/* 00000fb0: 02267c00 100208a7 */  fsub r2, ra9, r0
/* 00000fb8: 019c9e40 10020867 */  fadd r1, rb9, r1
/* 00000fc0: 01267c00 10020827 */  fadd r0, ra9, r0
/* 00000fc8: 203e700e 100049c9 */  nop; fmul rb9, r1, ra15
/* 00000fd0: 209cf00f 100059c9 */  nop; fmul ra9, r1, rb15
/* 00000fd8: 209cf007 100049e1 */  nop; fmul r1, r0, rb15
/* 00000fe0: 213c93c6 10025320 */  fadd rb12, r1, rb9; fmul r0, r0, ra15
/* 00000fe8: 2225019f 100252c9 */  fsub rb11, r0, ra9; fmul ra9, r3, rb16
/* 00000ff0: 2042701e 100049c9 */  nop; fmul rb9, r3, ra16
/* 00000ff8: 00000000 f0f549e7 */  bra -, ra10+0
/* 00001000: 209d0017 100049e3 */  nop; fmul r3, r2, rb16
/* 00001008: 214097d6 100253a2 */  fadd rb14, r3, rb9; fmul r2, r2, ra16
/* 00001010: 02267580 10021367 */  fsub rb13, r2, ra9
/* 00001018: 8c14cdf6 10024160 */  add ra5, ra5, rb12; mov r0, ra5
/* 00001020: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00001028: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00001030: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00001038: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00001040: fffff920 f0f80027 */  brr ra0, -1760 // 0x00000980
/* 00001048: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00001050: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00001058: 159e7900 10020867 */  mov r1, r4
/* 00001060: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00001068: 8c148df6 10024160 */  add ra5, ra5, rb8; mov r0, ra5
/* 00001070: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00001078: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00001080: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00001088: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00001090: fffff8d0 f0f80027 */  brr ra0, -1840 // 0x00000980
/* 00001098: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000010a0: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 000010a8: 159e7900 10020867 */  mov r1, r4
/* 000010b0: 20667006 100059c2 */  nop; fmul ra2, r0, ra25
/* 000010b8: 209d900f 100049e2 */  nop; fmul r2, r1, rb25
/* 000010c0: 2066700e 100049e3 */  nop; fmul r3, r1, ra25
/* 000010c8: 22099c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb25
/* 000010d0: 019e72c0 10020867 */  fadd r1, r1, r3
/* 000010d8: 00000000 f0f489e7 */  bra -, ra4+0
/* 000010e0: 952c2ff6 100242c2 */  mov ra11, rb2; mov rb2, ra11
/* 000010e8: 95307ff6 10024307 */  mov ra12, rb7; mov rb7, ra12
/* 000010f0: 9538eff6 1002438e */  mov ra14, rb14; mov rb14, ra14
/* 000010f8: 159c5fc0 10022827 */  mov.setf r0, rb5
/* 00001100: 0d9c11c0 d0020827 */  sub r0, r0, 1; nop
/* 00001108: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00001110: 0c9c6e00 100601a7 */  add.zc ra6, rb6, r0
/* 00001118: 159c4fc0 10060127 */  mov.zc ra4, rb4
/* 00001120: 159cafc0 100602a7 */  mov.zc ra10, rb10
/* 00001128: 15827d80 100220e7 */  mov.setf ra3, unif
/* 00001130: 15827d80 100210e7 */  mov rb3, unif
/* 00001138: 000006a8 f00809e7 */  brr.allz -, +1704 // 0x00001800
/* 00001140: 95451dbf 10024659 */  mov ra25, ra17; mov rb25, rb17
/* 00001148: 95492dbf 100248a3 */  mov r2, ra18; mov r3, rb18
/* 00001150: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00001158: 959f8492 d002c762 */  mov ra29, r2; mov.zc r2, r2 >> 8
/* 00001160: 959f86db d002d763 */  mov rb29, r3; mov.zc r3, r3 >> 8
/* 00001168: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00001170: 959f4492 d002c722 */  mov ra28, r2; mov.zc r2, r2 >> 4
/* 00001178: 959f46db d002d723 */  mov rb28, r3; mov.zc r3, r3 >> 4
/* 00001180: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00001188: 959f2492 d002c6e2 */  mov ra27, r2; mov.zc r2, r2 >> 2
/* 00001190: 959f26db d002d6e3 */  mov rb27, r3; mov.zc r3, r3 >> 2
/* 00001198: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 000011a0: 959f1492 d002c6a2 */  mov ra26, r2; mov.zc r2, r2 >> 1
/* 000011a8: 959f16db d002d6a3 */  mov rb26, r3; mov.zc r3, r3 >> 1
/* 000011b0: 159c5fc0 10020827 */  mov r0, rb5
/* 000011b8: 119c61c0 d0020827 */  shl r0, r0, 6; nop
/* 000011c0: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 000011c8: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 000011d0: 159c3fc0 10020067 */  mov ra1, rb3
/* 000011d8: 8c148df6 10024160 */  add ra5, ra5, rb8; mov r0, ra5
/* 000011e0: 147a7180 10020867 */  and r1, r0, ra30
/* 000011e8: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 000011f0: 147a7180 10020827 */  and r0, r0, ra30
/* 000011f8: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00001200: 159e7040 10020827 */  or r0, r0, r1
/* 00001208: 149de1c0 10020867 */  and r1, r0, rb30
/* 00001210: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00001218: 149de1c0 10020827 */  and r0, r0, rb30
/* 00001220: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00001228: 159e7040 10020827 */  or r0, r0, r1
/* 00001230: 147e7180 10020867 */  and r1, r0, ra31
/* 00001238: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00001240: 147e7180 10020827 */  and r0, r0, ra31
/* 00001248: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00001250: 159e7040 10020827 */  or r0, r0, r1
/* 00001258: 149df1c0 10020867 */  and r1, r0, rb31
/* 00001260: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00001268: 149df1c0 10020827 */  and r0, r0, rb31
/* 00001270: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00001278: 159e7040 10020827 */  or r0, r0, r1
/* 00001280: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00001288: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00001290: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00001298: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 000012a0: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 000012a8: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 000012b0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000012b8: fffff7f0 f0f80227 */  brr ra8, -2064 // 0x00000ac8
/* 000012c0: 009e7000 100009e7 */  nop
/* 000012c8: 00000200 e0020827 */  ldi r0, 0x00000200
/* 000012d0: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 000012d8: 00000010 e0020867 */  ldi r1, 0x00000010
/* 000012e0: 0e1e7c40 100229e7 */  shr.setf -, ra7, r1
/* 000012e8: fffff7c0 f00809e7 */  brr.allz -, -2112 // 0x00000ac8
/* 000012f0: 009e7000 100009e7 */  nop
/* 000012f8: 00000200 e0020827 */  ldi r0, 0x00000200
/* 00001300: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 00001308: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00001310: 009e7000 100009e7 */  nop
/* 00001318: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00001320: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00001328: 159c0fc0 100202e7 */  mov ra11, rb0
/* 00001330: 159c1fc0 10020327 */  mov ra12, rb1
/* 00001338: 90104000 e00203a7 */  ldi ra14, 0x90104000
/* 00001340: 90105000 e00213a7 */  ldi rb14, 0x90105000
/* 00001348: 00000060 e00212e7 */  ldi rb11, 0x00000060
/* 00001350: 000000f0 e0021327 */  ldi rb12, 0x000000f0
/* 00001358: 00000040 e0021367 */  ldi rb13, 0x00000040
/* 00001360: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00001368: 95451dbf 10024659 */  mov ra25, ra17; mov rb25, rb17
/* 00001370: 95492dbf 100248a3 */  mov r2, ra18; mov r3, rb18
/* 00001378: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00001380: 959f8492 d002c762 */  mov ra29, r2; mov.zc r2, r2 >> 8
/* 00001388: 959f86db d002d763 */  mov rb29, r3; mov.zc r3, r3 >> 8
/* 00001390: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00001398: 959f4492 d002c722 */  mov ra28, r2; mov.zc r2, r2 >> 4
/* 000013a0: 959f46db d002d723 */  mov rb28, r3; mov.zc r3, r3 >> 4
/* 000013a8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 000013b0: 959f2492 d002c6e2 */  mov ra27, r2; mov.zc r2, r2 >> 2
/* 000013b8: 959f26db d002d6e3 */  mov rb27, r3; mov.zc r3, r3 >> 2
/* 000013c0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 000013c8: 959f1492 d002c6a2 */  mov ra26, r2; mov.zc r2, r2 >> 1
/* 000013d0: 959f16db d002d6a3 */  mov rb26, r3; mov.zc r3, r3 >> 1
/* 000013d8: 159c5fc0 10020827 */  mov r0, rb5
/* 000013e0: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 000013e8: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 000013f0: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 000013f8: 159c3fc0 10020067 */  mov ra1, rb3
/* 00001400: 8c148df6 10024160 */  add ra5, ra5, rb8; mov r0, ra5
/* 00001408: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00001410: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00001418: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00001420: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00001428: fffffbd0 f0f80227 */  brr ra8, -1072 // 0x00001018
/* 00001430: 009e7000 100009e7 */  nop
/* 00001438: 00000100 e0020827 */  ldi r0, 0x00000100
/* 00001440: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 00001448: fffffbb0 f0f80227 */  brr ra8, -1104 // 0x00001018
/* 00001450: 009e7000 100009e7 */  nop
/* 00001458: 00000100 e0020827 */  ldi r0, 0x00000100
/* 00001460: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 00001468: fffffb90 f0f80227 */  brr ra8, -1136 // 0x00001018
/* 00001470: 009e7000 100009e7 */  nop
/* 00001478: 00000100 e0020827 */  ldi r0, 0x00000100
/* 00001480: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 00001488: fffffb70 f0f80227 */  brr ra8, -1168 // 0x00001018
/* 00001490: 009e7000 100009e7 */  nop
/* 00001498: 00000100 e0020827 */  ldi r0, 0x00000100
/* 000014a0: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 000014a8: 95659dbf 100248a3 */  mov r2, ra25; mov r3, rb25
/* 000014b0: 204e7016 100049e0 */  nop; fmul r0, r2, ra19
/* 000014b8: 209d3017 100049e1 */  nop; fmul r1, r2, rb19
/* 000014c0: 209d301f 100049e2 */  nop; fmul r2, r3, rb19
/* 000014c8: 214e709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra19
/* 000014d0: 029e7640 100208e7 */  fsub r3, r3, r1
/* 000014d8: 02667c80 10020667 */  fsub ra25, ra25, r2
/* 000014e0: 029d9ec0 10021667 */  fsub rb25, rb25, r3
/* 000014e8: 9575ddbf 100248a3 */  mov r2, ra29; mov r3, rb29
/* 000014f0: 20527016 100049e0 */  nop; fmul r0, r2, ra20
/* 000014f8: 209d4017 100049e1 */  nop; fmul r1, r2, rb20
/* 00001500: 209d401f 100049e2 */  nop; fmul r2, r3, rb20
/* 00001508: 2152709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra20
/* 00001510: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00001518: 02767c80 100208a7 */  fsub r2, ra29, r2
/* 00001520: 029ddec0 100208e7 */  fsub r3, rb29, r3
/* 00001528: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00001530: 959f8492 d002c762 */  mov ra29, r2; mov.zc r2, r2 >> 8
/* 00001538: 959f86db d002d763 */  mov rb29, r3; mov.zc r3, r3 >> 8
/* 00001540: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00001548: 959f4492 d002c722 */  mov ra28, r2; mov.zc r2, r2 >> 4
/* 00001550: 959f46db d002d723 */  mov rb28, r3; mov.zc r3, r3 >> 4
/* 00001558: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00001560: 959f2492 d002c6e2 */  mov ra27, r2; mov.zc r2, r2 >> 2
/* 00001568: 959f26db d002d6e3 */  mov rb27, r3; mov.zc r3, r3 >> 2
/* 00001570: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00001578: 959f1492 d002c6a2 */  mov ra26, r2; mov.zc r2, r2 >> 1
/* 00001580: 959f16db d002d6a3 */  mov rb26, r3; mov.zc r3, r3 >> 1
/* 00001588: 0e1c8dc0 100229e7 */  shr.setf -, ra7, rb8
/* 00001590: fffffa68 f00809e7 */  brr.allz -, -1432 // 0x00001018
/* 00001598: 00000100 e0020827 */  ldi r0, 0x00000100
/* 000015a0: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 000015a8: 0d20bdc0 10020227 */  sub ra8, ra8, rb11
/* 000015b0: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 000015b8: 009e7000 100009e7 */  nop
/* 000015c0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000015c8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000015d0: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 000015d8: 955d7dbf 10024659 */  mov ra25, ra23; mov rb25, rb23
/* 000015e0: 95618dbf 100248a3 */  mov r2, ra24; mov r3, rb24
/* 000015e8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000015f0: 959f8492 d002c762 */  mov ra29, r2; mov.zc r2, r2 >> 8
/* 000015f8: 959f86db d002d763 */  mov rb29, r3; mov.zc r3, r3 >> 8
/* 00001600: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00001608: 959f4492 d002c722 */  mov ra28, r2; mov.zc r2, r2 >> 4
/* 00001610: 959f46db d002d723 */  mov rb28, r3; mov.zc r3, r3 >> 4
/* 00001618: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00001620: 959f2492 d002c6e2 */  mov ra27, r2; mov.zc r2, r2 >> 2
/* 00001628: 959f26db d002d6e3 */  mov rb27, r3; mov.zc r3, r3 >> 2
/* 00001630: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00001638: 959f1492 d002c6a2 */  mov ra26, r2; mov.zc r2, r2 >> 1
/* 00001640: 959f16db d002d6a3 */  mov rb26, r3; mov.zc r3, r3 >> 1
/* 00001648: 159c5fc0 10020827 */  mov r0, rb5
/* 00001650: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00001658: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00001660: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00001668: 159c3fc0 10020067 */  mov ra1, rb3
/* 00001670: 8c148df6 10024160 */  add ra5, ra5, rb8; mov r0, ra5
/* 00001678: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00001680: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00001688: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00001690: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00001698: fffff960 f0f80227 */  brr ra8, -1696 // 0x00001018
/* 000016a0: 009e7000 100009e7 */  nop
/* 000016a8: 00000100 e0020827 */  ldi r0, 0x00000100
/* 000016b0: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 000016b8: 95659dbf 100248a3 */  mov r2, ra25; mov r3, rb25
/* 000016c0: 20567016 100049e0 */  nop; fmul r0, r2, ra21
/* 000016c8: 209d5017 100049e1 */  nop; fmul r1, r2, rb21
/* 000016d0: 209d501f 100049e2 */  nop; fmul r2, r3, rb21
/* 000016d8: 2156709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra21
/* 000016e0: 029e7640 100208e7 */  fsub r3, r3, r1
/* 000016e8: 02667c80 10020667 */  fsub ra25, ra25, r2
/* 000016f0: 029d9ec0 10021667 */  fsub rb25, rb25, r3
/* 000016f8: 9575ddbf 100248a3 */  mov r2, ra29; mov r3, rb29
/* 00001700: 205a7016 100049e0 */  nop; fmul r0, r2, ra22
/* 00001708: 209d6017 100049e1 */  nop; fmul r1, r2, rb22
/* 00001710: 209d601f 100049e2 */  nop; fmul r2, r3, rb22
/* 00001718: 215a709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra22
/* 00001720: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00001728: 02767c80 100208a7 */  fsub r2, ra29, r2
/* 00001730: 029ddec0 100208e7 */  fsub r3, rb29, r3
/* 00001738: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00001740: 959f8492 d002c762 */  mov ra29, r2; mov.zc r2, r2 >> 8
/* 00001748: 959f86db d002d763 */  mov rb29, r3; mov.zc r3, r3 >> 8
/* 00001750: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00001758: 959f4492 d002c722 */  mov ra28, r2; mov.zc r2, r2 >> 4
/* 00001760: 959f46db d002d723 */  mov rb28, r3; mov.zc r3, r3 >> 4
/* 00001768: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00001770: 959f2492 d002c6e2 */  mov ra27, r2; mov.zc r2, r2 >> 2
/* 00001778: 959f26db d002d6e3 */  mov rb27, r3; mov.zc r3, r3 >> 2
/* 00001780: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00001788: 959f1492 d002c6a2 */  mov ra26, r2; mov.zc r2, r2 >> 1
/* 00001790: 959f16db d002d6a3 */  mov rb26, r3; mov.zc r3, r3 >> 1
/* 00001798: 0e1c8dc0 100229e7 */  shr.setf -, ra7, rb8
/* 000017a0: fffff858 f00809e7 */  brr.allz -, -1960 // 0x00001018
/* 000017a8: 009e7000 100009e7 */  nop
/* 000017b0: 00000100 e0020827 */  ldi r0, 0x00000100
/* 000017b8: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 000017c0: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 000017c8: 009e7000 100009e7 */  nop
/* 000017d0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000017d8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000017e0: fffff928 f0f809e7 */  brr -, -1752 // 0x00001128
/* 000017e8: 009e7000 100009e7 */  nop
/* 000017f0: 009e7000 100009e7 */  nop
/* 000017f8: 009e7000 100009e7 */  nop
/* 00001800: 159c3fc0 100209a7 */  mov irq, rb3
/* 00001808: 009e7000 300009e7 */  nop; nop; thrend
/* 00001810: 009e7000 100009e7 */  nop
/* 00001818: 009e7000 100009e7 */  nop


