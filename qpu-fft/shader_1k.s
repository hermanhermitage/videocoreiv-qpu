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

shader_1k:
/* 00000000: 00000010 e00216e7 */  ldi rb27, 0x00000010
/* 00000008: 00000040 e0021727 */  ldi rb28, 0x00000040
/* 00000010: 000000f0 e0021767 */  ldi rb29, 0x000000f0
/* 00000018: 00005555 e00207a7 */  ldi ra30, 0x00005555
/* 00000020: 00003333 e00217a7 */  ldi rb30, 0x00003333
/* 00000028: 00000f0f e00207e7 */  ldi ra31, 0x00000f0f
/* 00000030: 000000ff e00217e7 */  ldi rb31, 0x000000ff
/* 00000038: 90104000 e0020767 */  ldi ra29, 0x90104000
/* 00000040: 90105000 e0021067 */  ldi rb1, 0x90105000
/* 00000048: 00000080 e00208e7 */  ldi r3, 0x00000080
/* 00000050: 15827d80 10020827 */  mov r0, unif
/* 00000058: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000060: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000068: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000070: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000078: 159e7900 100202a7 */  mov ra10, r4
/* 00000080: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000088: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000090: 159e7900 100202e7 */  mov ra11, r4
/* 00000098: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000a0: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000a8: 159e7900 10020327 */  mov ra12, r4
/* 000000b0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000b8: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 000000c0: 159e7900 10020367 */  mov ra13, r4
/* 000000c8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000d0: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 000000d8: 159e7900 100212a7 */  mov rb10, r4
/* 000000e0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000e8: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 000000f0: 159e7900 100212e7 */  mov rb11, r4
/* 000000f8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000100: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000108: 159e7900 10021327 */  mov rb12, r4
/* 00000110: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000118: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000120: 159e7900 10021367 */  mov rb13, r4
/* 00000128: 15827d80 10020827 */  mov r0, unif
/* 00000130: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000138: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000140: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000148: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000150: 159e7900 100203a7 */  mov ra14, r4
/* 00000158: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000160: 0c9e70c0 a0020827 */  add r0, r0, r3; nop; ldtmu0
/* 00000168: 159e7900 100203e7 */  mov ra15, r4
/* 00000170: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000178: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000180: 159e7900 100213a7 */  mov rb14, r4
/* 00000188: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000190: 0c9e72c0 a0020867 */  add r1, r1, r3; nop; ldtmu0
/* 00000198: 159e7900 100213e7 */  mov rb15, r4
/* 000001a0: 15827d80 10021167 */  mov rb5, unif
/* 000001a8: 00101200 e0020827 */  ldi r0, 0x00101200
/* 000001b0: 00000010 e0020867 */  ldi r1, 0x00000010
/* 000001b8: 00000002 e00208a7 */  ldi r2, 0x00000002
/* 000001c0: 409c5017 100049e2 */  nop; mul24 r2, r2, rb5
/* 000001c8: cc9e7081 100246e0 */  add ra27, r0, r2; v8adds r0, r0, r1
/* 000001d0: cc9e7081 10024720 */  add ra28, r0, r2; v8adds r0, r0, r1
/* 000001d8: cc9e7081 100250a0 */  add rb2, r0, r2; v8adds r0, r0, r1
/* 000001e0: 0c9e7080 100211e7 */  add rb7, r0, r2
/* 000001e8: 000000c8 f0f80127 */  brr ra4, +200 // 0x000002d0
/* 000001f0: 009e7000 100009e7 */  nop
/* 000001f8: 009e7000 100009e7 */  nop
/* 00000200: 009e7000 100009e7 */  nop
/* 00000208: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 00000210: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000218: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000220: 15727d80 10021c67 */  mov vw_setup, ra28
/* 00000228: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000230: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000238: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000240: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000248: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000250: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000258: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000260: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000268: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000270: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000278: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000280: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000288: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000290: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000298: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000002a0: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 000002a8: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 000002b0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000002b8: 15767d80 10021c67 */  mov vw_setup, ra29
/* 000002c0: c00000c0 e0021c67 */  ldi vw_setup, 0xc00000c0
/* 000002c8: 8c05cdf6 10024072 */  add ra1, ra1, rb28; mov vw_addr, ra1
/* 000002d0: 00000050 f0f81127 */  brr rb4, +80 // 0x00000340
/* 000002d8: 009e7000 100009e7 */  nop
/* 000002e0: 009e7000 100009e7 */  nop
/* 000002e8: 009e7000 100009e7 */  nop
/* 000002f0: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 000002f8: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000300: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000308: 15727d80 10021c67 */  mov vw_setup, ra28
/* 00000310: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000318: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000320: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 00000328: 009e7000 100009e7 */  nop
/* 00000330: 156e7d80 10020c67 */  mov vr_setup, ra27
/* 00000338: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000340: 00000080 f0f801a7 */  brr ra6, +128 // 0x000003e0
/* 00000348: 009e7000 100009e7 */  nop
/* 00000350: 009e7000 100009e7 */  nop
/* 00000358: 009e7000 100009e7 */  nop
/* 00000360: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000368: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000370: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000378: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000380: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000388: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000390: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000398: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000003a0: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000003a8: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000003b0: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000003b8: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 000003c0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000003c8: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000003d0: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 000003d8: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 000003e0: 00000588 f0f811a7 */  brr rb6, +1416 // 0x00000988
/* 000003e8: 009e7000 100009e7 */  nop
/* 000003f0: 009e7000 100009e7 */  nop
/* 000003f8: 009e7000 100009e7 */  nop
/* 00000400: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000408: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 00000410: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 00000418: 009e7000 100009e7 */  nop
/* 00000420: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000428: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 00000430: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 00000438: 009e7000 100009e7 */  nop
/* 00000440: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000448: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 00000450: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 00000458: 009e7000 100009e7 */  nop
/* 00000460: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000468: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 00000470: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 00000478: 009e7000 100009e7 */  nop
/* 00000480: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000488: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 00000490: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 00000498: 009e7000 100009e7 */  nop
/* 000004a0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000004a8: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 000004b0: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 000004b8: 009e7000 100009e7 */  nop
/* 000004c0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000004c8: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 000004d0: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 000004d8: 009e7000 100009e7 */  nop
/* 000004e0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 000004e8: 20467030 1000d9c2 */  nop; fmul.zc ra2, ra17, r0
/* 000004f0: 209d1039 1000c9e2 */  nop; fmul.zc r2, rb17, r1
/* 000004f8: 22091cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb17, r0
/* 00000500: 20467031 1000c9e1 */  nop; fmul.zc r1, ra17, r1
/* 00000508: 819ff2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 15
/* 00000510: 819f1400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 1
/* 00000518: 829ff609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 15
/* 00000520: 819f1449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 1
/* 00000528: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000530: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000538: 204a7030 1000d9c2 */  nop; fmul.zc ra2, ra18, r0
/* 00000540: 209d2039 1000c9e2 */  nop; fmul.zc r2, rb18, r1
/* 00000548: 22092cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb18, r0
/* 00000550: 204a7031 1000c9e1 */  nop; fmul.zc r1, ra18, r1
/* 00000558: 819fe2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 14
/* 00000560: 819f2400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 2
/* 00000568: 829fe609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 14
/* 00000570: 819f2449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 2
/* 00000578: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000580: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000588: 204e7030 1000d9c2 */  nop; fmul.zc ra2, ra19, r0
/* 00000590: 209d3039 1000c9e2 */  nop; fmul.zc r2, rb19, r1
/* 00000598: 22093cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb19, r0
/* 000005a0: 204e7031 1000c9e1 */  nop; fmul.zc r1, ra19, r1
/* 000005a8: 819fc2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 12
/* 000005b0: 819f4400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 4
/* 000005b8: 829fc609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 12
/* 000005c0: 819f4449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 4
/* 000005c8: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000005d0: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000005d8: 20527030 1000d9c2 */  nop; fmul.zc ra2, ra20, r0
/* 000005e0: 209d4039 1000c9e2 */  nop; fmul.zc r2, rb20, r1
/* 000005e8: 22094cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb20, r0
/* 000005f0: 20527031 1000c9e1 */  nop; fmul.zc r1, ra20, r1
/* 000005f8: 819f82c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 8
/* 00000600: 819f8400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 8
/* 00000608: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000610: 829f8609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 8
/* 00000618: 819f8449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 8
/* 00000620: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000628: 8c15ddf6 10024160 */  add ra5, ra5, rb29; mov r0, ra5
/* 00000630: 147a7180 10020867 */  and r1, r0, ra30
/* 00000638: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000640: 147a7180 10020827 */  and r0, r0, ra30
/* 00000648: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000650: 159e7040 10020827 */  or r0, r0, r1
/* 00000658: 149de1c0 10020867 */  and r1, r0, rb30
/* 00000660: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000668: 149de1c0 10020827 */  and r0, r0, rb30
/* 00000670: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000678: 159e7040 10020827 */  or r0, r0, r1
/* 00000680: 147e7180 10020867 */  and r1, r0, ra31
/* 00000688: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000690: 147e7180 10020827 */  and r0, r0, ra31
/* 00000698: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 000006a0: 159e7040 10020827 */  or r0, r0, r1
/* 000006a8: 149df1c0 10020867 */  and r1, r0, rb31
/* 000006b0: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 000006b8: 149df1c0 10020827 */  and r0, r0, rb31
/* 000006c0: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 000006c8: 159e7040 10020827 */  or r0, r0, r1
/* 000006d0: 0e9c31c0 d0020827 */  shr r0, r0, 3; nop
/* 000006d8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000006e0: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 000006e8: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 000006f0: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 000006f8: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000700: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000708: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000710: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000718: 159e7900 10020867 */  mov r1, r4
/* 00000720: fffffda0 f0f80027 */  brr ra0, -608 // 0x000004e0
/* 00000728: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000730: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000738: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000740: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000748: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000750: 147a7180 10020867 */  and r1, r0, ra30
/* 00000758: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000760: 147a7180 10020827 */  and r0, r0, ra30
/* 00000768: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000770: 159e7040 10020827 */  or r0, r0, r1
/* 00000778: 149de1c0 10020867 */  and r1, r0, rb30
/* 00000780: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000788: 149de1c0 10020827 */  and r0, r0, rb30
/* 00000790: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000798: 159e7040 10020827 */  or r0, r0, r1
/* 000007a0: 147e7180 10020867 */  and r1, r0, ra31
/* 000007a8: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000007b0: 147e7180 10020827 */  and r0, r0, ra31
/* 000007b8: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 000007c0: 159e7040 10020827 */  or r0, r0, r1
/* 000007c8: 149df1c0 10020867 */  and r1, r0, rb31
/* 000007d0: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 000007d8: 149df1c0 10020827 */  and r0, r0, rb31
/* 000007e0: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 000007e8: 159e7040 10020827 */  or r0, r0, r1
/* 000007f0: 0e9c31c0 d0020827 */  shr r0, r0, 3; nop
/* 000007f8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000800: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000808: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000810: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000818: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000820: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000828: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000830: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000838: 159e7900 10020867 */  mov r1, r4
/* 00000840: fffffc80 f0f80027 */  brr ra0, -896 // 0x000004e0
/* 00000848: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000850: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000858: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000860: 20427006 100059c2 */  nop; fmul ra2, r0, ra16
/* 00000868: 209d000f 100049e2 */  nop; fmul r2, r1, rb16
/* 00000870: 2042700e 100049e3 */  nop; fmul r3, r1, ra16
/* 00000878: 22090c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb16
/* 00000880: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00000888: 00000000 f0f489e7 */  bra -, ra4+0
/* 00000890: 956c2ff6 100246c2 */  mov ra27, rb2; mov rb2, ra27
/* 00000898: 95707ff6 10024707 */  mov ra28, rb7; mov rb7, ra28
/* 000008a0: 95741ff6 10024741 */  mov ra29, rb1; mov rb1, ra29
/* 000008a8: 8c15ddf6 10024160 */  add ra5, ra5, rb29; mov r0, ra5
/* 000008b0: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 000008b8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000008c0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 000008c8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000008d0: fffffbf0 f0f80027 */  brr ra0, -1040 // 0x000004e0
/* 000008d8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000008e0: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 000008e8: 159e7900 10020867 */  mov r1, r4
/* 000008f0: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 000008f8: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000900: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000908: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000910: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000918: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000920: fffffba0 f0f80027 */  brr ra0, -1120 // 0x000004e0
/* 00000928: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000930: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000938: 159e7900 10020867 */  mov r1, r4
/* 00000940: 20427006 100059c2 */  nop; fmul ra2, r0, ra16
/* 00000948: 209d000f 100049e2 */  nop; fmul r2, r1, rb16
/* 00000950: 2042700e 100049e3 */  nop; fmul r3, r1, ra16
/* 00000958: 22090c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb16
/* 00000960: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00000968: 00000000 f0f489e7 */  bra -, ra4+0
/* 00000970: 956c2ff6 100246c2 */  mov ra27, rb2; mov rb2, ra27
/* 00000978: 95707ff6 10024707 */  mov ra28, rb7; mov rb7, ra28
/* 00000980: 95741ff6 10024741 */  mov ra29, rb1; mov rb1, ra29
/* 00000988: 159c5fc0 10022827 */  mov.setf r0, rb5
/* 00000990: 0d9c11c0 d0020827 */  sub r0, r0, 1; nop
/* 00000998: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 000009a0: 0c9c6e00 100601a7 */  add.zc ra6, rb6, r0
/* 000009a8: 159c4fc0 10060127 */  mov.zc ra4, rb4
/* 000009b0: 15827d80 100220e7 */  mov.setf ra3, unif
/* 000009b8: 15827d80 100210e7 */  mov rb3, unif
/* 000009c0: 000003f8 f00809e7 */  brr.allz -, +1016 // 0x00000dd8
/* 000009c8: 9528adbf 10024410 */  mov ra16, ra10; mov rb16, rb10
/* 000009d0: 952cbdbf 100248a3 */  mov r2, ra11; mov r3, rb11
/* 000009d8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000009e0: 959f8492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 8
/* 000009e8: 959f86db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 8
/* 000009f0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000009f8: 959f4492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 4
/* 00000a00: 959f46db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 4
/* 00000a08: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000a10: 959f2492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 2
/* 00000a18: 959f26db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 2
/* 00000a20: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000a28: 959f1492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 1
/* 00000a30: 959f16db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 1
/* 00000a38: 159c5fc0 10020827 */  mov r0, rb5
/* 00000a40: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000a48: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000a50: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000a58: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000a60: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000a68: 147a7180 10020867 */  and r1, r0, ra30
/* 00000a70: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000a78: 147a7180 10020827 */  and r0, r0, ra30
/* 00000a80: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000a88: 159e7040 10020827 */  or r0, r0, r1
/* 00000a90: 149de1c0 10020867 */  and r1, r0, rb30
/* 00000a98: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000aa0: 149de1c0 10020827 */  and r0, r0, rb30
/* 00000aa8: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000ab0: 159e7040 10020827 */  or r0, r0, r1
/* 00000ab8: 147e7180 10020867 */  and r1, r0, ra31
/* 00000ac0: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000ac8: 147e7180 10020827 */  and r0, r0, ra31
/* 00000ad0: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000ad8: 159e7040 10020827 */  or r0, r0, r1
/* 00000ae0: 149df1c0 10020867 */  and r1, r0, rb31
/* 00000ae8: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000af0: 149df1c0 10020827 */  and r0, r0, rb31
/* 00000af8: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000b00: 159e7040 10020827 */  or r0, r0, r1
/* 00000b08: 0e9c31c0 d0020827 */  shr r0, r0, 3; nop
/* 00000b10: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000b18: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000b20: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000b28: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000b30: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000b38: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000b40: fffffac8 f0f80227 */  brr ra8, -1336 // 0x00000628
/* 00000b48: 009e7000 100009e7 */  nop
/* 00000b50: 00000100 e0020827 */  ldi r0, 0x00000100
/* 00000b58: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 00000b60: 0e1cadc0 d00229e7 */  shr.setf -, ra7, 10; nop
/* 00000b68: fffffaa0 f00809e7 */  brr.allz -, -1376 // 0x00000628
/* 00000b70: 009e7000 100009e7 */  nop
/* 00000b78: 00000100 e0020827 */  ldi r0, 0x00000100
/* 00000b80: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 00000b88: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000b90: 009e7000 100009e7 */  nop
/* 00000b98: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000ba0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000ba8: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00000bb0: 9538edbf 10024410 */  mov ra16, ra14; mov rb16, rb14
/* 00000bb8: 953cfdbf 100248a3 */  mov r2, ra15; mov r3, rb15
/* 00000bc0: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000bc8: 959f8492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 8
/* 00000bd0: 959f86db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 8
/* 00000bd8: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000be0: 959f4492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 4
/* 00000be8: 959f46db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 4
/* 00000bf0: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000bf8: 959f2492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 2
/* 00000c00: 959f26db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 2
/* 00000c08: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000c10: 959f1492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 1
/* 00000c18: 959f16db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 1
/* 00000c20: 159c5fc0 10020827 */  mov r0, rb5
/* 00000c28: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000c30: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000c38: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000c40: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000c48: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000c50: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000c58: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000c60: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000c68: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000c70: fffffc18 f0f80227 */  brr ra8, -1000 // 0x000008a8
/* 00000c78: 009e7000 100009e7 */  nop
/* 00000c80: 00000100 e0020827 */  ldi r0, 0x00000100
/* 00000c88: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 00000c90: 95410dbf 100248a3 */  mov r2, ra16; mov r3, rb16
/* 00000c98: 20327016 100049e0 */  nop; fmul r0, r2, ra12
/* 00000ca0: 209cc017 100049e1 */  nop; fmul r1, r2, rb12
/* 00000ca8: 209cc01f 100049e2 */  nop; fmul r2, r3, rb12
/* 00000cb0: 2132709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra12
/* 00000cb8: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000cc0: 02427c80 10020427 */  fsub ra16, ra16, r2
/* 00000cc8: 029d0ec0 10021427 */  fsub rb16, rb16, r3
/* 00000cd0: 95514dbf 100248a3 */  mov r2, ra20; mov r3, rb20
/* 00000cd8: 20367016 100049e0 */  nop; fmul r0, r2, ra13
/* 00000ce0: 209cd017 100049e1 */  nop; fmul r1, r2, rb13
/* 00000ce8: 209cd01f 100049e2 */  nop; fmul r2, r3, rb13
/* 00000cf0: 2136709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra13
/* 00000cf8: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000d00: 02527c80 100208a7 */  fsub r2, ra20, r2
/* 00000d08: 029d4ec0 100208e7 */  fsub r3, rb20, r3
/* 00000d10: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000d18: 959f8492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 8
/* 00000d20: 959f86db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 8
/* 00000d28: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000d30: 959f4492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 4
/* 00000d38: 959f46db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 4
/* 00000d40: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000d48: 959f2492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 2
/* 00000d50: 959f26db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 2
/* 00000d58: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000d60: 959f1492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 1
/* 00000d68: 959f16db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 1
/* 00000d70: 0e1cadc0 d00229e7 */  shr.setf -, ra7, 10; nop
/* 00000d78: fffffb10 f00809e7 */  brr.allz -, -1264 // 0x000008a8
/* 00000d80: 009e7000 100009e7 */  nop
/* 00000d88: 00000100 e0020827 */  ldi r0, 0x00000100
/* 00000d90: 0c1e7c00 100201e7 */  add ra7, ra7, r0
/* 00000d98: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000da0: 009e7000 100009e7 */  nop
/* 00000da8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000db0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000db8: fffffbd8 f0f809e7 */  brr -, -1064 // 0x000009b0
/* 00000dc0: 009e7000 100009e7 */  nop
/* 00000dc8: 009e7000 100009e7 */  nop
/* 00000dd0: 009e7000 100009e7 */  nop
/* 00000dd8: 159c3fc0 100209a7 */  mov irq, rb3
/* 00000de0: 009e7000 300009e7 */  nop; nop; thrend
/* 00000de8: 009e7000 100009e7 */  nop
/* 00000df0: 009e7000 100009e7 */  nop


