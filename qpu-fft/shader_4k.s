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

shader_4k:
/* 00000000: 00000020 e0021767 */  ldi rb29, 0x00000020
/* 00000008: 00000040 e00217a7 */  ldi rb30, 0x00000040
/* 00000010: 00000080 e00217e7 */  ldi rb31, 0x00000080
/* 00000018: 00005555 e0020727 */  ldi ra28, 0x00005555
/* 00000020: 00003333 e0020767 */  ldi ra29, 0x00003333
/* 00000028: 00000f0f e00207a7 */  ldi ra30, 0x00000f0f
/* 00000030: 000000ff e00207e7 */  ldi ra31, 0x000000ff
/* 00000038: 88104000 e00206e7 */  ldi ra27, 0x88104000
/* 00000040: 88104800 e00216e7 */  ldi rb27, 0x88104800
/* 00000048: 15827d80 10020827 */  mov r0, unif
/* 00000050: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000058: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000060: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000068: 0c9df1c0 a0020827 */  add r0, r0, rb31; nop; ldtmu0
/* 00000070: 159e7900 10020227 */  mov ra8, r4
/* 00000078: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000080: 0c9df1c0 a0020827 */  add r0, r0, rb31; nop; ldtmu0
/* 00000088: 159e7900 10020267 */  mov ra9, r4
/* 00000090: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000098: 0c9df1c0 a0020827 */  add r0, r0, rb31; nop; ldtmu0
/* 000000a0: 159e7900 100202a7 */  mov ra10, r4
/* 000000a8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000b0: 0c9df3c0 a0020867 */  add r1, r1, rb31; nop; ldtmu0
/* 000000b8: 159e7900 10021227 */  mov rb8, r4
/* 000000c0: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000c8: 0c9df3c0 a0020867 */  add r1, r1, rb31; nop; ldtmu0
/* 000000d0: 159e7900 10021267 */  mov rb9, r4
/* 000000d8: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 000000e0: 0c9df3c0 a0020867 */  add r1, r1, rb31; nop; ldtmu0
/* 000000e8: 159e7900 100212a7 */  mov rb10, r4
/* 000000f0: 15827d80 10020827 */  mov r0, unif
/* 000000f8: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000100: 11983dc0 d00208a7 */  shl r2, elem_num, 3; nop
/* 00000108: 0c9e7080 10020e27 */  add t0s, r0, r2
/* 00000110: 0c9df1c0 a0020827 */  add r0, r0, rb31; nop; ldtmu0
/* 00000118: 159e7900 100202e7 */  mov ra11, r4
/* 00000120: 0c9e7280 10020e27 */  add t0s, r1, r2
/* 00000128: 0c9df3c0 a0020867 */  add r1, r1, rb31; nop; ldtmu0
/* 00000130: 159e7900 100212e7 */  mov rb11, r4
/* 00000138: 15827d80 10021167 */  mov rb5, unif
/* 00000140: 00101200 e0020827 */  ldi r0, 0x00101200
/* 00000148: 00000010 e0020867 */  ldi r1, 0x00000010
/* 00000150: 00000002 e00208a7 */  ldi r2, 0x00000002
/* 00000158: 409c5017 100049e2 */  nop; mul24 r2, r2, rb5
/* 00000160: cc9e7081 100246a0 */  add ra26, r0, r2; v8adds r0, r0, r1
/* 00000168: cc9e7081 100256a0 */  add rb26, r0, r2; v8adds r0, r0, r1
/* 00000170: cc9e7081 100049e0 */  add.never -, r0, r2; v8adds r0, r0, r1
/* 00000178: 0c9e7080 100009e7 */  add.never -, r0, r2
/* 00000180: 000000b0 f0f80127 */  brr ra4, +176 // 0x00000250
/* 00000188: 009e7000 100009e7 */  nop
/* 00000190: 009e7000 100009e7 */  nop
/* 00000198: 009e7000 100009e7 */  nop
/* 000001a0: 156a7d80 10021c67 */  mov vw_setup, ra26
/* 000001a8: 159e7000 10020c27 */  mov vpm, r0
/* 000001b0: 159e7240 10020c27 */  mov vpm, r1
/* 000001b8: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 000001c0: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000001c8: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000001d0: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000001d8: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000001e0: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000001e8: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 000001f0: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 000001f8: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000200: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000208: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000210: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000218: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000220: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000228: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000230: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000238: 156e7d80 10021c67 */  mov vw_setup, ra27
/* 00000240: c00007c0 e0021c67 */  ldi vw_setup, 0xc00007c0
/* 00000248: 8c05edf6 10024072 */  add ra1, ra1, rb30; mov vw_addr, ra1
/* 00000250: 00000038 f0f81127 */  brr rb4, +56 // 0x000002a8
/* 00000258: 009e7000 100009e7 */  nop
/* 00000260: 009e7000 100009e7 */  nop
/* 00000268: 009e7000 100009e7 */  nop
/* 00000270: 156a7d80 10021c67 */  mov vw_setup, ra26
/* 00000278: 159e7000 10020c27 */  mov vpm, r0
/* 00000280: 159e7240 10020c27 */  mov vpm, r1
/* 00000288: 00000000 f0f4c9e7 */  bra -, ra6+0
/* 00000290: 009e7000 100009e7 */  nop
/* 00000298: 156a7d80 10020c67 */  mov vr_setup, ra26
/* 000002a0: 15c27d80 100009e7 */  mov.never -, vpm
/* 000002a8: 00000080 f0f801a7 */  brr ra6, +128 // 0x00000348
/* 000002b0: 009e7000 100009e7 */  nop
/* 000002b8: 009e7000 100009e7 */  nop
/* 000002c0: 009e7000 100009e7 */  nop
/* 000002c8: 159f2fc0 100009e7 */  mov.never -, vw_wait
/* 000002d0: 00000019 e80009e7 */  sacq.never -, 0x00000009
/* 000002d8: 00000001 e80009e7 */  srel.never -, 0x00000001
/* 000002e0: 0000001a e80009e7 */  sacq.never -, 0x0000000a
/* 000002e8: 00000002 e80009e7 */  srel.never -, 0x00000002
/* 000002f0: 0000001b e80009e7 */  sacq.never -, 0x0000000b
/* 000002f8: 00000003 e80009e7 */  srel.never -, 0x00000003
/* 00000300: 0000001c e80009e7 */  sacq.never -, 0x0000000c
/* 00000308: 00000004 e80009e7 */  srel.never -, 0x00000004
/* 00000310: 0000001d e80009e7 */  sacq.never -, 0x0000000d
/* 00000318: 00000005 e80009e7 */  srel.never -, 0x00000005
/* 00000320: 0000001e e80009e7 */  sacq.never -, 0x0000000e
/* 00000328: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000330: 00000006 e80009e7 */  srel.never -, 0x00000006
/* 00000338: 0000001f e80009e7 */  sacq.never -, 0x0000000f
/* 00000340: 00000007 e80009e7 */  srel.never -, 0x00000007
/* 00000348: 000003e8 f0f811a7 */  brr rb6, +1000 // 0x00000750
/* 00000350: 009e7000 100009e7 */  nop
/* 00000358: 009e7000 100009e7 */  nop
/* 00000360: 009e7000 100009e7 */  nop
/* 00000368: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000370: 00000009 e80009e7 */  srel.never -, 0x00000009
/* 00000378: 00000011 e80009e7 */  sacq.never -, 0x00000001
/* 00000380: 009e7000 100009e7 */  nop
/* 00000388: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000390: 0000000a e80009e7 */  srel.never -, 0x0000000a
/* 00000398: 00000012 e80009e7 */  sacq.never -, 0x00000002
/* 000003a0: 009e7000 100009e7 */  nop
/* 000003a8: 00000000 f0f409e7 */  bra -, ra0+0
/* 000003b0: 0000000b e80009e7 */  srel.never -, 0x0000000b
/* 000003b8: 00000013 e80009e7 */  sacq.never -, 0x00000003
/* 000003c0: 009e7000 100009e7 */  nop
/* 000003c8: 00000000 f0f409e7 */  bra -, ra0+0
/* 000003d0: 0000000c e80009e7 */  srel.never -, 0x0000000c
/* 000003d8: 00000014 e80009e7 */  sacq.never -, 0x00000004
/* 000003e0: 009e7000 100009e7 */  nop
/* 000003e8: 00000000 f0f409e7 */  bra -, ra0+0
/* 000003f0: 0000000d e80009e7 */  srel.never -, 0x0000000d
/* 000003f8: 00000015 e80009e7 */  sacq.never -, 0x00000005
/* 00000400: 009e7000 100009e7 */  nop
/* 00000408: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000410: 0000000e e80009e7 */  srel.never -, 0x0000000e
/* 00000418: 00000016 e80009e7 */  sacq.never -, 0x00000006
/* 00000420: 009e7000 100009e7 */  nop
/* 00000428: 00000000 f0f409e7 */  bra -, ra0+0
/* 00000430: 0000000f e80009e7 */  srel.never -, 0x0000000f
/* 00000438: 00000017 e80009e7 */  sacq.never -, 0x00000007
/* 00000440: 009e7000 100009e7 */  nop
/* 00000448: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000450: 20327030 1000d9c2 */  nop; fmul.zc ra2, ra12, r0
/* 00000458: 209cc039 1000c9e2 */  nop; fmul.zc r2, rb12, r1
/* 00000460: 2208ccb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb12, r0
/* 00000468: 20327031 1000c9e1 */  nop; fmul.zc r1, ra12, r1
/* 00000470: 819ff2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 15
/* 00000478: 819f1400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 1
/* 00000480: 829ff609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 15
/* 00000488: 819f1449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 1
/* 00000490: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000498: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 000004a0: 20367030 1000d9c2 */  nop; fmul.zc ra2, ra13, r0
/* 000004a8: 209cd039 1000c9e2 */  nop; fmul.zc r2, rb13, r1
/* 000004b0: 2208dcb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb13, r0
/* 000004b8: 20367031 1000c9e1 */  nop; fmul.zc r1, ra13, r1
/* 000004c0: 819fe2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 14
/* 000004c8: 819f2400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 2
/* 000004d0: 829fe609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 14
/* 000004d8: 819f2449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 2
/* 000004e0: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 000004e8: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000004f0: 203a7030 1000d9c2 */  nop; fmul.zc ra2, ra14, r0
/* 000004f8: 209ce039 1000c9e2 */  nop; fmul.zc r2, rb14, r1
/* 00000500: 2208ecb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb14, r0
/* 00000508: 203a7031 1000c9e1 */  nop; fmul.zc r1, ra14, r1
/* 00000510: 819fc2c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 12
/* 00000518: 819f4400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 4
/* 00000520: 829fc609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 12
/* 00000528: 819f4449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 4
/* 00000530: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000538: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000540: 203e7030 1000d9c2 */  nop; fmul.zc ra2, ra15, r0
/* 00000548: 209cf039 1000c9e2 */  nop; fmul.zc r2, rb15, r1
/* 00000550: 2208fcb8 1006c823 */  fsub.zc r0, ra2, r2; fmul.zc r3, rb15, r0
/* 00000558: 203e7031 1000c9e1 */  nop; fmul.zc r1, ra15, r1
/* 00000560: 819f82c0 d0064862 */  fadd.zc r1, r1, r3; mov r2, r0 >> 8
/* 00000568: 819f8400 d0044823 */  fadd.zs r0, r2, r0; mov r3, r0 >> 8
/* 00000570: 00000000 f0f489e7 */  bra -, ra4+0
/* 00000578: 829f8609 d0064822 */  fsub.zc r0, r3, r0; mov r2, r1 >> 8
/* 00000580: 819f8449 d0044863 */  fadd.zs r1, r2, r1; mov r3, r1 >> 8
/* 00000588: 029e7640 10060867 */  fsub.zc r1, r3, r1
/* 00000590: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 00000598: 14727180 10020867 */  and r1, r0, ra28
/* 000005a0: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 000005a8: 14727180 10020827 */  and r0, r0, ra28
/* 000005b0: 119c13c0 d0020867 */  shl r1, r1, 1; nop
/* 000005b8: 159e7040 10020827 */  or r0, r0, r1
/* 000005c0: 14767180 10020867 */  and r1, r0, ra29
/* 000005c8: 0e9c21c0 d0020827 */  shr r0, r0, 2; nop
/* 000005d0: 14767180 10020827 */  and r0, r0, ra29
/* 000005d8: 119c23c0 d0020867 */  shl r1, r1, 2; nop
/* 000005e0: 159e7040 10020827 */  or r0, r0, r1
/* 000005e8: 147a7180 10020867 */  and r1, r0, ra30
/* 000005f0: 0e9c41c0 d0020827 */  shr r0, r0, 4; nop
/* 000005f8: 147a7180 10020827 */  and r0, r0, ra30
/* 00000600: 119c43c0 d0020867 */  shl r1, r1, 4; nop
/* 00000608: 159e7040 10020827 */  or r0, r0, r1
/* 00000610: 147e7180 10020867 */  and r1, r0, ra31
/* 00000618: 0e9c81c0 d0020827 */  shr r0, r0, 8; nop
/* 00000620: 147e7180 10020827 */  and r0, r0, ra31
/* 00000628: 119c83c0 d0020867 */  shl r1, r1, 8; nop
/* 00000630: 159e7040 10020827 */  or r0, r0, r1
/* 00000638: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 00000640: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000648: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 00000650: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000658: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000660: 000000cc e20229e7 */  ldi.setf -, [0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]
/* 00000668: 959fa000 d002c8a0 */  mov r2, r0; mov.zc r0, r0 >> 10
/* 00000670: 959fa249 d002c8e1 */  mov r3, r1; mov.zc r1, r1 >> 10
/* 00000678: 00003300 e20229e7 */  ldi.setf -, [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0]
/* 00000680: 809f6012 d000c9e0 */  nop; mov.zc r0, r2 >> 6
/* 00000688: 809f601b d000c9e1 */  nop; mov.zc r1, r3 >> 6
/* 00000690: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000698: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 000006a0: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 000006a8: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 000006b0: 159e7900 10020867 */  mov r1, r4
/* 000006b8: 000000cc e20229e7 */  ldi.setf -, [0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]
/* 000006c0: 959fa000 d002c8a0 */  mov r2, r0; mov.zc r0, r0 >> 10
/* 000006c8: 959fa249 d002c8e1 */  mov r3, r1; mov.zc r1, r1 >> 10
/* 000006d0: 00003300 e20229e7 */  ldi.setf -, [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0]
/* 000006d8: 809f6012 d000c9e0 */  nop; mov.zc r0, r2 >> 6
/* 000006e0: 809f601b d000c9e1 */  nop; mov.zc r1, r3 >> 6
/* 000006e8: fffffd40 f0f809e7 */  brr -, -704 // 0x00000448
/* 000006f0: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 000006f8: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 00000700: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 00000708: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 00000710: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000718: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000720: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000728: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000730: fffffcf8 f0f809e7 */  brr -, -776 // 0x00000448
/* 00000738: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000740: 159e7900 a0020827 */  mov r0, r4; nop; ldtmu0
/* 00000748: 159e7900 10020867 */  mov r1, r4
/* 00000750: 159c5fc0 10022827 */  mov.setf r0, rb5
/* 00000758: 0d9c11c0 d0020827 */  sub r0, r0, 1; nop
/* 00000760: 119c51c0 d0020827 */  shl r0, r0, 5; nop
/* 00000768: 0c9c6e00 100601a7 */  add.zc ra6, rb6, r0
/* 00000770: 159c4fc0 10060127 */  mov.zc ra4, rb4
/* 00000778: 15827d80 100220e7 */  mov.setf ra3, unif
/* 00000780: 15827d80 100210e7 */  mov rb3, unif
/* 00000788: 000005c8 f00809e7 */  brr.allz -, +1480 // 0x00000d70
/* 00000790: 95208dbf 100248a3 */  mov r2, ra8; mov r3, rb8
/* 00000798: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000007a0: 959f8492 d002c3e2 */  mov ra15, r2; mov.zc r2, r2 >> 8
/* 000007a8: 959f86db d002d3e3 */  mov rb15, r3; mov.zc r3, r3 >> 8
/* 000007b0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000007b8: 959f4492 d002c3a2 */  mov ra14, r2; mov.zc r2, r2 >> 4
/* 000007c0: 959f46db d002d3a3 */  mov rb14, r3; mov.zc r3, r3 >> 4
/* 000007c8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 000007d0: 959f2492 d002c362 */  mov ra13, r2; mov.zc r2, r2 >> 2
/* 000007d8: 959f26db d002d363 */  mov rb13, r3; mov.zc r3, r3 >> 2
/* 000007e0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 000007e8: 959f1492 d002c322 */  mov ra12, r2; mov.zc r2, r2 >> 1
/* 000007f0: 959f16db d002d323 */  mov rb12, r3; mov.zc r3, r3 >> 1
/* 000007f8: 159c5fc0 10020827 */  mov r0, rb5
/* 00000800: 119c41c0 d0020827 */  shl r0, r0, 4; nop
/* 00000808: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000810: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000818: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000820: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
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
/* 000008c8: 0e9c11c0 d0020827 */  shr r0, r0, 1; nop
/* 000008d0: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 000008d8: 94981dc0 d00269e2 */  and.setf -, elem_num, 1; mov r2, r0
/* 000008e0: 959f1489 d004c820 */  mov.zs r0, r2; mov.zc r0, r1 >> 1
/* 000008e8: 959ff252 d0068861 */  mov.zc r1, r1; mov.zs r1, r2 >> 15
/* 000008f0: 000000cc e20229e7 */  ldi.setf -, [0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]
/* 000008f8: 959fa000 d002c8a0 */  mov r2, r0; mov.zc r0, r0 >> 10
/* 00000900: 959fa249 d002c8e1 */  mov r3, r1; mov.zc r1, r1 >> 10
/* 00000908: 00003300 e20229e7 */  ldi.setf -, [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0]
/* 00000910: 809f6012 d000c9e0 */  nop; mov.zc r0, r2 >> 6
/* 00000918: 809f601b d000c9e1 */  nop; mov.zc r1, r3 >> 6
/* 00000920: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000928: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000930: fffffc40 f0f80027 */  brr ra0, -960 // 0x00000590
/* 00000938: 9569aff6 1002469a */  mov ra26, rb26; mov rb26, ra26
/* 00000940: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 00000948: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000950: 0e1ccdc0 d00229e7 */  shr.setf -, ra7, 12; nop
/* 00000958: fffffc18 f00809e7 */  brr.allz -, -1000 // 0x00000590
/* 00000960: 9569aff6 1002469a */  mov ra26, rb26; mov rb26, ra26
/* 00000968: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 00000970: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000978: 00000000 f0f4c027 */  bra ra0, ra6+0
/* 00000980: 009e7000 100009e7 */  nop
/* 00000988: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000990: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000998: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 000009a0: 95208dbf 100248a3 */  mov r2, ra8; mov r3, rb8
/* 000009a8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 000009b0: 959f8492 d002c3e2 */  mov ra15, r2; mov.zc r2, r2 >> 8
/* 000009b8: 959f86db d002d3e3 */  mov rb15, r3; mov.zc r3, r3 >> 8
/* 000009c0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 000009c8: 959f4492 d002c3a2 */  mov ra14, r2; mov.zc r2, r2 >> 4
/* 000009d0: 959f46db d002d3a3 */  mov rb14, r3; mov.zc r3, r3 >> 4
/* 000009d8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 000009e0: 959f2492 d002c362 */  mov ra13, r2; mov.zc r2, r2 >> 2
/* 000009e8: 959f26db d002d363 */  mov rb13, r3; mov.zc r3, r3 >> 2
/* 000009f0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 000009f8: 959f1492 d002c322 */  mov ra12, r2; mov.zc r2, r2 >> 1
/* 00000a00: 959f16db d002d323 */  mov rb12, r3; mov.zc r3, r3 >> 1
/* 00000a08: 159c5fc0 10020827 */  mov r0, rb5
/* 00000a10: 119c41c0 d0020827 */  shl r0, r0, 4; nop
/* 00000a18: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000a20: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000a28: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000a30: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 00000a38: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000a40: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000a48: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000a50: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000a58: fffffc90 f0f80027 */  brr ra0, -880 // 0x00000708
/* 00000a60: 9569aff6 1002469a */  mov ra26, rb26; mov rb26, ra26
/* 00000a68: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 00000a70: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000a78: fffffc70 f0f80027 */  brr ra0, -912 // 0x00000708
/* 00000a80: 9569aff6 1002469a */  mov ra26, rb26; mov rb26, ra26
/* 00000a88: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 00000a90: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000a98: 0d01ddc0 10020027 */  sub ra0, ra0, rb29
/* 00000aa0: 953cfdbf 100248a3 */  mov r2, ra15; mov r3, rb15
/* 00000aa8: 20267016 100049e0 */  nop; fmul r0, r2, ra9
/* 00000ab0: 209c9017 100049e1 */  nop; fmul r1, r2, rb9
/* 00000ab8: 209c901f 100049e2 */  nop; fmul r2, r3, rb9
/* 00000ac0: 2126709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra9
/* 00000ac8: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000ad0: 023e7c80 100208a7 */  fsub r2, ra15, r2
/* 00000ad8: 029cfec0 100208e7 */  fsub r3, rb15, r3
/* 00000ae0: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000ae8: 959f8492 d002c3e2 */  mov ra15, r2; mov.zc r2, r2 >> 8
/* 00000af0: 959f86db d002d3e3 */  mov rb15, r3; mov.zc r3, r3 >> 8
/* 00000af8: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000b00: 959f4492 d002c3a2 */  mov ra14, r2; mov.zc r2, r2 >> 4
/* 00000b08: 959f46db d002d3a3 */  mov rb14, r3; mov.zc r3, r3 >> 4
/* 00000b10: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000b18: 959f2492 d002c362 */  mov ra13, r2; mov.zc r2, r2 >> 2
/* 00000b20: 959f26db d002d363 */  mov rb13, r3; mov.zc r3, r3 >> 2
/* 00000b28: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000b30: 959f1492 d002c322 */  mov ra12, r2; mov.zc r2, r2 >> 1
/* 00000b38: 959f16db d002d323 */  mov rb12, r3; mov.zc r3, r3 >> 1
/* 00000b40: 0e1ccdc0 d00229e7 */  shr.setf -, ra7, 12; nop
/* 00000b48: fffffba0 f00809e7 */  brr.allz -, -1120 // 0x00000708
/* 00000b50: 9569aff6 1002469a */  mov ra26, rb26; mov rb26, ra26
/* 00000b58: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 00000b60: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000b68: 00000000 f0f4c027 */  bra ra0, ra6+0
/* 00000b70: 009e7000 100009e7 */  nop
/* 00000b78: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000b80: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000b88: 950c3dbf 100250c3 */  mov rb3, ra3; mov ra3, rb3
/* 00000b90: 952cbdbf 100248a3 */  mov r2, ra11; mov r3, rb11
/* 00000b98: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000ba0: 959f8492 d002c3e2 */  mov ra15, r2; mov.zc r2, r2 >> 8
/* 00000ba8: 959f86db d002d3e3 */  mov rb15, r3; mov.zc r3, r3 >> 8
/* 00000bb0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000bb8: 959f4492 d002c3a2 */  mov ra14, r2; mov.zc r2, r2 >> 4
/* 00000bc0: 959f46db d002d3a3 */  mov rb14, r3; mov.zc r3, r3 >> 4
/* 00000bc8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000bd0: 959f2492 d002c362 */  mov ra13, r2; mov.zc r2, r2 >> 2
/* 00000bd8: 959f26db d002d363 */  mov rb13, r3; mov.zc r3, r3 >> 2
/* 00000be0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000be8: 959f1492 d002c322 */  mov ra12, r2; mov.zc r2, r2 >> 1
/* 00000bf0: 959f16db d002d323 */  mov rb12, r3; mov.zc r3, r3 >> 1
/* 00000bf8: 159c5fc0 10020827 */  mov r0, rb5
/* 00000c00: 119c41c0 d0020827 */  shl r0, r0, 4; nop
/* 00000c08: 0c9a7180 10020167 */  add ra5, r0, elem_num
/* 00000c10: 00000000 e00201e7 */  ldi ra7, 0x00000000
/* 00000c18: 159c3fc0 10020067 */  mov ra1, rb3
/* 00000c20: 8c15fdf6 10024160 */  add ra5, ra5, rb31; mov r0, ra5
/* 00000c28: 119c31c0 d0020827 */  shl r0, r0, 3; nop
/* 00000c30: 0c9c41c0 d0020867 */  add r1, r0, 4; nop
/* 00000c38: 0c0e7c00 10020e27 */  add t0s, ra3, r0
/* 00000c40: 0c0e7c40 10020e27 */  add t0s, ra3, r1
/* 00000c48: fffffaa0 f0f80027 */  brr ra0, -1376 // 0x00000708
/* 00000c50: 9569aff6 1002469a */  mov ra26, rb26; mov rb26, ra26
/* 00000c58: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 00000c60: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000c68: 953cfdbf 100248a3 */  mov r2, ra15; mov r3, rb15
/* 00000c70: 202a7016 100049e0 */  nop; fmul r0, r2, ra10
/* 00000c78: 209ca017 100049e1 */  nop; fmul r1, r2, rb10
/* 00000c80: 209ca01f 100049e2 */  nop; fmul r2, r3, rb10
/* 00000c88: 212a709e 100248a3 */  fadd r2, r0, r2; fmul r3, r3, ra10
/* 00000c90: 029e7640 100208e7 */  fsub r3, r3, r1
/* 00000c98: 023e7c80 100208a7 */  fsub r2, ra15, r2
/* 00000ca0: 029cfec0 100208e7 */  fsub r3, rb15, r3
/* 00000ca8: 14988dc0 d00229e7 */  and.setf -, elem_num, 8; nop
/* 00000cb0: 959f8492 d002c3e2 */  mov ra15, r2; mov.zc r2, r2 >> 8
/* 00000cb8: 959f86db d002d3e3 */  mov rb15, r3; mov.zc r3, r3 >> 8
/* 00000cc0: 14984dc0 d00229e7 */  and.setf -, elem_num, 4; nop
/* 00000cc8: 959f4492 d002c3a2 */  mov ra14, r2; mov.zc r2, r2 >> 4
/* 00000cd0: 959f46db d002d3a3 */  mov rb14, r3; mov.zc r3, r3 >> 4
/* 00000cd8: 14982dc0 d00229e7 */  and.setf -, elem_num, 2; nop
/* 00000ce0: 959f2492 d002c362 */  mov ra13, r2; mov.zc r2, r2 >> 2
/* 00000ce8: 959f26db d002d363 */  mov rb13, r3; mov.zc r3, r3 >> 2
/* 00000cf0: 14981dc0 d00229e7 */  and.setf -, elem_num, 1; nop
/* 00000cf8: 959f1492 d002c322 */  mov ra12, r2; mov.zc r2, r2 >> 1
/* 00000d00: 959f16db d002d323 */  mov rb12, r3; mov.zc r3, r3 >> 1
/* 00000d08: 0e1ccdc0 d00229e7 */  shr.setf -, ra7, 12; nop
/* 00000d10: fffff9d8 f00809e7 */  brr.allz -, -1576 // 0x00000708
/* 00000d18: 9569aff6 1002469a */  mov ra26, rb26; mov rb26, ra26
/* 00000d20: 956dbff6 100246db */  mov ra27, rb27; mov rb27, ra27
/* 00000d28: 0c1dfdc0 100201e7 */  add ra7, ra7, rb31
/* 00000d30: 00000000 f0f4c027 */  bra ra0, ra6+0
/* 00000d38: 009e7000 100009e7 */  nop
/* 00000d40: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000d48: 009e7000 a00009e7 */  nop; nop; ldtmu0
/* 00000d50: fffffa08 f0f809e7 */  brr -, -1528 // 0x00000778
/* 00000d58: 009e7000 100009e7 */  nop
/* 00000d60: 009e7000 100009e7 */  nop
/* 00000d68: 009e7000 100009e7 */  nop
/* 00000d70: 159c3fc0 100209a7 */  mov irq, rb3
/* 00000d78: 009e7000 300009e7 */  nop; nop; thrend
/* 00000d80: 009e7000 100009e7 */  nop
/* 00000d88: 009e7000 100009e7 */  nop


