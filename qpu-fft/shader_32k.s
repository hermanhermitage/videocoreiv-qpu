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

shader_32k:
/* 00000000: 00000010 e00216e7 */  ldi rb27, 0x00000010
/* 00000008: 00000040 e0021727 */  ldi rb28, 0x00000040
/* 00000010: 00000080 e0021767 */  ldi rb29, 0x00000080
/* 00000018: 000000f0 e00217a7 */  ldi rb30, 0x000000f0
/* 00000020: 00000100 e00217e7 */  ldi rb31, 0x00000100
/* 00000028: 00005555 e0020767 */  ldi ra29, 0x00005555
/* 00000030: 00003333 e00207a7 */  ldi ra30, 0x00003333
/* 00000038: 00000f0f e00207e7 */  ldi ra31, 0x00000f0f
/* 00000040: 000000ff e00216a7 */  ldi rb26, 0x000000ff
/* 00000048: 90104000 e0020727 */  ldi ra28, 0x90104000
/* 00000050: 90105000 e0021067 */  ldi rb1, 0x90105000
/* 00000058: 15827d80 10020827 */  mov r0, unif
/* 00000060: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000068: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000070: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000078: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 00000080: 159e7900 100202a7 */  mov ra10, r4
/* 00000088: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000090: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 00000098: 159e7900 100202e7 */  mov ra11, r4
/* 000000a0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000a8: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000000b0: 159e7900 10020327 */  mov ra12, r4
/* 000000b8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000c0: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000000c8: 159e7900 10020367 */  mov ra13, r4
/* 000000d0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000d8: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000000e0: 159e7900 100203a7 */  mov ra14, r4
/* 000000e8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000f0: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000000f8: 159e7900 100203e7 */  mov ra15, r4
/* 00000100: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000108: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000110: 159e7900 100212a7 */  mov rb10, r4
/* 00000118: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000120: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000128: 159e7900 100212e7 */  mov rb11, r4
/* 00000130: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000138: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000140: 159e7900 10021327 */  mov rb12, r4
/* 00000148: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000150: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000158: 159e7900 10021367 */  mov rb13, r4
/* 00000160: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000168: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000170: 159e7900 100213a7 */  mov rb14, r4
/* 00000178: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000180: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000188: 159e7900 100213e7 */  mov rb15, r4
/* 00000190: 15827d80 10020827 */  mov r0, unif
/* 00000198: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000001a0: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 000001a8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000001b0: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000001b8: 159e7900 10020427 */  mov ra16, r4
/* 000001c0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000001c8: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000001d0: 159e7900 10020467 */  mov ra17, r4
/* 000001d8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000001e0: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 000001e8: 159e7900 10021427 */  mov rb16, r4
/* 000001f0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000001f8: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000200: 159e7900 10021467 */  mov rb17, r4
/* 00000208: 15827d80 10021167 */  mov rb5, unif
/* 00000210: 00101200 e0020827 */  ldi r0, 0x00101200
/* 00000218: 00000010 e0020867 */  ldi r1, 0x00000010
/* 00000220: 00000002 e00208a7 */  ldi r2, 0x00000002
/* 00000228: 409c5017 100049e2 */  nop; mul24 r2, r2, rb5
/* 00000230: cc9e7081 100246a0 */  add ra26, r0, r2; v8adds r0, r0, r1
/* 00000238: cc9e7081 100246e0 */  add ra27, r0, r2; v8adds r0, r0, r1
/* 00000240: cc9e7081 100250a0 */  add rb2, r0, r2; v8adds r0, r0, r1
/* 00000248: 0c9e7080 100211e7 */  add rb7, r0, r2
/* 00000250: 000000c8 f0f80127 */  brr ra4, +200 // 0x00000338
/* 00000258: 009e7000 100009e7 */  nop
/* 00000260: 009e7000 100009e7 */  nop
/* 00000268: 009e7000 100009e7 */  nop
/* 00000270: 156a7d80 10021c67 */  mov vw_setup, ra26
/* 00000278: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000280: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000288: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 00000290: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000298: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 000002a0: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 000002a8: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000002b0: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000002b8: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000002c0: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000002c8: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000002d0: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000002d8: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000002e0: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000002e8: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000002f0: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000002f8: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000300: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000308: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000310: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000318: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000320: 15727d80 10021c67 */  mov vw_setup, ra28
/* 00000328: c0001fc0 e0021c67 */  ldi vw_setup, 0xc0001fc0
/* 00000330: 8c05cdf6 10024072 */  add ra1, ra1, rb28; mov vw_addr, ra1
/* 00000338: 00000050 f0f81127 */  brr rb4, +80 // 0x000003a8
/* 00000340: 009e7000 100009e7 */  nop
/* 00000348: 009e7000 100009e7 */  nop
/* 00000350: 009e7000 100009e7 */  nop
/* 00000358: 156a7d80 10021c67 */  mov vw_setup, ra26
/* 00000360: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000368: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000370: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 00000378: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000380: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000388: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 00000390: 009e7000 100009e7 */  nop
/* 00000398: 156a7d80 10020c67 */  mov vr_setup, ra26
/* 000003a0: 15c27d80 100009e7 */  mov.never -, vpm
/* 000003a8: 00000080 f0f801a7 */  brr ra6, +128 // 0x00000448
/* 000003b0: 009e7000 100009e7 */  nop
/* 000003b8: 009e7000 100009e7 */  nop
/* 000003c0: 009e7000 100009e7 */  nop
/* 000003c8: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 000003d0: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000003d8: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000003e0: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000003e8: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000003f0: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000003f8: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000400: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000408: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000410: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000418: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000420: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000428: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000430: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000438: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000440: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000448: 00000588 f0f811a7 */  brr rb6, +1416 // 0x000009f0
/* 00000450: 009e7000 100009e7 */  nop
/* 00000458: 009e7000 100009e7 */  nop
/* 00000460: 009e7000 100009e7 */  nop
/* 00000468: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000470: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 00000478: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 00000480: 009e7000 100009e7 */  nop
/* 00000488: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000490: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 00000498: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 000004a0: 009e7000 100009e7 */  nop
/* 000004a8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000004b0: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 000004b8: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 000004c0: 009e7000 100009e7 */  nop
/* 000004c8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000004d0: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 000004d8: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 000004e0: 009e7000 100009e7 */  nop
/* 000004e8: 00000000 f0f509e7 */  bra -, ra8+0
/* 000004f0: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 000004f8: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 00000500: 009e7000 100009e7 */  nop
/* 00000508: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000510: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 00000518: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 00000520: 009e7000 100009e7 */  nop
/* 00000528: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000530: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 00000538: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 00000540: 009e7000 100009e7 */  nop
/* 00000548: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000550: 204e7030 1000d9c2 */  nop; fmul.zc ra2, ra19, r0
/* 00000558: 209d3039 1000c9e2 */  nop; fmul.zc r2, rb19, r1
/* 00000560: 22093cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb19, r0
/* 00000568: 204e7031 1000c9e1 */  nop; fmul.zc r1, ra19, r1
/* 00000570: 819ff2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 15
/* 00000578: 819f1400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 1
/* 00000580: 829ff609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 15
/* 00000588: 819f1449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 1
/* 00000590: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000598: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 000005a0: 20527030 1000d9c2 */  nop; fmul.zc ra2, ra20, r0
/* 000005a8: 209d4039 1000c9e2 */  nop; fmul.zc r2, rb20, r1
/* 000005b0: 22094cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb20, r0
/* 000005b8: 20527031 1000c9e1 */  nop; fmul.zc r1, ra20, r1
/* 000005c0: 819fe2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 14
/* 000005c8: 819f2400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 2
/* 000005d0: 829fe609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 14
/* 000005d8: 819f2449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 2
/* 000005e0: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000005e8: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000005f0: 20567030 1000d9c2 */  nop; fmul.zc ra2, ra21, r0
/* 000005f8: 209d5039 1000c9e2 */  nop; fmul.zc r2, rb21, r1
/* 00000600: 22095cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb21, r0
/* 00000608: 20567031 1000c9e1 */  nop; fmul.zc r1, ra21, r1
/* 00000610: 819fc2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 12
/* 00000618: 819f4400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 4
/* 00000620: 829fc609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 12
/* 00000628: 819f4449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 4
/* 00000630: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000638: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000640: 205a7030 1000d9c2 */  nop; fmul.zc ra2, ra22, r0
/* 00000648: 209d6039 1000c9e2 */  nop; fmul.zc r2, rb22, r1
/* 00000650: 22096cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb22, r0
/* 00000658: 205a7031 1000c9e1 */  nop; fmul.zc r1, ra22, r1
/* 00000660: 819f82c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 8
/* 00000668: 819f8400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 8
/* 00000670: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000678: 829f8609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 8
/* 00000680: 819f8449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 8
/* 00000688: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000690: 8c15edf6 10024160 */  add ra5, ra5, rb30; mov r0, ra5
/* 00000698: 14767180 10020867 */  and r1, r0, ra29
/* 000006a0: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 000006a8: 14767180 10020827 */  and r0, r0, ra29
/* 000006b0: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 000006b8: 159e7040 10020827 */  or r0, r0, r1
/* 000006c0: 147a7180 10020867 */  and r1, r0, ra30
/* 000006c8: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 000006d0: 147a7180 10020827 */  and r0, r0, ra30
/* 000006d8: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 000006e0: 159e7040 10020827 */  or r0, r0, r1
/* 000006e8: 147e7180 10020867 */  and r1, r0, ra31
/* 000006f0: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000006f8: 147e7180 10020827 */  and r0, r0, ra31
/* 00000700: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000708: 159e7040 10020827 */  or r0, r0, r1
/* 00000710: 149da1c0 10020867 */  and r1, r0, rb26
/* 00000718: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000720: 149da1c0 10020827 */  and r0, r0, rb26
/* 00000728: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000730: 159e7040 10020827 */  or r0, r0, r1
/* 00000738: 119c21c0 d0020827 */  shl r0, r0, 2; nop
/* 00000740: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000748: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000750: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000758: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000760: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000768: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000770: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000778: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000780: 159e7900 10020867 */  mov r1, r4
/* 00000788: fffffda0 f0f80027 */  brr ra0, -608 // 0x00000548
/* 00000790: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000798: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 000007a0: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 000007a8: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 000007b0: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 000007b8: 14767180 10020867 */  and r1, r0, ra29
/* 000007c0: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 000007c8: 14767180 10020827 */  and r0, r0, ra29
/* 000007d0: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 000007d8: 159e7040 10020827 */  or r0, r0, r1
/* 000007e0: 147a7180 10020867 */  and r1, r0, ra30
/* 000007e8: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 000007f0: 147a7180 10020827 */  and r0, r0, ra30
/* 000007f8: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000800: 159e7040 10020827 */  or r0, r0, r1
/* 00000808: 147e7180 10020867 */  and r1, r0, ra31
/* 00000810: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000818: 147e7180 10020827 */  and r0, r0, ra31
/* 00000820: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000828: 159e7040 10020827 */  or r0, r0, r1
/* 00000830: 149da1c0 10020867 */  and r1, r0, rb26
/* 00000838: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000840: 149da1c0 10020827 */  and r0, r0, rb26
/* 00000848: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000850: 159e7040 10020827 */  or r0, r0, r1
/* 00000858: 119c21c0 d0020827 */  shl r0, r0, 2; nop
/* 00000860: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000868: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000870: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000878: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000880: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000888: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000890: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000898: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 000008a0: 159e7900 10020867 */  mov r1, r4
/* 000008a8: fffffc80 f0f80027 */  brr ra0, -896 // 0x00000548
/* 000008b0: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 000008b8: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 000008c0: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 000008c8: 204a7006 100059c2 */  nop; fmul ra2, r0, ra18
/* 000008d0: 209d200f 100049e2 */  nop; fmul r2, r1, rb18
/* 000008d8: 204a700e 100049e3 */  nop; fmul r3, r1, ra18
/* 000008e0: 22092c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb18
/* 000008e8: 019e72c0 10020867 */  fadd r1, r1, r3
/* 000008f0: 00000000 f0f489e7 */  bra -, ra4+0
/* 000008f8: 95682ff6 10024682 */  mov ra26, rb2; mov rb2, ra26
/* 00000900: 956c7ff6 100246c7 */  mov ra27, rb7; mov rb7, ra27
/* 00000908: 95701ff6 10024701 */  mov ra28, rb1; mov rb1, ra28
/* 00000910: 8c15edf6 10024160 */  add ra5, ra5, rb30; mov r0, ra5
/* 00000918: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000920: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000928: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000930: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000938: fffffbf0 f0f80027 */  brr ra0, -1040 // 0x00000548
/* 00000940: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000948: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000950: 159e7900 10020867 */  mov r1, r4
/* 00000958: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000960: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000968: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000970: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000978: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000980: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000988: fffffba0 f0f80027 */  brr ra0, -1120 // 0x00000548
/* 00000990: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000998: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 000009a0: 159e7900 10020867 */  mov r1, r4
/* 000009a8: 204a7006 100059c2 */  nop; fmul ra2, r0, ra18
/* 000009b0: 209d200f 100049e2 */  nop; fmul r2, r1, rb18
/* 000009b8: 204a700e 100049e3 */  nop; fmul r3, r1, ra18
/* 000009c0: 22092c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb18
/* 000009c8: 019e72c0 10020867 */  fadd r1, r1, r3
/* 000009d0: 00000000 f0f489e7 */  bra -, ra4+0
/* 000009d8: 95682ff6 10024682 */  mov ra26, rb2; mov rb2, ra26
/* 000009e0: 956c7ff6 100246c7 */  mov ra27, rb7; mov rb7, ra27
/* 000009e8: 95701ff6 10024701 */  mov ra28, rb1; mov rb1, ra28
/* 000009f0: 159c5fc0 10022827 */  mov.setf r0, rb5
/* 000009f8: 0d9c11c0 d0020827 */  sub r0, r0, 1; nop
/* 00000a00: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000a08: 0c9c6e00 100601a7 */  add.zc ra6, rb6, r0
/* 00000a10: 159c4fc0 10060127 */  mov.zc ra4, rb4
/* 00000a18: 15827d80 100220e7 */  mov.setf ra3, unif
/* 00000a20: 15827d80 100210e7 */  mov rb3, unif
/* 00000a28: 00000668 f00809e7 */  brr.allz -, +1640 // 0x000010b0
/* 00000a30: 9528adbf 10024492 */  mov ra18, ra10; mov rb18, rb10
/* 00000a38: 952cbdbf 100248a3 */  mov r2, ra11; mov r3, rb11
/* 00000a40: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000a48: 959f8492 d002c5a2 */  mov ra22, r2; mov.zc r2, r2 >> 8
/* 00000a50: 959f86db d002d5a3 */  mov rb22, r3; mov.zc r3, r3 >> 8
/* 00000a58: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000a60: 959f4492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 4
/* 00000a68: 959f46db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 4
/* 00000a70: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000a78: 959f2492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 2
/* 00000a80: 959f26db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 2
/* 00000a88: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000a90: 959f1492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 1
/* 00000a98: 959f16db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 1
/* 00000aa0: 159c5fc0 10020827 */  mov r0, rb5
/* 00000aa8: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000ab0: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000ab8: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000ac0: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000ac8: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000ad0: 14767180 10020867 */  and r1, r0, ra29
/* 00000ad8: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000ae0: 14767180 10020827 */  and r0, r0, ra29
/* 00000ae8: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000af0: 159e7040 10020827 */  or r0, r0, r1
/* 00000af8: 147a7180 10020867 */  and r1, r0, ra30
/* 00000b00: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000b08: 147a7180 10020827 */  and r0, r0, ra30
/* 00000b10: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000b18: 159e7040 10020827 */  or r0, r0, r1
/* 00000b20: 147e7180 10020867 */  and r1, r0, ra31
/* 00000b28: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000b30: 147e7180 10020827 */  and r0, r0, ra31
/* 00000b38: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000b40: 159e7040 10020827 */  or r0, r0, r1
/* 00000b48: 149da1c0 10020867 */  and r1, r0, rb26
/* 00000b50: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000b58: 149da1c0 10020827 */  and r0, r0, rb26
/* 00000b60: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000b68: 159e7040 10020827 */  or r0, r0, r1
/* 00000b70: 119c21c0 d0020827 */  shl r0, r0, 2; nop
/* 00000b78: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000b80: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000b88: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000b90: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000b98: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000ba0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000ba8: fffffac8 f0f80227 */  brr ra8, -1336 // 0x00000690
/* 00000bb0: 009e7000 100009e7 */  nop
/* 00000bb8: 009e7000 100009e7 */  nop
/* 00000bc0: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000bc8: 0e1cfdc0 d00229e7 */  shr.setf -, ra7, 15; nop
/* 00000bd0: fffffaa0 f00809e7 */  brr.allz -, -1376 // 0x00000690
/* 00000bd8: 009e7000 100009e7 */  nop
/* 00000be0: 009e7000 100009e7 */  nop
/* 00000be8: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000bf0: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000bf8: 009e7000 100009e7 */  nop
/* 00000c00: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000c08: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000c10: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00000c18: 9528adbf 10024492 */  mov ra18, ra10; mov rb18, rb10
/* 00000c20: 952cbdbf 100248a3 */  mov r2, ra11; mov r3, rb11
/* 00000c28: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000c30: 959f8492 d002c5a2 */  mov ra22, r2; mov.zc r2, r2 >> 8
/* 00000c38: 959f86db d002d5a3 */  mov rb22, r3; mov.zc r3, r3 >> 8
/* 00000c40: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000c48: 959f4492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 4
/* 00000c50: 959f46db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 4
/* 00000c58: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000c60: 959f2492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 2
/* 00000c68: 959f26db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 2
/* 00000c70: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000c78: 959f1492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 1
/* 00000c80: 959f16db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 1
/* 00000c88: 159c5fc0 10020827 */  mov r0, rb5
/* 00000c90: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000c98: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000ca0: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000ca8: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000cb0: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000cb8: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000cc0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000cc8: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000cd0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000cd8: fffffc18 f0f80227 */  brr ra8, -1000 // 0x00000910
/* 00000ce0: 009e7000 100009e7 */  nop
/* 00000ce8: 009e7000 100009e7 */  nop
/* 00000cf0: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000cf8: fffffbf8 f0f80227 */  brr ra8, -1032 // 0x00000910
/* 00000d00: 009e7000 100009e7 */  nop
/* 00000d08: 009e7000 100009e7 */  nop
/* 00000d10: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000d18: fffffbd8 f0f80227 */  brr ra8, -1064 // 0x00000910
/* 00000d20: 009e7000 100009e7 */  nop
/* 00000d28: 009e7000 100009e7 */  nop
/* 00000d30: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000d38: fffffbb8 f0f80227 */  brr ra8, -1096 // 0x00000910
/* 00000d40: 009e7000 100009e7 */  nop
/* 00000d48: 009e7000 100009e7 */  nop
/* 00000d50: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000d58: 95492dbf 100248a3 */  mov r2, ra18; mov r3, rb18
/* 00000d60: 20327016 100049e0 */  nop; fmul r0, r2, ra12
/* 00000d68: 209cc017 100049e1 */  nop; fmul r1, r2, rb12
/* 00000d70: 209cc01f 100049e2 */  nop; fmul r2, r3, rb12
/* 00000d78: 2132709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra12
/* 00000d80: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000d88: 024a7c80 100204a7 */  fsub ra18, ra18, r2
/* 00000d90: 029d2ec0 100214a7 */  fsub rb18, rb18, r3
/* 00000d98: 95596dbf 100248a3 */  mov r2, ra22; mov r3, rb22
/* 00000da0: 20367016 100049e0 */  nop; fmul r0, r2, ra13
/* 00000da8: 209cd017 100049e1 */  nop; fmul r1, r2, rb13
/* 00000db0: 209cd01f 100049e2 */  nop; fmul r2, r3, rb13
/* 00000db8: 2136709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra13
/* 00000dc0: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000dc8: 025a7c80 100208a7 */  fsub r2, ra22, r2
/* 00000dd0: 029d6ec0 100208e7 */  fsub r3, rb22, r3
/* 00000dd8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000de0: 959f8492 d002c5a2 */  mov ra22, r2; mov.zc r2, r2 >> 8
/* 00000de8: 959f86db d002d5a3 */  mov rb22, r3; mov.zc r3, r3 >> 8
/* 00000df0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000df8: 959f4492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 4
/* 00000e00: 959f46db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 4
/* 00000e08: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000e10: 959f2492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 2
/* 00000e18: 959f26db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 2
/* 00000e20: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000e28: 959f1492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 1
/* 00000e30: 959f16db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 1
/* 00000e38: 0e1cfdc0 d00229e7 */  shr.setf -, ra7, 15; nop
/* 00000e40: fffffab0 f00809e7 */  brr.allz -, -1360 // 0x00000910
/* 00000e48: 00000060 e0020827 */  ldi r0, 0x00000060
/* 00000e50: 0d227c00 10020227 */  sub ra8, ra8, r0
/* 00000e58: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000e60: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000e68: 009e7000 100009e7 */  nop
/* 00000e70: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000e78: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000e80: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00000e88: 95410dbf 10024492 */  mov ra18, ra16; mov rb18, rb16
/* 00000e90: 95451dbf 100248a3 */  mov r2, ra17; mov r3, rb17
/* 00000e98: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000ea0: 959f8492 d002c5a2 */  mov ra22, r2; mov.zc r2, r2 >> 8
/* 00000ea8: 959f86db d002d5a3 */  mov rb22, r3; mov.zc r3, r3 >> 8
/* 00000eb0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000eb8: 959f4492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 4
/* 00000ec0: 959f46db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 4
/* 00000ec8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000ed0: 959f2492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 2
/* 00000ed8: 959f26db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 2
/* 00000ee0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000ee8: 959f1492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 1
/* 00000ef0: 959f16db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 1
/* 00000ef8: 159c5fc0 10020827 */  mov r0, rb5
/* 00000f00: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000f08: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000f10: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000f18: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000f20: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000f28: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000f30: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000f38: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000f40: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000f48: fffff9a8 f0f80227 */  brr ra8, -1624 // 0x00000910
/* 00000f50: 009e7000 100009e7 */  nop
/* 00000f58: 009e7000 100009e7 */  nop
/* 00000f60: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000f68: 95492dbf 100248a3 */  mov r2, ra18; mov r3, rb18
/* 00000f70: 203a7016 100049e0 */  nop; fmul r0, r2, ra14
/* 00000f78: 209ce017 100049e1 */  nop; fmul r1, r2, rb14
/* 00000f80: 209ce01f 100049e2 */  nop; fmul r2, r3, rb14
/* 00000f88: 213a709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra14
/* 00000f90: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000f98: 024a7c80 100204a7 */  fsub ra18, ra18, r2
/* 00000fa0: 029d2ec0 100214a7 */  fsub rb18, rb18, r3
/* 00000fa8: 95596dbf 100248a3 */  mov r2, ra22; mov r3, rb22
/* 00000fb0: 203e7016 100049e0 */  nop; fmul r0, r2, ra15
/* 00000fb8: 209cf017 100049e1 */  nop; fmul r1, r2, rb15
/* 00000fc0: 209cf01f 100049e2 */  nop; fmul r2, r3, rb15
/* 00000fc8: 213e709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra15
/* 00000fd0: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000fd8: 025a7c80 100208a7 */  fsub r2, ra22, r2
/* 00000fe0: 029d6ec0 100208e7 */  fsub r3, rb22, r3
/* 00000fe8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000ff0: 959f8492 d002c5a2 */  mov ra22, r2; mov.zc r2, r2 >> 8
/* 00000ff8: 959f86db d002d5a3 */  mov rb22, r3; mov.zc r3, r3 >> 8
/* 00001000: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00001008: 959f4492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 4
/* 00001010: 959f46db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 4
/* 00001018: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00001020: 959f2492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 2
/* 00001028: 959f26db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 2
/* 00001030: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00001038: 959f1492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 1
/* 00001040: 959f16db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 1
/* 00001048: 0e1cfdc0 d00229e7 */  shr.setf -, ra7, 15; nop
/* 00001050: fffff8a0 f00809e7 */  brr.allz -, -1888 // 0x00000910
/* 00001058: 009e7000 100009e7 */  nop
/* 00001060: 009e7000 100009e7 */  nop
/* 00001068: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00001070: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00001078: 009e7000 100009e7 */  nop
/* 00001080: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00001088: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00001090: fffff968 f0f809e7 */  brr -, -1688 // 0x00000a18
/* 00001098: 009e7000 100009e7 */  nop
/* 000010a0: 009e7000 100009e7 */  nop
/* 000010a8: 009e7000 100009e7 */  nop
/* 000010b0: 159c3fc0 100209a7 */  mov irq, rb3
/* 000010b8: 009e7000 300009e7 */  nop; nop; thrend
/* 000010c0: 009e7000 100009e7 */  nop
/* 000010c8: 009e7000 100009e7 */  nop


