### Simple Assembler:
A rudimentary assembler (very alpha at this stage, will improve with use).
It needs Node.js or a browser to run.

NOTE: Rotator and Pack/Unpack has now been added but is preliminary.

#### Usage:
##### Command Line:
```
  node[js] qpuasm.js [--showbits] [--dumpglobals] [--dumpsymbols] [--verbose] [--in]filename
```
##### Javascript Api:
Changes `options` as necessary. All internal functions are included in the `assemble` object aswell.
```
  var assemble = require('./qpuasm.js'); //if using node
  
  var options = {showbits:true, dumpglobals:true, dumpsymbols:true, verbose:true};
  assemble(file,options);
```

#### Source Syntax:
```
  {[label:] [instruction/directive] [# comment] LF}
```

#### Instructions:
```
[addop] [; mulop] [; op]
  
Where addop, mulop and op are:
  op [dst[.pack] [, src1[.unpack] [, src2[.unpack]]]

addop:
  nop, fadd, fsub, fmin, fmax, fminabs, fmaxabs, ftoi, itof, add, sub, shr, asr
  ror, shl, min", max, and, or, xor, not, clz, v8adds, v8subs, mov
  
mulop:
  nop, fmul, mul24, v8muld, v8min, v8max, v8adds, v8subs, mov
  
op:
  bkpt, nop, thrsw, thrend, sbwait, sbdone, lthrsw, loadcv, loadc, ldcend, ldtmu0, ldtmu1, loadam, 
  ldi, bra, brr
  
dst, src1, src2:
  a register reference: r0...r5 or ra0...ra63, or rb0...rb63, or special reg (vpm, unif, ...).
  a small constant
  
pack:
  .16a, .16b, .8abcd, .8a, .8b, .8c, .8d, .s, .16as, .16bs, .8abcds, .8as, .8bs, .8cs, .8ds
  
unpack:
  .16a, .16b, .8dr, .8a, .8b, .8c, .8d

Directives:
  .set    symbol, jsexpr
  .global symbol
```

#### Example.

```
nodejs qpuasm.js qpu-02.s
```

on 'qpu-02.s':
```
.set vw_layout, function vw_layout(row_step, element_stride, offset) { return (offset | 0xa00 | row_step << 12 | element_stride << 20); } vw_layout
.set vw_setup0, function vw_setup0(x, y) { return (2<<30|y<<23|x<<16); } vw_setup0
.set vw_setup1, function vw_setup1(x, y) { return (3<<30|x<<16|y); } vw_setup1

.global entry
.global exit

entry:
        # Determine if this QPU will signal on completion (flag is from uniforms)
        mov rb3, unif

        # Configure access to vpm
        ldi vw_setup, vw_layout(1, 1)

        # Write 5x16 words into vpm
        mov vpm, 1
        mov vpm, 2
        mov vpm, 4
        mov vpm, 8
        mov vpm, elem_num

        # Configure vpm write to memory
        ldi vw_setup, vw_setup0(5, 16)
        ldi vw_setup, vw_setup1(0, 0)

        # Trigger transfer to destination in memory (address is from uniforms)
        nop; mov vw_addr, unif

        # Wait for vpm transfer to finish
        mov.never -, vw_wait

exit:
        # Signal done
        mov irq, rb3
        nop; nop; thrend
        nop
        nop
```

produces:
```
/* Exported Symbols */
#define qpu_symbol_entry 0x00000000
#define qpu_symbol_exit 0x00000058

/* Assembled Program */
/* entry: */
/* 0x00000000: */ 0x15827d80, 0x100210e7, /* mov rb3, unif */
/* 0x00000008: */ 0x00101a00, 0xe0021c67, /* ldi vw_setup, vw_layout(1, 1) */
/* 0x00000010: */ 0x159c1fc0, 0xd0020c27, /* mov vpm, 1 */
/* 0x00000018: */ 0x159c2fc0, 0xd0020c27, /* mov vpm, 2 */
/* 0x00000020: */ 0x159c4fc0, 0xd0020c27, /* mov vpm, 4 */
/* 0x00000028: */ 0x159c8fc0, 0xd0020c27, /* mov vpm, 8 */
/* 0x00000030: */ 0x159a7d80, 0x10020c27, /* mov vpm, elem_num */
/* 0x00000038: */ 0x88050000, 0xe0021c67, /* ldi vw_setup, vw_setup0(5, 16) */
/* 0x00000040: */ 0xc0000000, 0xe0021c67, /* ldi vw_setup, vw_setup1(0, 0) */
/* 0x00000048: */ 0x80827036, 0x100049f2, /* nop; mov vw_addr, unif */
/* 0x00000050: */ 0x159f2fc0, 0x100009e7, /* mov.never -, vw_wait */
/* exit: */
/* 0x00000058: */ 0x159c3fc0, 0x100209a7, /* mov irq, rb3 */
/* 0x00000060: */ 0x009e7000, 0x300009e7, /* nop; nop; thrend */
/* 0x00000068: */ 0x009e7000, 0x100009e7, /* nop */
/* 0x00000070: */ 0x009e7000, 0x100009e7, /* nop */
```
