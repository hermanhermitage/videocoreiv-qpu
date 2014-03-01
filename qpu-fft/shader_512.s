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

shader_512:
/* 00000000: 00000010 e0021727 */  ldi rb28, 0x00000010
/* 00000008: 00000040 e0021767 */  ldi rb29, 0x00000040
/* 00000010: 00000080 e00217a7 */  ldi rb30, 0x00000080
/* 00000018: 000000f0 e00217e7 */  ldi rb31, 0x000000f0
/* 00000020: 00005555 e0020727 */  ldi ra28, 0x00005555
/* 00000028: 00003333 e0020767 */  ldi ra29, 0x00003333
/* 00000030: 00000f0f e00207a7 */  ldi ra30, 0x00000f0f
/* 00000038: 000000ff e00207e7 */  ldi ra31, 0x000000ff
/* 00000040: 88104000 e00206a7 */  ldi ra26, 0x88104000
/* 00000048: 88105000 e0021027 */  ldi rb0, 0x88105000
/* 00000050: 90104000 e00206e7 */  ldi ra27, 0x90104000
/* 00000058: 90105000 e0021067 */  ldi rb1, 0x90105000
/* 00000060: 15827d80 10020827 */  mov r0, unif
/* 00000068: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000070: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000078: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000080: 0c9de1c0 a0020827 */  add r0, r0, rb30; nop; ldtmu0
/* 00000088: 159e7900 100202e7 */  mov ra11, r4
/* 00000090: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000098: 0c9de1c0 a0020827 */  add r0, r0, rb30; nop; ldtmu0
/* 000000a0: 159e7900 10020327 */  mov ra12, r4
/* 000000a8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000b0: 0c9de1c0 a0020827 */  add r0, r0, rb30; nop; ldtmu0
/* 000000b8: 159e7900 10020367 */  mov ra13, r4
/* 000000c0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000c8: 0c9de3c0 a0020867 */  add r1, r1, rb30; nop; ldtmu0
/* 000000d0: 159e7900 100212e7 */  mov rb11, r4
/* 000000d8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000e0: 0c9de3c0 a0020867 */  add r1, r1, rb30; nop; ldtmu0
/* 000000e8: 159e7900 10021327 */  mov rb12, r4
/* 000000f0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000f8: 0c9de3c0 a0020867 */  add r1, r1, rb30; nop; ldtmu0
/* 00000100: 159e7900 10021367 */  mov rb13, r4
/* 00000108: 15827d80 10020827 */  mov r0, unif
/* 00000110: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000118: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000120: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000128: 0c9de1c0 a0020827 */  add r0, r0, rb30; nop; ldtmu0
/* 00000130: 159e7900 100203a7 */  mov ra14, r4
/* 00000138: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000140: 0c9de3c0 a0020867 */  add r1, r1, rb30; nop; ldtmu0
/* 00000148: 159e7900 100213a7 */  mov rb14, r4
/* 00000150: 15827d80 10021167 */  mov rb5, unif
/* 00000158: 00101200 e0020827 */  ldi r0, 0x00101200
/* 00000160: 00000010 e0020867 */  ldi r1, 0x00000010
/* 00000168: 00000002 e00208a7 */  ldi r2, 0x00000002
/* 00000170: 409c5017 100049e2 */  nop; mul24 r2, r2, rb5
/* 00000178: cc9e7081 10024620 */  add ra24, r0, r2; v8adds r0, r0, r1
/* 00000180: cc9e7081 10024660 */  add ra25, r0, r2; v8adds r0, r0, r1
/* 00000188: cc9e7081 100250a0 */  add rb2, r0, r2; v8adds r0, r0, r1
/* 00000190: 0c9e7080 100211e7 */  add rb7, r0, r2
/* 00000198: 000000b0 f0f80127 */  brr ra4, +176 // 0x00000268
/* 000001a0: 009e7000 100009e7 */  nop
/* 000001a8: 009e7000 100009e7 */  nop
/* 000001b0: 009e7000 100009e7 */  nop
/* 000001b8: 15627d80 10021c67 */  mov vw_setup, ra24
/* 000001c0: 159e7000 10020c27 */  mov vpm, r0
/* 000001c8: 159e7240 10020c27 */  mov vpm, r1
/* 000001d0: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 000001d8: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000001e0: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000001e8: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000001f0: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000001f8: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000200: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000208: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000210: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000218: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000220: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000228: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000230: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000238: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000240: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000248: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000250: 156a7d80 10021c67 */  mov vw_setup, ra26
/* 00000258: c00000c0 e0021c67 */  ldi vw_setup, 0xc00000c0
/* 00000260: 8c05ddf6 10024072 */  add ra1, ra1, rb29; mov vw_addr, ra1
/* 00000268: 00000038 f0f81127 */  brr rb4, +56 // 0x000002c0
/* 00000270: 009e7000 100009e7 */  nop
/* 00000278: 009e7000 100009e7 */  nop
/* 00000280: 009e7000 100009e7 */  nop
/* 00000288: 15627d80 10021c67 */  mov vw_setup, ra24
/* 00000290: 159e7000 10020c27 */  mov vpm, r0
/* 00000298: 159e7240 10020c27 */  mov vpm, r1
/* 000002a0: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 000002a8: 009e7000 100009e7 */  nop
/* 000002b0: 15627d80 10020c67 */  mov vr_setup, ra24
/* 000002b8: 15c27d80 100009e7 */  mov.never -, vpm
/* 000002c0: 000000c8 f0f802a7 */  brr ra10, +200 // 0x000003a8
/* 000002c8: 009e7000 100009e7 */  nop
/* 000002d0: 009e7000 100009e7 */  nop
/* 000002d8: 009e7000 100009e7 */  nop
/* 000002e0: 15627d80 10021c67 */  mov vw_setup, ra24
/* 000002e8: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 000002f0: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 000002f8: 15667d80 10021c67 */  mov vw_setup, ra25
/* 00000300: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000308: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000310: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000318: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000320: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000328: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000330: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000338: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000340: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000348: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000350: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000358: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000360: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000368: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000370: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000378: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000380: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000388: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000390: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 00000398: c0000040 e0021c67 */  ldi vw_setup, 0xc0000040
/* 000003a0: 8c05ddf6 10024072 */  add ra1, ra1, rb29; mov vw_addr, ra1
/* 000003a8: 00000050 f0f812a7 */  brr rb10, +80 // 0x00000418
/* 000003b0: 009e7000 100009e7 */  nop
/* 000003b8: 009e7000 100009e7 */  nop
/* 000003c0: 009e7000 100009e7 */  nop
/* 000003c8: 15627d80 10021c67 */  mov vw_setup, ra24
/* 000003d0: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 000003d8: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 000003e0: 15667d80 10021c67 */  mov vw_setup, ra25
/* 000003e8: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 000003f0: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 000003f8: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 00000400: 009e7000 100009e7 */  nop
/* 00000408: 15627d80 10020c67 */  mov vr_setup, ra24
/* 00000410: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000418: 00000080 f0f801a7 */  brr ra6, +128 // 0x000004b8
/* 00000420: 009e7000 100009e7 */  nop
/* 00000428: 009e7000 100009e7 */  nop
/* 00000430: 009e7000 100009e7 */  nop
/* 00000438: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000440: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000448: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000450: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000458: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000460: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000468: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000470: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000478: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000480: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000488: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000490: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000498: 00000000 f0f509e7 */  bra -, ra8+0
/* 000004a0: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000004a8: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 000004b0: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 000004b8: 00000510 f0f811a7 */  brr rb6, +1296 // 0x000009e8
/* 000004c0: 009e7000 100009e7 */  nop
/* 000004c8: 009e7000 100009e7 */  nop
/* 000004d0: 009e7000 100009e7 */  nop
/* 000004d8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000004e0: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 000004e8: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 000004f0: 009e7000 100009e7 */  nop
/* 000004f8: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000500: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 00000508: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 00000510: 009e7000 100009e7 */  nop
/* 00000518: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000520: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 00000528: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 00000530: 009e7000 100009e7 */  nop
/* 00000538: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000540: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 00000548: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 00000550: 009e7000 100009e7 */  nop
/* 00000558: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000560: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 00000568: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 00000570: 009e7000 100009e7 */  nop
/* 00000578: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000580: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 00000588: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 00000590: 009e7000 100009e7 */  nop
/* 00000598: 00000000 f0f509e7 */  bra -, ra8+0
/* 000005a0: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 000005a8: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 000005b0: 009e7000 100009e7 */  nop
/* 000005b8: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 000005c0: 20427030 1000d9c2 */  nop; fmul.zc ra2, ra16, r0
/* 000005c8: 209d0039 1000c9e2 */  nop; fmul.zc r2, rb16, r1
/* 000005d0: 22090cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb16, r0
/* 000005d8: 20427031 1000c9e1 */  nop; fmul.zc r1, ra16, r1
/* 000005e0: 819ff2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 15
/* 000005e8: 819f1400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 1
/* 000005f0: 829ff609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 15
/* 000005f8: 819f1449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 1
/* 00000600: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000608: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000610: 20467030 1000d9c2 */  nop; fmul.zc ra2, ra17, r0
/* 00000618: 209d1039 1000c9e2 */  nop; fmul.zc r2, rb17, r1
/* 00000620: 22091cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb17, r0
/* 00000628: 20467031 1000c9e1 */  nop; fmul.zc r1, ra17, r1
/* 00000630: 819fe2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 14
/* 00000638: 819f2400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 2
/* 00000640: 829fe609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 14
/* 00000648: 819f2449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 2
/* 00000650: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000658: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000660: 204a7030 1000d9c2 */  nop; fmul.zc ra2, ra18, r0
/* 00000668: 209d2039 1000c9e2 */  nop; fmul.zc r2, rb18, r1
/* 00000670: 22092cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb18, r0
/* 00000678: 204a7031 1000c9e1 */  nop; fmul.zc r1, ra18, r1
/* 00000680: 819fc2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 12
/* 00000688: 819f4400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 4
/* 00000690: 829fc609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 12
/* 00000698: 819f4449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 4
/* 000006a0: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000006a8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000006b0: 204e7030 1000d9c2 */  nop; fmul.zc ra2, ra19, r0
/* 000006b8: 209d3039 1000c9e2 */  nop; fmul.zc r2, rb19, r1
/* 000006c0: 22093cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb19, r0
/* 000006c8: 204e7031 1000c9e1 */  nop; fmul.zc r1, ra19, r1
/* 000006d0: 819f82c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 8
/* 000006d8: 819f8400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 8
/* 000006e0: 00000000 f0f409e7 */  bra -, ra0+0
/* 000006e8: 829f8609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 8
/* 000006f0: 819f8449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 8
/* 000006f8: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000700: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 00000708: 14727180 10020867 */  and r1, r0, ra28
/* 00000710: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000718: 14727180 10020827 */  and r0, r0, ra28
/* 00000720: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000728: 159e7040 10020827 */  or r0, r0, r1
/* 00000730: 14767180 10020867 */  and r1, r0, ra29
/* 00000738: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000740: 14767180 10020827 */  and r0, r0, ra29
/* 00000748: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000750: 159e7040 10020827 */  or r0, r0, r1
/* 00000758: 147a7180 10020867 */  and r1, r0, ra30
/* 00000760: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000768: 147a7180 10020827 */  and r0, r0, ra30
/* 00000770: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000778: 159e7040 10020827 */  or r0, r0, r1
/* 00000780: 147e7180 10020867 */  and r1, r0, ra31
/* 00000788: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000790: 147e7180 10020827 */  and r0, r0, ra31
/* 00000798: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 000007a0: 159e7040 10020827 */  or r0, r0, r1
/* 000007a8: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000007b0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000007b8: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 000007c0: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 000007c8: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 000007d0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 000007d8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000007e0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000007e8: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 000007f0: 159e7900 10020867 */  mov r1, r4
/* 000007f8: fffffda0 f0f80027 */  brr ra0, -608 // 0x000005b8
/* 00000800: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000808: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000810: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000818: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000820: 8c15cdf6 10024160 */  add ra5, ra5, rb28; mov r0, ra5
/* 00000828: 14727180 10020867 */  and r1, r0, ra28
/* 00000830: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000838: 14727180 10020827 */  and r0, r0, ra28
/* 00000840: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000848: 159e7040 10020827 */  or r0, r0, r1
/* 00000850: 14767180 10020867 */  and r1, r0, ra29
/* 00000858: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000860: 14767180 10020827 */  and r0, r0, ra29
/* 00000868: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000870: 159e7040 10020827 */  or r0, r0, r1
/* 00000878: 147a7180 10020867 */  and r1, r0, ra30
/* 00000880: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000888: 147a7180 10020827 */  and r0, r0, ra30
/* 00000890: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000898: 159e7040 10020827 */  or r0, r0, r1
/* 000008a0: 147e7180 10020867 */  and r1, r0, ra31
/* 000008a8: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 000008b0: 147e7180 10020827 */  and r0, r0, ra31
/* 000008b8: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 000008c0: 159e7040 10020827 */  or r0, r0, r1
/* 000008c8: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000008d0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000008d8: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 000008e0: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 000008e8: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 000008f0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 000008f8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000900: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000908: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000910: 159e7900 10020867 */  mov r1, r4
/* 00000918: fffffc80 f0f80027 */  brr ra0, -896 // 0x000005b8
/* 00000920: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000928: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000930: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000938: 203e7006 100059c2 */  nop; fmul ra2, r0, ra15
/* 00000940: 209cf00f 100049e2 */  nop; fmul r2, r1, rb15
/* 00000948: 203e700e 100049e3 */  nop; fmul r3, r1, ra15
/* 00000950: 2208fc87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb15
/* 00000958: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00000960: 00000000 f0f549e7 */  bra -, ra10+0
/* 00000968: 95602ff6 10024602 */  mov ra24, rb2; mov rb2, ra24
/* 00000970: 95647ff6 10024647 */  mov ra25, rb7; mov rb7, ra25
/* 00000978: 956c1ff6 100246c1 */  mov ra27, rb1; mov rb1, ra27
/* 00000980: 8c15edf6 10024160 */  add ra5, ra5, rb30; mov r0, ra5
/* 00000988: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000990: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000998: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 000009a0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000009a8: fffffbf0 f0f80027 */  brr ra0, -1040 // 0x000005b8
/* 000009b0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000009b8: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 000009c0: 159e7900 10020867 */  mov r1, r4
/* 000009c8: 00000000 f0f489e7 */  bra -, ra4+0
/* 000009d0: 009e7000 100009e7 */  nop
/* 000009d8: 95602ff6 10024602 */  mov ra24, rb2; mov rb2, ra24
/* 000009e0: 95680ff6 10024680 */  mov ra26, rb0; mov rb0, ra26
/* 000009e8: 159c5fc0 10022827 */  mov.setf r0, rb5
/* 000009f0: 0d9c11c0 d0020827 */  sub r0, r0, 1; nop
/* 000009f8: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000a00: 0c9c6e00 100601a7 */  add.zc ra6, rb6, r0
/* 00000a08: 159c4fc0 10060127 */  mov.zc ra4, rb4
/* 00000a10: 159cafc0 100602a7 */  mov.zc ra10, rb10
/* 00000a18: 15827d80 100220e7 */  mov.setf ra3, unif
/* 00000a20: 15827d80 100210e7 */  mov rb3, unif
/* 00000a28: 000003a8 f00809e7 */  brr.allz -, +936 // 0x00000df0
/* 00000a30: 952cbdbf 100243cf */  mov ra15, ra11; mov rb15, rb11
/* 00000a38: 9530cdbf 100248a3 */  mov r2, ra12; mov r3, rb12
/* 00000a40: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000a48: 959f8492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 8
/* 00000a50: 959f86db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 8
/* 00000a58: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000a60: 959f4492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 4
/* 00000a68: 959f46db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 4
/* 00000a70: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000a78: 959f2492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 2
/* 00000a80: 959f26db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 2
/* 00000a88: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000a90: 959f1492 d002c422 */  mov ra16, r2; mov.zc r2, r2 >> 1
/* 00000a98: 959f16db d002d423 */  mov rb16, r3; mov.zc r3, r3 >> 1
/* 00000aa0: 159c5fc0 10020827 */  mov r0, rb5
/* 00000aa8: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000ab0: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000ab8: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000ac0: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000ac8: 8c15cdf6 10024160 */  add ra5, ra5, rb28; mov r0, ra5
/* 00000ad0: 14727180 10020867 */  and r1, r0, ra28
/* 00000ad8: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000ae0: 14727180 10020827 */  and r0, r0, ra28
/* 00000ae8: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000af0: 159e7040 10020827 */  or r0, r0, r1
/* 00000af8: 14767180 10020867 */  and r1, r0, ra29
/* 00000b00: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000b08: 14767180 10020827 */  and r0, r0, ra29
/* 00000b10: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000b18: 159e7040 10020827 */  or r0, r0, r1
/* 00000b20: 147a7180 10020867 */  and r1, r0, ra30
/* 00000b28: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000b30: 147a7180 10020827 */  and r0, r0, ra30
/* 00000b38: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000b40: 159e7040 10020827 */  or r0, r0, r1
/* 00000b48: 147e7180 10020867 */  and r1, r0, ra31
/* 00000b50: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000b58: 147e7180 10020827 */  and r0, r0, ra31
/* 00000b60: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000b68: 159e7040 10020827 */  or r0, r0, r1
/* 00000b70: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000b78: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000b80: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000b88: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000b90: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000b98: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000ba0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000ba8: fffffb38 f0f80227 */  brr ra8, -1224 // 0x00000700
/* 00000bb0: 009e7000 100009e7 */  nop
/* 00000bb8: 009e7000 100009e7 */  nop
/* 00000bc0: 009e7000 100009e7 */  nop
/* 00000bc8: fffffb18 f0f80227 */  brr ra8, -1256 // 0x00000700
/* 00000bd0: 009e7000 100009e7 */  nop
/* 00000bd8: 009e7000 100009e7 */  nop
/* 00000be0: 009e7000 100009e7 */  nop
/* 00000be8: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000bf0: 009e7000 100009e7 */  nop
/* 00000bf8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000c00: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000c08: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00000c10: 9538edbf 100248a3 */  mov r2, ra14; mov r3, rb14
/* 00000c18: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000c20: 959f8492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 8
/* 00000c28: 959f86db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 8
/* 00000c30: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000c38: 959f4492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 4
/* 00000c40: 959f46db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 4
/* 00000c48: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000c50: 959f2492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 2
/* 00000c58: 959f26db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 2
/* 00000c60: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000c68: 959f1492 d002c422 */  mov ra16, r2; mov.zc r2, r2 >> 1
/* 00000c70: 959f16db d002d423 */  mov rb16, r3; mov.zc r3, r3 >> 1
/* 00000c78: 159c5fc0 10020827 */  mov r0, rb5
/* 00000c80: 119c41c0 d0020827 */  shl r0, r0, 4; nop
/* 00000c88: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000c90: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000c98: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000ca0: 8c15edf6 10024160 */  add ra5, ra5, rb30; mov r0, ra5
/* 00000ca8: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000cb0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000cb8: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000cc0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000cc8: fffffc98 f0f80227 */  brr ra8, -872 // 0x00000980
/* 00000cd0: 009e7000 100009e7 */  nop
/* 00000cd8: 009e7000 100009e7 */  nop
/* 00000ce0: 0c1dedc0 100201e7 */  add ra7, ra7, rb30
/* 00000ce8: 954d3dbf 100248a3 */  mov r2, ra19; mov r3, rb19
/* 00000cf0: 20367016 100049e0 */  nop; fmul r0, r2, ra13
/* 00000cf8: 209cd017 100049e1 */  nop; fmul r1, r2, rb13
/* 00000d00: 209cd01f 100049e2 */  nop; fmul r2, r3, rb13
/* 00000d08: 2136709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra13
/* 00000d10: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000d18: 024e7c80 100208a7 */  fsub r2, ra19, r2
/* 00000d20: 029d3ec0 100208e7 */  fsub r3, rb19, r3
/* 00000d28: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000d30: 959f8492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 8
/* 00000d38: 959f86db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 8
/* 00000d40: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000d48: 959f4492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 4
/* 00000d50: 959f46db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 4
/* 00000d58: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000d60: 959f2492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 2
/* 00000d68: 959f26db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 2
/* 00000d70: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000d78: 959f1492 d002c422 */  mov ra16, r2; mov.zc r2, r2 >> 1
/* 00000d80: 959f16db d002d423 */  mov rb16, r3; mov.zc r3, r3 >> 1
/* 00000d88: 0e1c9dc0 d00229e7 */  shr.setf -, ra7, 9; nop
/* 00000d90: fffffbd0 f00809e7 */  brr.allz -, -1072 // 0x00000980
/* 00000d98: 009e7000 100009e7 */  nop
/* 00000da0: 009e7000 100009e7 */  nop
/* 00000da8: 0c1dedc0 100201e7 */  add ra7, ra7, rb30
/* 00000db0: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000db8: 009e7000 100009e7 */  nop
/* 00000dc0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000dc8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000dd0: fffffc28 f0f809e7 */  brr -, -984 // 0x00000a18
/* 00000dd8: 009e7000 100009e7 */  nop
/* 00000de0: 009e7000 100009e7 */  nop
/* 00000de8: 009e7000 100009e7 */  nop
/* 00000df0: 159c3fc0 100209a7 */  mov irq, rb3
/* 00000df8: 009e7000 300009e7 */  nop; nop; thrend
/* 00000e00: 009e7000 100009e7 */  nop
/* 00000e08: 009e7000 100009e7 */  nop


