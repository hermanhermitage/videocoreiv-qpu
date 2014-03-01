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

shader_256:
/* 00000000: 00000040 e00217a7 */  ldi rb30, 0x00000040
/* 00000008: 00000080 e00217e7 */  ldi rb31, 0x00000080
/* 00000010: 00005555 e0020767 */  ldi ra29, 0x00005555
/* 00000018: 00003333 e00207a7 */  ldi ra30, 0x00003333
/* 00000020: 00000f0f e00207e7 */  ldi ra31, 0x00000f0f
/* 00000028: 88104000 e0020727 */  ldi ra28, 0x88104000
/* 00000030: 88104800 e0021727 */  ldi rb28, 0x88104800
/* 00000038: 15827d80 10020827 */  mov r0, unif
/* 00000040: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000048: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000050: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000058: 0c9df1c0 a0020827 */  add r0, r0, rb31; nop; ldtmu0
/* 00000060: 159e7900 10020227 */  mov ra8, r4
/* 00000068: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000070: 0c9df1c0 a0020827 */  add r0, r0, rb31; nop; ldtmu0
/* 00000078: 159e7900 10020267 */  mov ra9, r4
/* 00000080: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000088: 0c9df3c0 a0020867 */  add r1, r1, rb31; nop; ldtmu0
/* 00000090: 159e7900 10021227 */  mov rb8, r4
/* 00000098: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000a0: 0c9df3c0 a0020867 */  add r1, r1, rb31; nop; ldtmu0
/* 000000a8: 159e7900 10021267 */  mov rb9, r4
/* 000000b0: 15827d80 10020827 */  mov r0, unif
/* 000000b8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000000c0: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 000000c8: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 000000d0: 0c9df1c0 a0020827 */  add r0, r0, rb31; nop; ldtmu0
/* 000000d8: 159e7900 100202a7 */  mov ra10, r4
/* 000000e0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000e8: 0c9df3c0 a0020867 */  add r1, r1, rb31; nop; ldtmu0
/* 000000f0: 159e7900 100212a7 */  mov rb10, r4
/* 000000f8: 15827d80 10021167 */  mov rb5, unif
/* 00000100: 00101200 e0020827 */  ldi r0, 0x00101200
/* 00000108: 00000010 e0020867 */  ldi r1, 0x00000010
/* 00000110: 00000002 e00208a7 */  ldi r2, 0x00000002
/* 00000118: 409c5017 100049e2 */  nop; mul24 r2, r2, rb5
/* 00000120: cc9e7081 100246e0 */  add ra27, r0, r2; v8adds r0, r0, r1
/* 00000128: cc9e7081 100256e0 */  add rb27, r0, r2; v8adds r0, r0, r1
/* 00000130: cc9e7081 100049e0 */  add.never -, r0, r2; v8adds r0, r0, r1
/* 00000138: 0c9e7080 100009e7 */  add.never -, r0, r2
/* 00000140: 000000b0 f0f80127 */  brr ra4, +176 // 0x00000210
/* 00000148: 009e7000 100009e7 */  nop
/* 00000150: 009e7000 100009e7 */  nop
/* 00000158: 009e7000 100009e7 */  nop
/* 00000160: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 00000168: 159e7000 10020c27 */  mov vpm, r0
/* 00000170: 159e7240 10020c27 */  mov vpm, r1
/* 00000178: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000180: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000188: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 00000190: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 00000198: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000001a0: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000001a8: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000001b0: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000001b8: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000001c0: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000001c8: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000001d0: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 000001d8: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000001e0: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 000001e8: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 000001f0: 00000000 f0f409e7 */  bra -, ra0+0
/* 000001f8: 15727d80 10021c67 */  mov vw_setup, ra28
/* 00000200: c0000040 e0021c67 */  ldi vw_setup, 0xc0000040
/* 00000208: 8c05edf6 10024072 */  add ra1, ra1, rb30; mov vw_addr, ra1
/* 00000210: 00000038 f0f81127 */  brr rb4, +56 // 0x00000268
/* 00000218: 009e7000 100009e7 */  nop
/* 00000220: 009e7000 100009e7 */  nop
/* 00000228: 009e7000 100009e7 */  nop
/* 00000230: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 00000238: 159e7000 10020c27 */  mov vpm, r0
/* 00000240: 159e7240 10020c27 */  mov vpm, r1
/* 00000248: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 00000250: 009e7000 100009e7 */  nop
/* 00000258: 156e7d80 10020c67 */  mov vr_setup, ra27
/* 00000260: 15c27d80 100009e7 */  mov.never -, vpm
/* 00000268: 00000080 f0f801a7 */  brr ra6, +128 // 0x00000308
/* 00000270: 009e7000 100009e7 */  nop
/* 00000278: 009e7000 100009e7 */  nop
/* 00000280: 009e7000 100009e7 */  nop
/* 00000288: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 00000290: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 00000298: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000002a0: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000002a8: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000002b0: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000002b8: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000002c0: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000002c8: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 000002d0: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 000002d8: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 000002e0: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 000002e8: 00000000 f0f409e7 */  bra -, ra0+0
/* 000002f0: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 000002f8: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000300: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000308: 00000248 f0f811a7 */  brr rb6, +584 // 0x00000570
/* 00000310: 009e7000 100009e7 */  nop
/* 00000318: 009e7000 100009e7 */  nop
/* 00000320: 009e7000 100009e7 */  nop
/* 00000328: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000330: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 00000338: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 00000340: 009e7000 100009e7 */  nop
/* 00000348: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000350: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 00000358: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 00000360: 009e7000 100009e7 */  nop
/* 00000368: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000370: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 00000378: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 00000380: 009e7000 100009e7 */  nop
/* 00000388: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000390: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 00000398: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 000003a0: 009e7000 100009e7 */  nop
/* 000003a8: 00000000 f0f409e7 */  bra -, ra0+0
/* 000003b0: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 000003b8: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 000003c0: 009e7000 100009e7 */  nop
/* 000003c8: 00000000 f0f409e7 */  bra -, ra0+0
/* 000003d0: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 000003d8: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 000003e0: 009e7000 100009e7 */  nop
/* 000003e8: 00000000 f0f409e7 */  bra -, ra0+0
/* 000003f0: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 000003f8: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 00000400: 009e7000 100009e7 */  nop
/* 00000408: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000410: 202e7030 1000d9c2 */  nop; fmul.zc ra2, ra11, r0
/* 00000418: 209cb039 1000c9e2 */  nop; fmul.zc r2, rb11, r1
/* 00000420: 2208bcb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb11, r0
/* 00000428: 202e7031 1000c9e1 */  nop; fmul.zc r1, ra11, r1
/* 00000430: 819ff2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 15
/* 00000438: 819f1400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 1
/* 00000440: 829ff609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 15
/* 00000448: 819f1449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 1
/* 00000450: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000458: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000460: 20327030 1000d9c2 */  nop; fmul.zc ra2, ra12, r0
/* 00000468: 209cc039 1000c9e2 */  nop; fmul.zc r2, rb12, r1
/* 00000470: 2208ccb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb12, r0
/* 00000478: 20327031 1000c9e1 */  nop; fmul.zc r1, ra12, r1
/* 00000480: 819fe2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 14
/* 00000488: 819f2400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 2
/* 00000490: 829fe609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 14
/* 00000498: 819f2449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 2
/* 000004a0: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000004a8: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000004b0: 20367030 1000d9c2 */  nop; fmul.zc ra2, ra13, r0
/* 000004b8: 209cd039 1000c9e2 */  nop; fmul.zc r2, rb13, r1
/* 000004c0: 2208dcb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb13, r0
/* 000004c8: 20367031 1000c9e1 */  nop; fmul.zc r1, ra13, r1
/* 000004d0: 819fc2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 12
/* 000004d8: 819f4400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 4
/* 000004e0: 829fc609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 12
/* 000004e8: 819f4449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 4
/* 000004f0: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000004f8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000500: 203a7030 1000d9c2 */  nop; fmul.zc ra2, ra14, r0
/* 00000508: 209ce039 1000c9e2 */  nop; fmul.zc r2, rb14, r1
/* 00000510: 2208ecb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb14, r0
/* 00000518: 203a7031 1000c9e1 */  nop; fmul.zc r1, ra14, r1
/* 00000520: 819f82c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 8
/* 00000528: 819f8400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 8
/* 00000530: 00000000 f0f489e7 */  bra -, ra4+0
/* 00000538: 829f8609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 8
/* 00000540: 819f8449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 8
/* 00000548: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000550: fffffe98 f0f809e7 */  brr -, -360 // 0x00000408
/* 00000558: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000560: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000568: 159e7900 10020867 */  mov r1, r4
/* 00000570: 159c5fc0 10022827 */  mov.setf r0, rb5
/* 00000578: 0d9c11c0 d0020827 */  sub r0, r0, 1; nop
/* 00000580: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000588: 0c9c6e00 100601a7 */  add.zc ra6, rb6, r0
/* 00000590: 159c4fc0 10060127 */  mov.zc ra4, rb4
/* 00000598: 15827d80 100220e7 */  mov.setf ra3, unif
/* 000005a0: 15827d80 100210e7 */  mov rb3, unif
/* 000005a8: 00000420 f00809e7 */  brr.allz -, +1056 // 0x000009e8
/* 000005b0: 95208dbf 100248a3 */  mov r2, ra8; mov r3, rb8
/* 000005b8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000005c0: 959f8492 d002c3a2 */  mov ra14, r2; mov.zc r2, r2 >> 8
/* 000005c8: 959f86db d002d3a3 */  mov rb14, r3; mov.zc r3, r3 >> 8
/* 000005d0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000005d8: 959f4492 d002c362 */  mov ra13, r2; mov.zc r2, r2 >> 4
/* 000005e0: 959f46db d002d363 */  mov rb13, r3; mov.zc r3, r3 >> 4
/* 000005e8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 000005f0: 959f2492 d002c322 */  mov ra12, r2; mov.zc r2, r2 >> 2
/* 000005f8: 959f26db d002d323 */  mov rb12, r3; mov.zc r3, r3 >> 2
/* 00000600: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000608: 959f1492 d002c2e2 */  mov ra11, r2; mov.zc r2, r2 >> 1
/* 00000610: 959f16db d002d2e3 */  mov rb11, r3; mov.zc r3, r3 >> 1
/* 00000618: 159c5fc0 10020827 */  mov r0, rb5
/* 00000620: 119c41c0 d0020827 */  shl r0, r0, 4; nop
/* 00000628: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000630: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000638: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000640: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 00000648: 14767180 10020867 */  and r1, r0, ra29
/* 00000650: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000658: 14767180 10020827 */  and r0, r0, ra29
/* 00000660: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000668: 159e7040 10020827 */  or r0, r0, r1
/* 00000670: 147a7180 10020867 */  and r1, r0, ra30
/* 00000678: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000680: 147a7180 10020827 */  and r0, r0, ra30
/* 00000688: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000690: 159e7040 10020827 */  or r0, r0, r1
/* 00000698: 147e7180 10020867 */  and r1, r0, ra31
/* 000006a0: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000006a8: 147e7180 10020827 */  and r0, r0, ra31
/* 000006b0: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 000006b8: 159e7040 10020827 */  or r0, r0, r1
/* 000006c0: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 000006c8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000006d0: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 000006d8: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000006e0: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 000006e8: 14767180 10020867 */  and r1, r0, ra29
/* 000006f0: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 000006f8: 14767180 10020827 */  and r0, r0, ra29
/* 00000700: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 00000708: 159e7040 10020827 */  or r0, r0, r1
/* 00000710: 147a7180 10020867 */  and r1, r0, ra30
/* 00000718: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 00000720: 147a7180 10020827 */  and r0, r0, ra30
/* 00000728: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 00000730: 159e7040 10020827 */  or r0, r0, r1
/* 00000738: 147e7180 10020867 */  and r1, r0, ra31
/* 00000740: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 00000748: 147e7180 10020827 */  and r0, r0, ra31
/* 00000750: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000758: 159e7040 10020827 */  or r0, r0, r1
/* 00000760: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000768: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000770: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000778: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000780: fffffdb0 f0f80027 */  brr ra0, -592 // 0x00000550
/* 00000788: 009e7000 100009e7 */  nop
/* 00000790: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 00000798: 9571cff6 1002471c */  mov ra28, rb28; mov rb28, ra28
/* 000007a0: fffffd90 f0f80027 */  brr ra0, -624 // 0x00000550
/* 000007a8: 009e7000 100009e7 */  nop
/* 000007b0: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 000007b8: 9571cff6 1002471c */  mov ra28, rb28; mov rb28, ra28
/* 000007c0: 00000000 f0f4c027 */  bra ra0, ra6+0
/* 000007c8: 009e7000 100009e7 */  nop
/* 000007d0: 009e7000 100009e7 */  nop
/* 000007d8: 009e7000 100009e7 */  nop
/* 000007e0: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 000007e8: 9528adbf 100248a3 */  mov r2, ra10; mov r3, rb10
/* 000007f0: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000007f8: 959f8492 d002c3a2 */  mov ra14, r2; mov.zc r2, r2 >> 8
/* 00000800: 959f86db d002d3a3 */  mov rb14, r3; mov.zc r3, r3 >> 8
/* 00000808: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000810: 959f4492 d002c362 */  mov ra13, r2; mov.zc r2, r2 >> 4
/* 00000818: 959f46db d002d363 */  mov rb13, r3; mov.zc r3, r3 >> 4
/* 00000820: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000828: 959f2492 d002c322 */  mov ra12, r2; mov.zc r2, r2 >> 2
/* 00000830: 959f26db d002d323 */  mov rb12, r3; mov.zc r3, r3 >> 2
/* 00000838: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000840: 959f1492 d002c2e2 */  mov ra11, r2; mov.zc r2, r2 >> 1
/* 00000848: 959f16db d002d2e3 */  mov rb11, r3; mov.zc r3, r3 >> 1
/* 00000850: 159c5fc0 10020827 */  mov r0, rb5
/* 00000858: 119c41c0 d0020827 */  shl r0, r0, 4; nop
/* 00000860: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000868: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000870: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000878: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 00000880: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000888: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000890: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000898: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000008a0: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 000008a8: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 000008b0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000008b8: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 000008c0: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000008c8: fffffc68 f0f80027 */  brr ra0, -920 // 0x00000550
/* 000008d0: 009e7000 100009e7 */  nop
/* 000008d8: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 000008e0: 9571cff6 1002471c */  mov ra28, rb28; mov rb28, ra28
/* 000008e8: 9538edbf 100248a3 */  mov r2, ra14; mov r3, rb14
/* 000008f0: 20267016 100049e0 */  nop; fmul r0, r2, ra9
/* 000008f8: 209c9017 100049e1 */  nop; fmul r1, r2, rb9
/* 00000900: 209c901f 100049e2 */  nop; fmul r2, r3, rb9
/* 00000908: 2126709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra9
/* 00000910: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000918: 023a7c80 100208a7 */  fsub r2, ra14, r2
/* 00000920: 029ceec0 100208e7 */  fsub r3, rb14, r3
/* 00000928: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000930: 959f8492 d002c3a2 */  mov ra14, r2; mov.zc r2, r2 >> 8
/* 00000938: 959f86db d002d3a3 */  mov rb14, r3; mov.zc r3, r3 >> 8
/* 00000940: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000948: 959f4492 d002c362 */  mov ra13, r2; mov.zc r2, r2 >> 4
/* 00000950: 959f46db d002d363 */  mov rb13, r3; mov.zc r3, r3 >> 4
/* 00000958: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000960: 959f2492 d002c322 */  mov ra12, r2; mov.zc r2, r2 >> 2
/* 00000968: 959f26db d002d323 */  mov rb12, r3; mov.zc r3, r3 >> 2
/* 00000970: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000978: 959f1492 d002c2e2 */  mov ra11, r2; mov.zc r2, r2 >> 1
/* 00000980: 959f16db d002d2e3 */  mov rb11, r3; mov.zc r3, r3 >> 1
/* 00000988: fffffba8 f0f80027 */  brr ra0, -1112 // 0x00000550
/* 00000990: 009e7000 100009e7 */  nop
/* 00000998: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 000009a0: 9571cff6 1002471c */  mov ra28, rb28; mov rb28, ra28
/* 000009a8: 00000000 f0f4c027 */  bra ra0, ra6+0
/* 000009b0: 009e7000 100009e7 */  nop
/* 000009b8: 009e7000 100009e7 */  nop
/* 000009c0: 009e7000 100009e7 */  nop
/* 000009c8: fffffbb0 f0f809e7 */  brr -, -1104 // 0x00000598
/* 000009d0: 009e7000 100009e7 */  nop
/* 000009d8: 009e7000 100009e7 */  nop
/* 000009e0: 009e7000 100009e7 */  nop
/* 000009e8: 159c3fc0 100209a7 */  mov irq, rb3
/* 000009f0: 009e7000 300009e7 */  nop; nop; thrend
/* 000009f8: 009e7000 100009e7 */  nop
/* 00000a00: 009e7000 100009e7 */  nop


