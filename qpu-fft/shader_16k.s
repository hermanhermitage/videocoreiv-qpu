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

shader_16k:
/* 00000000: 00000010 e00216e7 */  ldi rb27, 0x00000010
/* 00000008: 00000040 e0021727 */  ldi rb28, 0x00000040
/* 00000010: 00000080 e0021767 */  ldi rb29, 0x00000080
/* 00000018: 000000f0 e00217a7 */  ldi rb30, 0x000000f0
/* 00000020: 00000100 e00217e7 */  ldi rb31, 0x00000100
/* 00000028: 00005555 e0020767 */  ldi ra29, 0x00005555
/* 00000030: 00003333 e00207a7 */  ldi ra30, 0x00003333
/* 00000038: 00000f0f e00207e7 */  ldi ra31, 0x00000f0f
/* 00000040: 000000ff e00216a7 */  ldi rb26, 0x000000ff
/* 00000048: 88104000 e00206e7 */  ldi ra27, 0x88104000
/* 00000050: 88105000 e0021027 */  ldi rb0, 0x88105000
/* 00000058: 90104000 e0020727 */  ldi ra28, 0x90104000
/* 00000060: 90105000 e0021067 */  ldi rb1, 0x90105000
/* 00000068: 15827d80 10020827 */  mov r0, unif
/* 00000070: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000078: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000080: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000088: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 00000090: 159e7900 100202e7 */  mov ra11, r4
/* 00000098: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000a0: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000000a8: 159e7900 10020327 */  mov ra12, r4
/* 000000b0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000b8: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000000c0: 159e7900 10020367 */  mov ra13, r4
/* 000000c8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000d0: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000000d8: 159e7900 100203a7 */  mov ra14, r4
/* 000000e0: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000e8: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 000000f0: 159e7900 100203e7 */  mov ra15, r4
/* 000000f8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000100: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000108: 159e7900 100212e7 */  mov rb11, r4
/* 00000110: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000118: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000120: 159e7900 10021327 */  mov rb12, r4
/* 00000128: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000130: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000138: 159e7900 10021367 */  mov rb13, r4
/* 00000140: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000148: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000150: 159e7900 100213a7 */  mov rb14, r4
/* 00000158: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000160: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000168: 159e7900 100213e7 */  mov rb15, r4
/* 00000170: 15827d80 10020827 */  mov r0, unif
/* 00000178: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000180: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000188: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000190: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 00000198: 159e7900 10020427 */  mov ra16, r4
/* 000001a0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000001a8: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 000001b0: 159e7900 10021427 */  mov rb16, r4
/* 000001b8: 15827d80 10021167 */  mov rb5, unif
/* 000001c0: 00101200 e0020827 */  ldi r0, 0x00101200
/* 000001c8: 00000010 e0020867 */  ldi r1, 0x00000010
/* 000001d0: 00000002 e00208a7 */  ldi r2, 0x00000002
/* 000001d8: 409c5017 100049e2 */  nop; mul24 r2, r2, rb5
/* 000001e0: cc9e7081 10024660 */  add ra25, r0, r2; v8adds r0, r0, r1
/* 000001e8: cc9e7081 100246a0 */  add ra26, r0, r2; v8adds r0, r0, r1
/* 000001f0: cc9e7081 100250a0 */  add rb2, r0, r2; v8adds r0, r0, r1
/* 000001f8: 0c9e7080 100211e7 */  add rb7, r0, r2
/* 00000200: 000000b0 f0f80127 */  brr ra4, +176 // 0x000002d0
/* 00000208: 009e7000 100009e7 */  nop
/* 00000210: 009e7000 100009e7 */  nop
/* 00000218: 009e7000 100009e7 */  nop
/* 00000220: 15667d80 10021c67 */  mov vw_setup, ra25
/* 00000228: 159e7000 10020c27 */  mov vpm, r0
/* 00000230: 159e7240 10020c27 */  mov vpm, r1
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
/* 000002b8: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 000002c0: c0001fc0 e0021c67 */  ldi vw_setup, 0xc0001fc0
/* 000002c8: 8c05cdf6 10024072 */  add ra1, ra1, rb28; mov vw_addr, ra1
/* 000002d0: 00000038 f0f81127 */  brr rb4, +56 // 0x00000328
/* 000002d8: 009e7000 100009e7 */  nop
/* 000002e0: 009e7000 100009e7 */  nop
/* 000002e8: 009e7000 100009e7 */  nop
/* 000002f0: 15667d80 10021c67 */  mov vw_setup, ra25
/* 000002f8: 159e7000 10020c27 */  mov vpm, r0
/* 00000300: 159e7240 10020c27 */  mov vpm, r1
/* 00000308: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 00000310: 009e7000 100009e7 */  nop
/* 00000318: 15667d80 10020c67 */  mov vr_setup, ra25
/* 00000320: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000328: 000000c8 f0f802a7 */  brr ra10, +200 // 0x00000410
/* 00000330: 009e7000 100009e7 */  nop
/* 00000338: 009e7000 100009e7 */  nop
/* 00000340: 009e7000 100009e7 */  nop
/* 00000348: 15667d80 10021c67 */  mov vw_setup, ra25
/* 00000350: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000358: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000360: 156a7d80 10021c67 */  mov vw_setup, ra26
/* 00000368: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000370: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000378: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000380: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000388: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000390: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000398: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000003a0: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000003a8: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000003b0: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000003b8: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000003c0: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000003c8: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000003d0: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 000003d8: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000003e0: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 000003e8: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 000003f0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000003f8: 15727d80 10021c67 */  mov vw_setup, ra28
/* 00000400: c0000fc0 e0021c67 */  ldi vw_setup, 0xc0000fc0
/* 00000408: 8c05cdf6 10024072 */  add ra1, ra1, rb28; mov vw_addr, ra1
/* 00000410: 00000050 f0f812a7 */  brr rb10, +80 // 0x00000480
/* 00000418: 009e7000 100009e7 */  nop
/* 00000420: 009e7000 100009e7 */  nop
/* 00000428: 009e7000 100009e7 */  nop
/* 00000430: 15667d80 10021c67 */  mov vw_setup, ra25
/* 00000438: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000440: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000448: 156a7d80 10021c67 */  mov vw_setup, ra26
/* 00000450: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000458: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000460: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 00000468: 009e7000 100009e7 */  nop
/* 00000470: 15667d80 10020c67 */  mov vr_setup, ra25
/* 00000478: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000480: 00000080 f0f801a7 */  brr ra6, +128 // 0x00000520
/* 00000488: 009e7000 100009e7 */  nop
/* 00000490: 009e7000 100009e7 */  nop
/* 00000498: 009e7000 100009e7 */  nop
/* 000004a0: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 000004a8: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000004b0: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000004b8: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000004c0: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000004c8: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000004d0: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000004d8: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000004e0: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000004e8: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000004f0: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000004f8: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000500: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000508: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000510: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000518: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000520: 000005f0 f0f811a7 */  brr rb6, +1520 // 0x00000b30
/* 00000528: 009e7000 100009e7 */  nop
/* 00000530: 009e7000 100009e7 */  nop
/* 00000538: 009e7000 100009e7 */  nop
/* 00000540: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000548: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 00000550: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 00000558: 009e7000 100009e7 */  nop
/* 00000560: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000568: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 00000570: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 00000578: 009e7000 100009e7 */  nop
/* 00000580: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000588: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 00000590: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 00000598: 009e7000 100009e7 */  nop
/* 000005a0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000005a8: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 000005b0: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 000005b8: 009e7000 100009e7 */  nop
/* 000005c0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000005c8: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 000005d0: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 000005d8: 009e7000 100009e7 */  nop
/* 000005e0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000005e8: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 000005f0: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 000005f8: 009e7000 100009e7 */  nop
/* 00000600: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000608: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 00000610: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 00000618: 009e7000 100009e7 */  nop
/* 00000620: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000628: 204a7030 1000d9c2 */  nop; fmul.zc ra2, ra18, r0
/* 00000630: 209d2039 1000c9e2 */  nop; fmul.zc r2, rb18, r1
/* 00000638: 22092cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb18, r0
/* 00000640: 204a7031 1000c9e1 */  nop; fmul.zc r1, ra18, r1
/* 00000648: 819ff2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 15
/* 00000650: 819f1400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 1
/* 00000658: 829ff609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 15
/* 00000660: 819f1449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 1
/* 00000668: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000670: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000678: 204e7030 1000d9c2 */  nop; fmul.zc ra2, ra19, r0
/* 00000680: 209d3039 1000c9e2 */  nop; fmul.zc r2, rb19, r1
/* 00000688: 22093cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb19, r0
/* 00000690: 204e7031 1000c9e1 */  nop; fmul.zc r1, ra19, r1
/* 00000698: 819fe2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 14
/* 000006a0: 819f2400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 2
/* 000006a8: 829fe609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 14
/* 000006b0: 819f2449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 2
/* 000006b8: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000006c0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000006c8: 20527030 1000d9c2 */  nop; fmul.zc ra2, ra20, r0
/* 000006d0: 209d4039 1000c9e2 */  nop; fmul.zc r2, rb20, r1
/* 000006d8: 22094cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb20, r0
/* 000006e0: 20527031 1000c9e1 */  nop; fmul.zc r1, ra20, r1
/* 000006e8: 819fc2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 12
/* 000006f0: 819f4400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 4
/* 000006f8: 829fc609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 12
/* 00000700: 819f4449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 4
/* 00000708: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000710: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000718: 20567030 1000d9c2 */  nop; fmul.zc ra2, ra21, r0
/* 00000720: 209d5039 1000c9e2 */  nop; fmul.zc r2, rb21, r1
/* 00000728: 22095cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb21, r0
/* 00000730: 20567031 1000c9e1 */  nop; fmul.zc r1, ra21, r1
/* 00000738: 819f82c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 8
/* 00000740: 819f8400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 8
/* 00000748: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000750: 829f8609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 8
/* 00000758: 819f8449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 8
/* 00000760: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000768: 8c15edf6 10024160 */  add ra5, ra5, rb30; mov r0, ra5
/* 00000770: 14767180 10020867 */  and r1, r0, ra29
/* 00000778: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000780: 14767180 10020827 */  and r0, r0, ra29
/* 00000788: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000790: 159e7040 10020827 */  or r0, r0, r1
/* 00000798: 147a7180 10020867 */  and r1, r0, ra30
/* 000007a0: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 000007a8: 147a7180 10020827 */  and r0, r0, ra30
/* 000007b0: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 000007b8: 159e7040 10020827 */  or r0, r0, r1
/* 000007c0: 147e7180 10020867 */  and r1, r0, ra31
/* 000007c8: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000007d0: 147e7180 10020827 */  and r0, r0, ra31
/* 000007d8: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 000007e0: 159e7040 10020827 */  or r0, r0, r1
/* 000007e8: 149da1c0 10020867 */  and r1, r0, rb26
/* 000007f0: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 000007f8: 149da1c0 10020827 */  and r0, r0, rb26
/* 00000800: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000808: 159e7040 10020827 */  or r0, r0, r1
/* 00000810: 119c11c0 d0020827 */  shl r0, r0, 1; nop
/* 00000818: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000820: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000828: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000830: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000838: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000840: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000848: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000850: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000858: 159e7900 10020867 */  mov r1, r4
/* 00000860: fffffda0 f0f80027 */  brr ra0, -608 // 0x00000620
/* 00000868: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000870: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000878: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000880: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000888: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000890: 14767180 10020867 */  and r1, r0, ra29
/* 00000898: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 000008a0: 14767180 10020827 */  and r0, r0, ra29
/* 000008a8: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 000008b0: 159e7040 10020827 */  or r0, r0, r1
/* 000008b8: 147a7180 10020867 */  and r1, r0, ra30
/* 000008c0: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 000008c8: 147a7180 10020827 */  and r0, r0, ra30
/* 000008d0: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 000008d8: 159e7040 10020827 */  or r0, r0, r1
/* 000008e0: 147e7180 10020867 */  and r1, r0, ra31
/* 000008e8: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000008f0: 147e7180 10020827 */  and r0, r0, ra31
/* 000008f8: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000900: 159e7040 10020827 */  or r0, r0, r1
/* 00000908: 149da1c0 10020867 */  and r1, r0, rb26
/* 00000910: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000918: 149da1c0 10020827 */  and r0, r0, rb26
/* 00000920: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000928: 159e7040 10020827 */  or r0, r0, r1
/* 00000930: 119c11c0 d0020827 */  shl r0, r0, 1; nop
/* 00000938: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000940: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000948: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000950: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000958: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000960: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000968: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000970: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000978: 159e7900 10020867 */  mov r1, r4
/* 00000980: fffffc80 f0f80027 */  brr ra0, -896 // 0x00000620
/* 00000988: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000990: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000998: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 000009a0: 20467006 100059c2 */  nop; fmul ra2, r0, ra17
/* 000009a8: 209d100f 100049e2 */  nop; fmul r2, r1, rb17
/* 000009b0: 2046700e 100049e3 */  nop; fmul r3, r1, ra17
/* 000009b8: 22091c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb17
/* 000009c0: 019e72c0 10020867 */  fadd r1, r1, r3
/* 000009c8: 00000000 f0f549e7 */  bra -, ra10+0
/* 000009d0: 95642ff6 10024642 */  mov ra25, rb2; mov rb2, ra25
/* 000009d8: 95687ff6 10024687 */  mov ra26, rb7; mov rb7, ra26
/* 000009e0: 95701ff6 10024701 */  mov ra28, rb1; mov rb1, ra28
/* 000009e8: 8c15edf6 10024160 */  add ra5, ra5, rb30; mov r0, ra5
/* 000009f0: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 000009f8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000a00: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000a08: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000a10: fffffbf0 f0f80027 */  brr ra0, -1040 // 0x00000620
/* 00000a18: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000a20: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000a28: 159e7900 10020867 */  mov r1, r4
/* 00000a30: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000a38: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000a40: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000a48: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000a50: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000a58: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000a60: fffffba0 f0f80027 */  brr ra0, -1120 // 0x00000620
/* 00000a68: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000a70: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000a78: 159e7900 10020867 */  mov r1, r4
/* 00000a80: 20467006 100059c2 */  nop; fmul ra2, r0, ra17
/* 00000a88: 209d100f 100049e2 */  nop; fmul r2, r1, rb17
/* 00000a90: 2046700e 100049e3 */  nop; fmul r3, r1, ra17
/* 00000a98: 22091c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb17
/* 00000aa0: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00000aa8: 00000000 f0f549e7 */  bra -, ra10+0
/* 00000ab0: 95642ff6 10024642 */  mov ra25, rb2; mov rb2, ra25
/* 00000ab8: 95687ff6 10024687 */  mov ra26, rb7; mov rb7, ra26
/* 00000ac0: 95701ff6 10024701 */  mov ra28, rb1; mov rb1, ra28
/* 00000ac8: 8c15ddf6 10024160 */  add ra5, ra5, rb29; mov r0, ra5
/* 00000ad0: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000ad8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000ae0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000ae8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000af0: fffffb10 f0f80027 */  brr ra0, -1264 // 0x00000620
/* 00000af8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000b00: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000b08: 159e7900 10020867 */  mov r1, r4
/* 00000b10: 00000000 f0f489e7 */  bra -, ra4+0
/* 00000b18: 009e7000 100009e7 */  nop
/* 00000b20: 95642ff6 10024642 */  mov ra25, rb2; mov rb2, ra25
/* 00000b28: 956c0ff6 100246c0 */  mov ra27, rb0; mov rb0, ra27
/* 00000b30: 159c5fc0 10022827 */  mov.setf r0, rb5
/* 00000b38: 0d9c11c0 d0020827 */  sub r0, r0, 1; nop
/* 00000b40: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000b48: 0c9c6e00 100601a7 */  add.zc ra6, rb6, r0
/* 00000b50: 159c4fc0 10060127 */  mov.zc ra4, rb4
/* 00000b58: 159cafc0 100602a7 */  mov.zc ra10, rb10
/* 00000b60: 15827d80 100220e7 */  mov.setf ra3, unif
/* 00000b68: 15827d80 100210e7 */  mov rb3, unif
/* 00000b70: 000005e0 f00809e7 */  brr.allz -, +1504 // 0x00001170
/* 00000b78: 952cbdbf 10024451 */  mov ra17, ra11; mov rb17, rb11
/* 00000b80: 9530cdbf 100248a3 */  mov r2, ra12; mov r3, rb12
/* 00000b88: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000b90: 959f8492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 8
/* 00000b98: 959f86db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 8
/* 00000ba0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000ba8: 959f4492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 4
/* 00000bb0: 959f46db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 4
/* 00000bb8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000bc0: 959f2492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 2
/* 00000bc8: 959f26db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 2
/* 00000bd0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000bd8: 959f1492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 1
/* 00000be0: 959f16db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 1
/* 00000be8: 159c5fc0 10020827 */  mov r0, rb5
/* 00000bf0: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000bf8: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000c00: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000c08: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000c10: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000c18: 14767180 10020867 */  and r1, r0, ra29
/* 00000c20: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000c28: 14767180 10020827 */  and r0, r0, ra29
/* 00000c30: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000c38: 159e7040 10020827 */  or r0, r0, r1
/* 00000c40: 147a7180 10020867 */  and r1, r0, ra30
/* 00000c48: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000c50: 147a7180 10020827 */  and r0, r0, ra30
/* 00000c58: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000c60: 159e7040 10020827 */  or r0, r0, r1
/* 00000c68: 147e7180 10020867 */  and r1, r0, ra31
/* 00000c70: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000c78: 147e7180 10020827 */  and r0, r0, ra31
/* 00000c80: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000c88: 159e7040 10020827 */  or r0, r0, r1
/* 00000c90: 149da1c0 10020867 */  and r1, r0, rb26
/* 00000c98: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000ca0: 149da1c0 10020827 */  and r0, r0, rb26
/* 00000ca8: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000cb0: 159e7040 10020827 */  or r0, r0, r1
/* 00000cb8: 119c11c0 d0020827 */  shl r0, r0, 1; nop
/* 00000cc0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000cc8: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000cd0: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000cd8: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000ce0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000ce8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000cf0: fffffa58 f0f80227 */  brr ra8, -1448 // 0x00000768
/* 00000cf8: 009e7000 100009e7 */  nop
/* 00000d00: 009e7000 100009e7 */  nop
/* 00000d08: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000d10: 0e1cedc0 d00229e7 */  shr.setf -, ra7, 14; nop
/* 00000d18: fffffa30 f00809e7 */  brr.allz -, -1488 // 0x00000768
/* 00000d20: 009e7000 100009e7 */  nop
/* 00000d28: 009e7000 100009e7 */  nop
/* 00000d30: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000d38: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000d40: 009e7000 100009e7 */  nop
/* 00000d48: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000d50: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000d58: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00000d60: 952cbdbf 10024451 */  mov ra17, ra11; mov rb17, rb11
/* 00000d68: 9530cdbf 100248a3 */  mov r2, ra12; mov r3, rb12
/* 00000d70: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000d78: 959f8492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 8
/* 00000d80: 959f86db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 8
/* 00000d88: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000d90: 959f4492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 4
/* 00000d98: 959f46db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 4
/* 00000da0: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000da8: 959f2492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 2
/* 00000db0: 959f26db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 2
/* 00000db8: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000dc0: 959f1492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 1
/* 00000dc8: 959f16db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 1
/* 00000dd0: 159c5fc0 10020827 */  mov r0, rb5
/* 00000dd8: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000de0: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000de8: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000df0: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000df8: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000e00: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000e08: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000e10: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000e18: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000e20: fffffba8 f0f80227 */  brr ra8, -1112 // 0x000009e8
/* 00000e28: 009e7000 100009e7 */  nop
/* 00000e30: 009e7000 100009e7 */  nop
/* 00000e38: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000e40: fffffb88 f0f80227 */  brr ra8, -1144 // 0x000009e8
/* 00000e48: 009e7000 100009e7 */  nop
/* 00000e50: 009e7000 100009e7 */  nop
/* 00000e58: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000e60: 95451dbf 100248a3 */  mov r2, ra17; mov r3, rb17
/* 00000e68: 20367016 100049e0 */  nop; fmul r0, r2, ra13
/* 00000e70: 209cd017 100049e1 */  nop; fmul r1, r2, rb13
/* 00000e78: 209cd01f 100049e2 */  nop; fmul r2, r3, rb13
/* 00000e80: 2136709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra13
/* 00000e88: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000e90: 02467c80 10020467 */  fsub ra17, ra17, r2
/* 00000e98: 029d1ec0 10021467 */  fsub rb17, rb17, r3
/* 00000ea0: 95555dbf 100248a3 */  mov r2, ra21; mov r3, rb21
/* 00000ea8: 203a7016 100049e0 */  nop; fmul r0, r2, ra14
/* 00000eb0: 209ce017 100049e1 */  nop; fmul r1, r2, rb14
/* 00000eb8: 209ce01f 100049e2 */  nop; fmul r2, r3, rb14
/* 00000ec0: 213a709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra14
/* 00000ec8: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000ed0: 02567c80 100208a7 */  fsub r2, ra21, r2
/* 00000ed8: 029d5ec0 100208e7 */  fsub r3, rb21, r3
/* 00000ee0: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000ee8: 959f8492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 8
/* 00000ef0: 959f86db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 8
/* 00000ef8: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000f00: 959f4492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 4
/* 00000f08: 959f46db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 4
/* 00000f10: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000f18: 959f2492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 2
/* 00000f20: 959f26db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 2
/* 00000f28: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000f30: 959f1492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 1
/* 00000f38: 959f16db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 1
/* 00000f40: 0e1cedc0 d00229e7 */  shr.setf -, ra7, 14; nop
/* 00000f48: fffffa80 f00809e7 */  brr.allz -, -1408 // 0x000009e8
/* 00000f50: 00000020 e0020827 */  ldi r0, 0x00000020
/* 00000f58: 0d227c00 10020227 */  sub ra8, ra8, r0
/* 00000f60: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000f68: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000f70: 009e7000 100009e7 */  nop
/* 00000f78: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000f80: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000f88: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00000f90: 95410dbf 100248a3 */  mov r2, ra16; mov r3, rb16
/* 00000f98: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000fa0: 959f8492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 8
/* 00000fa8: 959f86db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 8
/* 00000fb0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000fb8: 959f4492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 4
/* 00000fc0: 959f46db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 4
/* 00000fc8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000fd0: 959f2492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 2
/* 00000fd8: 959f26db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 2
/* 00000fe0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000fe8: 959f1492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 1
/* 00000ff0: 959f16db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 1
/* 00000ff8: 159c5fc0 10020827 */  mov r0, rb5
/* 00001000: 119c41c0 d0020827 */  shl r0, r0, 4; nop
/* 00001008: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00001010: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00001018: 159c3fc0 10020067 */  mov ra1, rb3
/* 00001020: 8c15ddf6 10024160 */  add ra5, ra5, rb29; mov r0, ra5
/* 00001028: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00001030: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00001038: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00001040: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00001048: fffffa60 f0f80227 */  brr ra8, -1440 // 0x00000ac8
/* 00001050: 009e7000 100009e7 */  nop
/* 00001058: 009e7000 100009e7 */  nop
/* 00001060: 0c1dddc0 100201e7 */  add ra7, ra7, rb29
/* 00001068: 95555dbf 100248a3 */  mov r2, ra21; mov r3, rb21
/* 00001070: 203e7016 100049e0 */  nop; fmul r0, r2, ra15
/* 00001078: 209cf017 100049e1 */  nop; fmul r1, r2, rb15
/* 00001080: 209cf01f 100049e2 */  nop; fmul r2, r3, rb15
/* 00001088: 213e709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra15
/* 00001090: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00001098: 02567c80 100208a7 */  fsub r2, ra21, r2
/* 000010a0: 029d5ec0 100208e7 */  fsub r3, rb21, r3
/* 000010a8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000010b0: 959f8492 d002c562 */  mov ra21, r2; mov.zc r2, r2 >> 8
/* 000010b8: 959f86db d002d563 */  mov rb21, r3; mov.zc r3, r3 >> 8
/* 000010c0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000010c8: 959f4492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 4
/* 000010d0: 959f46db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 4
/* 000010d8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 000010e0: 959f2492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 2
/* 000010e8: 959f26db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 2
/* 000010f0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 000010f8: 959f1492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 1
/* 00001100: 959f16db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 1
/* 00001108: 0e1cedc0 d00229e7 */  shr.setf -, ra7, 14; nop
/* 00001110: fffff998 f00809e7 */  brr.allz -, -1640 // 0x00000ac8
/* 00001118: 009e7000 100009e7 */  nop
/* 00001120: 009e7000 100009e7 */  nop
/* 00001128: 0c1dddc0 100201e7 */  add ra7, ra7, rb29
/* 00001130: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00001138: 009e7000 100009e7 */  nop
/* 00001140: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00001148: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00001150: fffff9f0 f0f809e7 */  brr -, -1552 // 0x00000b60
/* 00001158: 009e7000 100009e7 */  nop
/* 00001160: 009e7000 100009e7 */  nop
/* 00001168: 009e7000 100009e7 */  nop
/* 00001170: 159c3fc0 100209a7 */  mov irq, rb3
/* 00001178: 009e7000 300009e7 */  nop; nop; thrend
/* 00001180: 009e7000 100009e7 */  nop
/* 00001188: 009e7000 100009e7 */  nop


