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

shader_8k:
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
/* 000000e0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000e8: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 000000f0: 159e7900 100212e7 */  mov rb11, r4
/* 000000f8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000100: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000108: 159e7900 10021327 */  mov rb12, r4
/* 00000110: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000118: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000120: 159e7900 10021367 */  mov rb13, r4
/* 00000128: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000130: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000138: 159e7900 100213a7 */  mov rb14, r4
/* 00000140: 15827d80 10020827 */  mov r0, unif
/* 00000148: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000150: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000158: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000160: 0c9dd1c0 a0020827 */  add r0, r0, rb29; nop; ldtmu0
/* 00000168: 159e7900 100203e7 */  mov ra15, r4
/* 00000170: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000178: 0c9dd3c0 a0020867 */  add r1, r1, rb29; nop; ldtmu0
/* 00000180: 159e7900 100213e7 */  mov rb15, r4
/* 00000188: 15827d80 10021167 */  mov rb5, unif
/* 00000190: 00101200 e0020827 */  ldi r0, 0x00101200
/* 00000198: 00000010 e0020867 */  ldi r1, 0x00000010
/* 000001a0: 00000002 e00208a7 */  ldi r2, 0x00000002
/* 000001a8: 409c5017 100049e2 */  nop; mul24 r2, r2, rb5
/* 000001b0: cc9e7081 10024660 */  add ra25, r0, r2; v8adds r0, r0, r1
/* 000001b8: cc9e7081 100246a0 */  add ra26, r0, r2; v8adds r0, r0, r1
/* 000001c0: cc9e7081 100250a0 */  add rb2, r0, r2; v8adds r0, r0, r1
/* 000001c8: 0c9e7080 100211e7 */  add rb7, r0, r2
/* 000001d0: 000000b0 f0f80127 */  brr ra4, +176 // 0x000002a0
/* 000001d8: 009e7000 100009e7 */  nop
/* 000001e0: 009e7000 100009e7 */  nop
/* 000001e8: 009e7000 100009e7 */  nop
/* 000001f0: 15667d80 10021c67 */  mov vw_setup, ra25
/* 000001f8: 159e7000 10020c27 */  mov vpm, r0
/* 00000200: 159e7240 10020c27 */  mov vpm, r1
/* 00000208: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000210: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000218: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000220: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000228: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000230: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000238: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000240: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000248: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000250: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000258: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000260: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000268: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000270: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000278: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000280: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000288: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 00000290: c0000fc0 e0021c67 */  ldi vw_setup, 0xc0000fc0
/* 00000298: 8c05cdf6 10024072 */  add ra1, ra1, rb28; mov vw_addr, ra1
/* 000002a0: 00000038 f0f81127 */  brr rb4, +56 // 0x000002f8
/* 000002a8: 009e7000 100009e7 */  nop
/* 000002b0: 009e7000 100009e7 */  nop
/* 000002b8: 009e7000 100009e7 */  nop
/* 000002c0: 15667d80 10021c67 */  mov vw_setup, ra25
/* 000002c8: 159e7000 10020c27 */  mov vpm, r0
/* 000002d0: 159e7240 10020c27 */  mov vpm, r1
/* 000002d8: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 000002e0: 009e7000 100009e7 */  nop
/* 000002e8: 15667d80 10020c67 */  mov vr_setup, ra25
/* 000002f0: 15c27d80 100009e7 */  mov.never -, vpm
/* 000002f8: 000000c8 f0f802a7 */  brr ra10, +200 // 0x000003e0
/* 00000300: 009e7000 100009e7 */  nop
/* 00000308: 009e7000 100009e7 */  nop
/* 00000310: 009e7000 100009e7 */  nop
/* 00000318: 15667d80 10021c67 */  mov vw_setup, ra25
/* 00000320: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000328: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000330: 156a7d80 10021c67 */  mov vw_setup, ra26
/* 00000338: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000340: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000348: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000350: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000358: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000360: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000368: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000370: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 00000378: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000380: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000388: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000390: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000398: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000003a0: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 000003a8: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000003b0: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 000003b8: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 000003c0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000003c8: 15727d80 10021c67 */  mov vw_setup, ra28
/* 000003d0: c00007c0 e0021c67 */  ldi vw_setup, 0xc00007c0
/* 000003d8: 8c05cdf6 10024072 */  add ra1, ra1, rb28; mov vw_addr, ra1
/* 000003e0: 00000050 f0f812a7 */  brr rb10, +80 // 0x00000450
/* 000003e8: 009e7000 100009e7 */  nop
/* 000003f0: 009e7000 100009e7 */  nop
/* 000003f8: 009e7000 100009e7 */  nop
/* 00000400: 15667d80 10021c67 */  mov vw_setup, ra25
/* 00000408: 01267c00 10020c27 */  fadd vpm, ra9, r0
/* 00000410: 019c9e40 10020c27 */  fadd vpm, rb9, r1
/* 00000418: 156a7d80 10021c67 */  mov vw_setup, ra26
/* 00000420: 02267c00 10020c27 */  fsub vpm, ra9, r0
/* 00000428: 029c9e40 10020c27 */  fsub vpm, rb9, r1
/* 00000430: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 00000438: 009e7000 100009e7 */  nop
/* 00000440: 15667d80 10020c67 */  mov vr_setup, ra25
/* 00000448: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000450: 00000080 f0f801a7 */  brr ra6, +128 // 0x000004f0
/* 00000458: 009e7000 100009e7 */  nop
/* 00000460: 009e7000 100009e7 */  nop
/* 00000468: 009e7000 100009e7 */  nop
/* 00000470: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000478: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000480: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000488: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000490: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 00000498: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000004a0: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000004a8: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000004b0: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000004b8: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000004c0: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000004c8: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 000004d0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000004d8: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000004e0: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 000004e8: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 000004f0: 00000500 f0f811a7 */  brr rb6, +1280 // 0x00000a10
/* 000004f8: 009e7000 100009e7 */  nop
/* 00000500: 009e7000 100009e7 */  nop
/* 00000508: 009e7000 100009e7 */  nop
/* 00000510: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000518: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 00000520: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 00000528: 009e7000 100009e7 */  nop
/* 00000530: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000538: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 00000540: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 00000548: 009e7000 100009e7 */  nop
/* 00000550: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000558: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 00000560: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 00000568: 009e7000 100009e7 */  nop
/* 00000570: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000578: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 00000580: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 00000588: 009e7000 100009e7 */  nop
/* 00000590: 00000000 f0f509e7 */  bra -, ra8+0
/* 00000598: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 000005a0: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 000005a8: 009e7000 100009e7 */  nop
/* 000005b0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000005b8: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 000005c0: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 000005c8: 009e7000 100009e7 */  nop
/* 000005d0: 00000000 f0f509e7 */  bra -, ra8+0
/* 000005d8: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 000005e0: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 000005e8: 009e7000 100009e7 */  nop
/* 000005f0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 000005f8: 20467030 1000d9c2 */  nop; fmul.zc ra2, ra17, r0
/* 00000600: 209d1039 1000c9e2 */  nop; fmul.zc r2, rb17, r1
/* 00000608: 22091cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb17, r0
/* 00000610: 20467031 1000c9e1 */  nop; fmul.zc r1, ra17, r1
/* 00000618: 819ff2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 15
/* 00000620: 819f1400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 1
/* 00000628: 829ff609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 15
/* 00000630: 819f1449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 1
/* 00000638: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000640: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000648: 204a7030 1000d9c2 */  nop; fmul.zc ra2, ra18, r0
/* 00000650: 209d2039 1000c9e2 */  nop; fmul.zc r2, rb18, r1
/* 00000658: 22092cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb18, r0
/* 00000660: 204a7031 1000c9e1 */  nop; fmul.zc r1, ra18, r1
/* 00000668: 819fe2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 14
/* 00000670: 819f2400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 2
/* 00000678: 829fe609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 14
/* 00000680: 819f2449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 2
/* 00000688: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000690: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000698: 204e7030 1000d9c2 */  nop; fmul.zc ra2, ra19, r0
/* 000006a0: 209d3039 1000c9e2 */  nop; fmul.zc r2, rb19, r1
/* 000006a8: 22093cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb19, r0
/* 000006b0: 204e7031 1000c9e1 */  nop; fmul.zc r1, ra19, r1
/* 000006b8: 819fc2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 12
/* 000006c0: 819f4400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 4
/* 000006c8: 829fc609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 12
/* 000006d0: 819f4449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 4
/* 000006d8: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000006e0: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000006e8: 20527030 1000d9c2 */  nop; fmul.zc ra2, ra20, r0
/* 000006f0: 209d4039 1000c9e2 */  nop; fmul.zc r2, rb20, r1
/* 000006f8: 22094cb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb20, r0
/* 00000700: 20527031 1000c9e1 */  nop; fmul.zc r1, ra20, r1
/* 00000708: 819f82c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 8
/* 00000710: 819f8400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 8
/* 00000718: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000720: 829f8609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 8
/* 00000728: 819f8449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 8
/* 00000730: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000738: 8c15edf6 10024160 */  add ra5, ra5, rb30; mov r0, ra5
/* 00000740: 14767180 10020867 */  and r1, r0, ra29
/* 00000748: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000750: 14767180 10020827 */  and r0, r0, ra29
/* 00000758: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000760: 159e7040 10020827 */  or r0, r0, r1
/* 00000768: 147a7180 10020867 */  and r1, r0, ra30
/* 00000770: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000778: 147a7180 10020827 */  and r0, r0, ra30
/* 00000780: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000788: 159e7040 10020827 */  or r0, r0, r1
/* 00000790: 147e7180 10020867 */  and r1, r0, ra31
/* 00000798: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000007a0: 147e7180 10020827 */  and r0, r0, ra31
/* 000007a8: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 000007b0: 159e7040 10020827 */  or r0, r0, r1
/* 000007b8: 149da1c0 10020867 */  and r1, r0, rb26
/* 000007c0: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 000007c8: 149da1c0 10020827 */  and r0, r0, rb26
/* 000007d0: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 000007d8: 159e7040 10020827 */  or r0, r0, r1
/* 000007e0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000007e8: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 000007f0: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 000007f8: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000800: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000808: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000810: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000818: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000820: 159e7900 10020867 */  mov r1, r4
/* 00000828: fffffda8 f0f80027 */  brr ra0, -600 // 0x000005f0
/* 00000830: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000838: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000840: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000848: 959e7009 10024249 */  mov ra9, r0; mov rb9, r1
/* 00000850: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000858: 14767180 10020867 */  and r1, r0, ra29
/* 00000860: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000868: 14767180 10020827 */  and r0, r0, ra29
/* 00000870: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000878: 159e7040 10020827 */  or r0, r0, r1
/* 00000880: 147a7180 10020867 */  and r1, r0, ra30
/* 00000888: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000890: 147a7180 10020827 */  and r0, r0, ra30
/* 00000898: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 000008a0: 159e7040 10020827 */  or r0, r0, r1
/* 000008a8: 147e7180 10020867 */  and r1, r0, ra31
/* 000008b0: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000008b8: 147e7180 10020827 */  and r0, r0, ra31
/* 000008c0: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 000008c8: 159e7040 10020827 */  or r0, r0, r1
/* 000008d0: 149da1c0 10020867 */  and r1, r0, rb26
/* 000008d8: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 000008e0: 149da1c0 10020827 */  and r0, r0, rb26
/* 000008e8: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 000008f0: 159e7040 10020827 */  or r0, r0, r1
/* 000008f8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000900: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000908: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000910: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000918: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000920: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000928: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000930: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000938: 159e7900 10020867 */  mov r1, r4
/* 00000940: fffffc90 f0f80027 */  brr ra0, -880 // 0x000005f0
/* 00000948: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000950: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000958: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000960: 20427006 100059c2 */  nop; fmul ra2, r0, ra16
/* 00000968: 209d000f 100049e2 */  nop; fmul r2, r1, rb16
/* 00000970: 2042700e 100049e3 */  nop; fmul r3, r1, ra16
/* 00000978: 22090c87 10024821 */  fsub r0, ra2, r2; fmul r1, r0, rb16
/* 00000980: 019e72c0 10020867 */  fadd r1, r1, r3
/* 00000988: 00000000 f0f549e7 */  bra -, ra10+0
/* 00000990: 95642ff6 10024642 */  mov ra25, rb2; mov rb2, ra25
/* 00000998: 95687ff6 10024687 */  mov ra26, rb7; mov rb7, ra26
/* 000009a0: 95701ff6 10024701 */  mov ra28, rb1; mov rb1, ra28
/* 000009a8: 8c15ddf6 10024160 */  add ra5, ra5, rb29; mov r0, ra5
/* 000009b0: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 000009b8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000009c0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 000009c8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000009d0: fffffc00 f0f80027 */  brr ra0, -1024 // 0x000005f0
/* 000009d8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000009e0: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 000009e8: 159e7900 10020867 */  mov r1, r4
/* 000009f0: 00000000 f0f489e7 */  bra -, ra4+0
/* 000009f8: 009e7000 100009e7 */  nop
/* 00000a00: 95642ff6 10024642 */  mov ra25, rb2; mov rb2, ra25
/* 00000a08: 956c0ff6 100246c0 */  mov ra27, rb0; mov rb0, ra27
/* 00000a10: 159c5fc0 10022827 */  mov.setf r0, rb5
/* 00000a18: 0d9c11c0 d0020827 */  sub r0, r0, 1; nop
/* 00000a20: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000a28: 0c9c6e00 100601a7 */  add.zc ra6, rb6, r0
/* 00000a30: 159c4fc0 10060127 */  mov.zc ra4, rb4
/* 00000a38: 159cafc0 100602a7 */  mov.zc ra10, rb10
/* 00000a40: 15827d80 100220e7 */  mov.setf ra3, unif
/* 00000a48: 15827d80 100210e7 */  mov rb3, unif
/* 00000a50: 00000590 f00809e7 */  brr.allz -, +1424 // 0x00001000
/* 00000a58: 952cbdbf 10024410 */  mov ra16, ra11; mov rb16, rb11
/* 00000a60: 9530cdbf 100248a3 */  mov r2, ra12; mov r3, rb12
/* 00000a68: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000a70: 959f8492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 8
/* 00000a78: 959f86db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 8
/* 00000a80: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000a88: 959f4492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 4
/* 00000a90: 959f46db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 4
/* 00000a98: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000aa0: 959f2492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 2
/* 00000aa8: 959f26db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 2
/* 00000ab0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000ab8: 959f1492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 1
/* 00000ac0: 959f16db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 1
/* 00000ac8: 159c5fc0 10020827 */  mov r0, rb5
/* 00000ad0: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000ad8: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000ae0: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000ae8: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000af0: 8c15bdf6 10024160 */  add ra5, ra5, rb27; mov r0, ra5
/* 00000af8: 14767180 10020867 */  and r1, r0, ra29
/* 00000b00: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000b08: 14767180 10020827 */  and r0, r0, ra29
/* 00000b10: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000b18: 159e7040 10020827 */  or r0, r0, r1
/* 00000b20: 147a7180 10020867 */  and r1, r0, ra30
/* 00000b28: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000b30: 147a7180 10020827 */  and r0, r0, ra30
/* 00000b38: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000b40: 159e7040 10020827 */  or r0, r0, r1
/* 00000b48: 147e7180 10020867 */  and r1, r0, ra31
/* 00000b50: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000b58: 147e7180 10020827 */  and r0, r0, ra31
/* 00000b60: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000b68: 159e7040 10020827 */  or r0, r0, r1
/* 00000b70: 149da1c0 10020867 */  and r1, r0, rb26
/* 00000b78: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000b80: 149da1c0 10020827 */  and r0, r0, rb26
/* 00000b88: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000b90: 159e7040 10020827 */  or r0, r0, r1
/* 00000b98: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000ba0: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000ba8: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000bb0: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000bb8: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000bc0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000bc8: fffffb50 f0f80227 */  brr ra8, -1200 // 0x00000738
/* 00000bd0: 009e7000 100009e7 */  nop
/* 00000bd8: 009e7000 100009e7 */  nop
/* 00000be0: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000be8: 0e1cddc0 d00229e7 */  shr.setf -, ra7, 13; nop
/* 00000bf0: fffffb28 f00809e7 */  brr.allz -, -1240 // 0x00000738
/* 00000bf8: 009e7000 100009e7 */  nop
/* 00000c00: 009e7000 100009e7 */  nop
/* 00000c08: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000c10: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000c18: 009e7000 100009e7 */  nop
/* 00000c20: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000c28: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000c30: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00000c38: 9530cdbf 100248a3 */  mov r2, ra12; mov r3, rb12
/* 00000c40: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000c48: 959f8492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 8
/* 00000c50: 959f86db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 8
/* 00000c58: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000c60: 959f4492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 4
/* 00000c68: 959f46db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 4
/* 00000c70: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000c78: 959f2492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 2
/* 00000c80: 959f26db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 2
/* 00000c88: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000c90: 959f1492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 1
/* 00000c98: 959f16db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 1
/* 00000ca0: 159c5fc0 10020827 */  mov r0, rb5
/* 00000ca8: 119c41c0 d0020827 */  shl r0, r0, 4; nop
/* 00000cb0: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000cb8: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000cc0: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000cc8: 8c15ddf6 10024160 */  add ra5, ra5, rb29; mov r0, ra5
/* 00000cd0: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000cd8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000ce0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000ce8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000cf0: fffffc98 f0f80227 */  brr ra8, -872 // 0x000009a8
/* 00000cf8: 009e7000 100009e7 */  nop
/* 00000d00: 009e7000 100009e7 */  nop
/* 00000d08: 0c1dddc0 100201e7 */  add ra7, ra7, rb29
/* 00000d10: fffffc78 f0f80227 */  brr ra8, -904 // 0x000009a8
/* 00000d18: 009e7000 100009e7 */  nop
/* 00000d20: 009e7000 100009e7 */  nop
/* 00000d28: 0c1dddc0 100201e7 */  add ra7, ra7, rb29
/* 00000d30: 95514dbf 100248a3 */  mov r2, ra20; mov r3, rb20
/* 00000d38: 20367016 100049e0 */  nop; fmul r0, r2, ra13
/* 00000d40: 209cd017 100049e1 */  nop; fmul r1, r2, rb13
/* 00000d48: 209cd01f 100049e2 */  nop; fmul r2, r3, rb13
/* 00000d50: 2136709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra13
/* 00000d58: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000d60: 02527c80 100208a7 */  fsub r2, ra20, r2
/* 00000d68: 029d4ec0 100208e7 */  fsub r3, rb20, r3
/* 00000d70: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000d78: 959f8492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 8
/* 00000d80: 959f86db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 8
/* 00000d88: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000d90: 959f4492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 4
/* 00000d98: 959f46db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 4
/* 00000da0: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000da8: 959f2492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 2
/* 00000db0: 959f26db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 2
/* 00000db8: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000dc0: 959f1492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 1
/* 00000dc8: 959f16db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 1
/* 00000dd0: 0e1cddc0 d00229e7 */  shr.setf -, ra7, 13; nop
/* 00000dd8: fffffbb0 f00809e7 */  brr.allz -, -1104 // 0x000009a8
/* 00000de0: 00000020 e0020827 */  ldi r0, 0x00000020
/* 00000de8: 0d227c00 10020227 */  sub ra8, ra8, r0
/* 00000df0: 0c1dddc0 100201e7 */  add ra7, ra7, rb29
/* 00000df8: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000e00: 009e7000 100009e7 */  nop
/* 00000e08: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000e10: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000e18: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00000e20: 953cfdbf 100248a3 */  mov r2, ra15; mov r3, rb15
/* 00000e28: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000e30: 959f8492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 8
/* 00000e38: 959f86db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 8
/* 00000e40: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000e48: 959f4492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 4
/* 00000e50: 959f46db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 4
/* 00000e58: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000e60: 959f2492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 2
/* 00000e68: 959f26db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 2
/* 00000e70: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000e78: 959f1492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 1
/* 00000e80: 959f16db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 1
/* 00000e88: 159c5fc0 10020827 */  mov r0, rb5
/* 00000e90: 119c41c0 d0020827 */  shl r0, r0, 4; nop
/* 00000e98: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000ea0: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000ea8: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000eb0: 8c15ddf6 10024160 */  add ra5, ra5, rb29; mov r0, ra5
/* 00000eb8: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000ec0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000ec8: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000ed0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000ed8: fffffab0 f0f80227 */  brr ra8, -1360 // 0x000009a8
/* 00000ee0: 009e7000 100009e7 */  nop
/* 00000ee8: 009e7000 100009e7 */  nop
/* 00000ef0: 0c1dddc0 100201e7 */  add ra7, ra7, rb29
/* 00000ef8: 95514dbf 100248a3 */  mov r2, ra20; mov r3, rb20
/* 00000f00: 203a7016 100049e0 */  nop; fmul r0, r2, ra14
/* 00000f08: 209ce017 100049e1 */  nop; fmul r1, r2, rb14
/* 00000f10: 209ce01f 100049e2 */  nop; fmul r2, r3, rb14
/* 00000f18: 213a709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra14
/* 00000f20: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000f28: 02527c80 100208a7 */  fsub r2, ra20, r2
/* 00000f30: 029d4ec0 100208e7 */  fsub r3, rb20, r3
/* 00000f38: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000f40: 959f8492 d002c522 */  mov ra20, r2; mov.zc r2, r2 >> 8
/* 00000f48: 959f86db d002d523 */  mov rb20, r3; mov.zc r3, r3 >> 8
/* 00000f50: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000f58: 959f4492 d002c4e2 */  mov ra19, r2; mov.zc r2, r2 >> 4
/* 00000f60: 959f46db d002d4e3 */  mov rb19, r3; mov.zc r3, r3 >> 4
/* 00000f68: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000f70: 959f2492 d002c4a2 */  mov ra18, r2; mov.zc r2, r2 >> 2
/* 00000f78: 959f26db d002d4a3 */  mov rb18, r3; mov.zc r3, r3 >> 2
/* 00000f80: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000f88: 959f1492 d002c462 */  mov ra17, r2; mov.zc r2, r2 >> 1
/* 00000f90: 959f16db d002d463 */  mov rb17, r3; mov.zc r3, r3 >> 1
/* 00000f98: 0e1cddc0 d00229e7 */  shr.setf -, ra7, 13; nop
/* 00000fa0: fffff9e8 f00809e7 */  brr.allz -, -1560 // 0x000009a8
/* 00000fa8: 009e7000 100009e7 */  nop
/* 00000fb0: 009e7000 100009e7 */  nop
/* 00000fb8: 0c1dddc0 100201e7 */  add ra7, ra7, rb29
/* 00000fc0: 00000000 f0f4c227 */  bra ra8, ra6+0
/* 00000fc8: 009e7000 100009e7 */  nop
/* 00000fd0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000fd8: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000fe0: fffffa40 f0f809e7 */  brr -, -1472 // 0x00000a40
/* 00000fe8: 009e7000 100009e7 */  nop
/* 00000ff0: 009e7000 100009e7 */  nop
/* 00000ff8: 009e7000 100009e7 */  nop
/* 00001000: 159c3fc0 100209a7 */  mov irq, rb3
/* 00001008: 009e7000 300009e7 */  nop; nop; thrend
/* 00001010: 009e7000 100009e7 */  nop
/* 00001018: 009e7000 100009e7 */  nop


