#include <stdint.h>
#include <stdio.h>

#include "qpudis.h"

int base;
int showfields = 0;

const char *acc_names[] = {
	"r0", "r1", "r2", "r3", "r4", "r5"
};

const char *banka_r[64] = {
	"ra0", "ra1", "ra2", "ra3", "ra4", "ra5", "ra6", "ra7",
	"ra8", "ra9", "ra10", "ra11", "ra12", "ra13", "ra14", "ra15", //ra15 is w in shaders
	"ra16", "ra17", "ra18", "ra19", "ra20", "ra21", "ra22", "ra23",
	"ra24", "ra25", "ra26", "ra27", "ra28", "ra29", "ra30", "ra31",
	"unif", "ra33?", "ra34?", "vary", "ra36?", "ra37?", "elem_num", "nop",
	"ra40", "x_coord", "ms_mask", "ra43?", "ra44?", "ra45?", "ra46?", "ra47?",
	"vpm", "vr_busy", "vr_wait", "mutex", "ra52?", "ra53?", "ra54?", "ra55?",
	"ra56?", "ra57?", "ra58?", "ra59?", "ra60?", "ra61?", "ra62?", "ra63?",
};

const char *bankb_r[64] = {
	"rb0", "rb1", "rb2", "rb3", "rb4", "rb5", "rb6", "rb7",
	"rb8", "rb9", "rb10", "rb11", "rb12", "rb13", "rb14", "rb15", //rb15 is z in shaders
	"rb16", "rb17", "rb18", "rb19", "rb20", "rb21", "rb22", "rb23",
	"rb24", "rb25", "rb26", "rb27", "rb28", "rb29", "rb30", "rb31",
	"unif", "rb33?", "rb34?", "vary", "rb36?", "rb37?", "qpu_num", "nop",
	"rb40?", "y_coord", "rev_flag", "rb43?", "rb44?", "rb45?", "rb46?", "rb47?",
	"vpm", "vw_busy", "vw_wait", "mutex", "rb52?", "rb53?", "rb54?", "rb55?",
	"rb56?", "rb57?", "rb58?", "rb59?", "rb60?", "rb61?", "rb62?", "rb63?",
};

const char *banka_w[64] = {
	"ra0", "ra1", "ra2", "ra3", "ra4", "ra5", "ra6", "ra7",
	"ra8", "ra9", "ra10", "ra11", "ra12", "ra13", "ra14", "ra15", //ra15 is w in shaders
	"ra16", "ra17", "ra18", "ra19", "ra20", "ra21", "ra22", "ra23",
	"ra24", "ra25", "ra26", "ra27", "ra28", "ra29", "ra30", "ra31",
	"r0", "r1", "r2", "r3", "tmurs", "r5quad", "irq", "-",
	"unif_addr", "x_coord", "ms_mask", "stencil", "tlbz", "tlbm", "tlbc", "tlbam",
	"vpm", "vr_setup", "vr_addr", "mutex", "recip", "recipsqrt", "exp", "log",
	"t0s", "t0t", "t0r", "t0b", "t1s", "t1t", "t1r", "t1b",
};

const char *bankb_w[64] = {
	"rb0", "rb1", "rb2", "rb3", "rb4", "rb5", "rb6", "rb7",
	"rb8", "rb9", "rb10", "rb11", "rb12", "rb13", "rb14", "rb15", //rb15 is z in shaders
	"rb16", "rb17", "rb18", "rb19", "rb20", "rb21", "rb22", "rb23",
	"rb24", "rb25", "rb26", "rb27", "rb28", "rb29", "rb30", "rb31",
	"r0", "r1", "r2", "r3", "tmurs", "r5rep", "irq", "-",
	"unif_addr_rel", "y_coord", "rev_flag", "stencil", "tlbz", "tlbm", "tlbc", "tlbam",
	"vpm", "vw_setup", "vw_addr", "mutex", "recip", "recipsqrt", "exp", "log",
	"t0s", "t0t", "t0r", "t0b", "t1s", "t1t", "t1r", "t1b",
};

const char *ops[] = {
	"bkpt", "nop", "thrsw", "thrend", "sbwait", "sbdone", "lthrsw", "loadcv",
	"loadc", "ldcend", "ldtmu0", "ldtmu1", "loadam", "nop", "ldi", "bra",
};

const char *addops[] = {
	"nop", "fadd", "fsub", "fmin", "fmax", "fminabs", "fmaxabs", "ftoi",
	"itof", "addop9", "addop10", "addop11", "add", "sub", "shr", "asr",
	"ror", "shl", "min", "max", "and", "or", "xor", "not",
	"clz", "addop25", "addop26", "addop27", "addop28", "addop29", "v8adds", "v8subs",

	"mov"
};

const char *mulops[] = {
	"nop", "fmul", "mul24", "v8muld", "v8min", "v8max", "v8adds", "v8subs",

	"mov"
};

const char *cc[] = {
	".never", "", ".zs", ".zc", ".ns", ".nc", ".cs", ".cc"
};

const char *dstpackadd[] = {
	"", ".16a", ".16b", ".8abcd", ".8a", ".8b", ".8c", ".8d", ".s", ".16as", ".16bs", ".8abcds", ".8as", ".8bs", ".8cs", ".8ds"
};

const char *dstpackmul[] = {
	"", ".packm01", ".packm02", ".8abcd", ".8a", ".8b", ".8c", ".8d", ".packm08", ".packm09", ".packm10", ".packm11", ".packm12", ".packm13", ".packm14", ".packm15"
};

const char *srcunpackadd[] = {
	"", ".16a", ".16b", ".8dr", ".8a", ".8b", ".8c", ".8d"
};

const char *srcunpackmul[] = {
	"", ".16a", ".16b", ".8dr", ".8a", ".8b", ".8c", ".8d"
};

const char *bcc[] = {
	".allz", ".allnz", ".anyz", ".anynz", ".alln", ".allnn", ".anyn", ".anynn",
	".allc", ".allnc", ".anyc", ".anync", ".cc12", ".cc13", ".cc14", ""
};

const char *imm[] = {
	"0", "1", "2", "3", "4", "5", "6", "7",
	"8", "9", "10", "11", "12", "13", "14", "15",
	"-16", "-15", "-14", "-13", "-12", "-11", "-10", "-9",
	"-8", "-7", "-6", "-5", "-4", "-3", "-2", "-1",
	"1.0", "2.0", "4.0", "8.0", "16.0", "32.0", "64.0", "128.0",
	"1/256", "1/128", "1/64", "1/32", "1/16", "1/8", "1/4", "1/2", 
	" >> r5", " >> 1", " >> 2", " >> 3", " >> 4", " >> 5", " >> 6", " >> 7",
	" >> 8", " >> 9", " >> 10", " >> 11", " >> 12", " >> 13", " >> 14", " >> 15"
};

const char *setf[] = {
	"", ".setf"
};

// QPU Instruction unpacking
//
// Add/Mul Operations:
//   mulop:3 addop:5 ra:6 rb:6 adda:3 addb:3 mula:3 mulb:3, op:4 packbits:8 addcc:3 mulcc:3 F:1 X:1 wa:6 wb:6
//
// Branches:
//   addr:32, 1111 0000 cond:4 relative:1 register:1 ra:5 X:1 wa:6 wb:6
//
// 32 Bit Immediates:
//   data:32, 1110 unknown:8 addcc:3 mulcc:3 F:1 X:1 wa:6 wb:6

unsigned tmpthis=0;
unsigned tmpnext=0;
char tmpbuff[256];
#define tmpalloc(sizebytes) ( tmpthis = tmpnext+sizebytes > sizeof(tmpbuff) ? 0 : tmpnext, tmpnext = (tmpthis+sizebytes), &tmpbuff[tmpthis])

const char *qpu_r(uint32_t ra, uint32_t rb, uint32_t adda, uint32_t op, int rotator) {

	if (op == 13) {
		if (rb<48) {
			if (adda==6) return banka_r[ra];
			if (adda==7) return imm[rb];
		}
		else {
			if ((adda<6) && rotator) {
				char *tmp = tmpalloc(32);
				sprintf(tmp, "%s%s", acc_names[adda], imm[rb]);
				return tmp;
			}
			if ((adda==6) && rotator) {
				char *tmp = tmpalloc(32);
				sprintf(tmp, "%s%s", banka_r[ra], imm[rb]);
				return tmp;
			}
			if ((adda==7) && rotator) {
				return "err?";
			}
		}
	}

	if (adda==6) return banka_r[ra];
	if (adda==7) return bankb_r[rb];
	return acc_names[adda];
}

const char *qpu_w_add(uint32_t wa, uint32_t X) {
	return X ? bankb_w[wa] : banka_w[wa];
}

const char *qpu_w_mul(uint32_t wb, uint32_t X) {
	return X ? banka_w[wb] : bankb_w[wb];
}

const char *qpu_unpack_add(uint32_t packmul, uint32_t unpack, uint32_t adda) {
	if ((packmul == 0) && (adda == 6))
		return srcunpackadd[unpack];
	if ((packmul == 1) && (adda == 4))
		return srcunpackmul[unpack];
	return "";
}

const char *qpu_unpack_mul(uint32_t packmul, uint32_t unpack, uint32_t adda) {
	if ((packmul == 0) && (adda == 6))
		return srcunpackmul[unpack];
	if ((packmul == 1) && (adda == 4))
		return srcunpackmul[unpack];
	return "";
}

const char *qpu_pack_add(uint32_t packmul, uint32_t pack, uint32_t wa, uint32_t X) {
	if ((packmul == 0) && (X==0) && (wa<=32)) //todo: what is the real limit on ra range?
		return dstpackadd[pack];
	return "";
}

const char *qpu_pack_mul(uint32_t packmul, uint32_t pack, uint32_t wa, uint32_t X) {
	if ((packmul == 0) && (X==1) && (wa<=32)) //todo: what is the real limit on ra range?
		return dstpackmul[pack];
	if (packmul == 1)
		return dstpackmul[pack];
	return "";
}

void show_qpu_add_mul(uint32_t i0, uint32_t i1)
{
	uint32_t mulop = (i0 >> 29) & 0x7;
	uint32_t addop = (i0 >> 24) & 0x1f;
	uint32_t ra    = (i0 >> 18) & 0x3f;
	uint32_t rb    = (i0 >> 12) & 0x3f;
	uint32_t adda  = (i0 >>  9) & 0x07;
	uint32_t addb  = (i0 >>  6) & 0x07;
	uint32_t mula  = (i0 >>  3) & 0x07;
	uint32_t mulb  = (i0 >>  0) & 0x07;
	uint32_t op    = (i1 >> 28) & 0x0f;
	uint32_t packbits  = (i1 >> 20) & 0xff;
	uint32_t unpacking = (packbits >> 5) & 0x7;
	uint32_t packmul   = (packbits >> 4) & 0x1;
	uint32_t packing   = (packbits >> 0) & 0xf;
	uint32_t addcc = (i1 >> 17) & 0x07;
	uint32_t mulcc = (i1 >> 14) & 0x07;
	uint32_t F     = (i1 >> 13) & 0x01;
	uint32_t X     = (i1 >> 12) & 0x01;
	uint32_t wa    = (i1 >> 6) & 0x3f;
	uint32_t wb    = (i1 >> 0) & 0x3f;

	if (showfields) {
		printf("mulop=%d, addop=%d, ra=%d, rb=%d, adda=%d, addb=%d, mula=%d, mulb=%d, op=%d, unpacking=%d, packmul=%d, packing=%d, addcc=%d, mulcc=%d, F=%d, X=%d, wa=%d, wb=%d  ",
			mulop, addop, ra, rb, adda, addb, mula, mulb, op, unpacking, packmul, packing, addcc, mulcc, F, X, wa, wb);
	}

	uint32_t addF  = (F==1) && (addop != 0) && (addcc != 0);
	uint32_t mulF  = (F==1) && !addF;

	// Instruction formats:
	// op[cc][setf]
	// op[cc][setf] rd[.pack]
	// op[cc][setf] rd[.pack], ra[.unpack]
	// op[cc][setf] rd[.pack], ra[.unpack], rb[.unpack]
	const char *args[] = {
		"", " %s%s", " %s%s, %s%s", " %s%s, %s%s, %s%s"
	};

	uint32_t arity = 3;
	if (addop == 0) {
		arity = 0;
		addcc = 1;
	}
	else if ((adda == addb) && ((addop == 7) || (addop == 8) || (addop == 21) || (addop == 23) || (addop == 24))) {
		arity = 2;
		if (addop == 21) addop = 32;
	}

	// add op always
	printf("%s%s%s", addops[addop], cc[addcc], setf[addF]);
	printf(args[arity], qpu_w_add(wa, X), qpu_pack_add(packmul, packing, wa, X), qpu_r(ra, rb, adda, op, 0), qpu_unpack_add(packmul, unpacking, adda), qpu_r(ra, rb, addb, op, 0), qpu_unpack_add(packmul, unpacking, addb));

	// show mul op if non nop or control op is non nop
        if (mulop || (op != 1)) {

		uint32_t arity = 3;
		if (mulop == 0) {
			arity = 0;
			mulcc = 1;
		}
		else if ((mula == mulb) && (mulop == 4)) {
			arity = 2;
			if (mulop == 4) mulop = 8;
		}

		printf("; %s%s%s", mulops[mulop], cc[mulcc], setf[mulF]);
		///* 000003a0: 36020037 18025841 */  xor r1, r0, r0; fmul ra1, ra0, unif
		printf(args[arity], qpu_w_mul(wb, X), qpu_pack_mul(packmul, packing, wb, X), qpu_r(ra, rb, mula, op, 1), qpu_unpack_mul(packmul, unpacking, mula), qpu_r(ra, rb, mulb, op, 1), qpu_unpack_mul(packmul, unpacking, mulb));
	}

	// show control op if non nop
	if ((op != 1) && (op != 13)) {
		printf("; %s", ops[op]);
	}
	printf("\n");

}

void show_qpu_branch(uint32_t i0, uint32_t i1)
{
	uint32_t addr     = i0;
	uint32_t unknown  = (i1 >> 24) & 0x0f;
	uint32_t cond     = (i1 >> 20) & 0x0f;
	uint32_t pcrel    = (i1 >> 19) & 0x01;
	uint32_t addreg   = (i1 >> 18) & 0x01;
	uint32_t ra       = (i1 >> 13) & 0x1f;
	uint32_t X        = (i1 >> 12) & 0x01;
	uint32_t wa       = (i1 >>  6) & 0x3f;
	uint32_t wb       = (i1 >>  0) & 0x3f;

	if (showfields) {
		printf("branch addr=0x%08x, unknown=%x, cond=%02d, pcrel=%x, addreg=%x, ra=%02d, X=%x, wa=%02d, wb=%02x\n",
			addr, unknown, cond, pcrel, addreg, ra, X, wa, wb);
	}
	// branch: b[link][cc] [linkreg,] [basedreg,]
	if (wa==39) 
		printf("%s%s %s, %s%+d", pcrel ? "brr" : "bra", bcc[cond], qpu_w_mul(wb, X), addreg ? qpu_r(ra, ra, 6, (i1 >> 28)&0xf, 0) : "", addr);
	else if (wb==39)
		printf("%s%s %s, %s%+d", pcrel ? "brr" : "bra", bcc[cond], qpu_w_add(wa, X), addreg ? qpu_r(ra, ra, 6, (i1 >> 28)&0xf, 0) : "", addr);
	else 
		printf("%s%s %s, %s, %s%+d", pcrel ? "brr" : "bra", bcc[cond], qpu_w_add(wa, X), qpu_w_mul(wb, X), addreg ? qpu_r(ra, ra, 6, (i1 >> 28)&0xf, 0) : "", addr);
	
	if (!addreg) printf(" // 0x%08x", base+addr+8*4);
	printf("\n");

}

const char *qpu_ldi_unpack(uint32_t unpack, uint32_t data)
{
	char *tmp = tmpalloc(128);
	// unpack = 1 (2 bit signed vectors), 3 = (2 bit unsigned vectors);
	if ((unpack==1) || (unpack==3)) {
		int d[16];
		for (int i=0; i<16; i++) {
			d[i] = ((data >> (16+i-1))&0x2) | ((data >> i) & 0x1);
			if ((unpack == 1) && d[i] &0x2)
				d[i] |= 0xfffffffc;
		}
		sprintf(tmp, "[%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d]",
			d[0], d[1], d[2], d[3], d[4], d[5], d[6], d[7],
			d[8], d[9], d[10], d[11], d[12], d[13], d[14], d[15]);
	}
	else {
		sprintf(tmp, "0x%08x", data);
	}
	return tmp;
}

void show_qpu_imm32(uint32_t i0, uint32_t i1)
{
	uint32_t data = i0;
	uint32_t packbits  = (i1 >> 20) & 0xff;
	uint32_t unpacking = (packbits >> 5) & 0x7;
	uint32_t packmul   = (packbits >> 4) & 0x1;
	uint32_t packing   = (packbits >> 0) & 0xf;
	uint32_t addcc   = (i1 >> 17) & 0x07;
	uint32_t mulcc   = (i1 >> 14) & 0x07;
	uint32_t F       = (i1 >> 13) & 0x01;
	uint32_t X       = (i1 >> 12) & 0x01;
	uint32_t wa      = (i1 >>  6) & 0x3f;
	uint32_t wb      = (i1 >>  0) & 0x3f;

	if (showfields) {
		printf("imm32 data=0x%08x, unpacking=0x%d, packmul=%d, packing=%d, addcc=%x, mulcc=%x, F=%x, X=%x, wa=%02d, wb=%02d\n",
			data, unpacking, packmul, packing, addcc, mulcc, F, X, wa, wb);
	}

	const char *inst = ops[(i1 >> 28) & 0xf];

	if (unpacking & 0x4) {
		inst = (data & 0x10) ? "sacq" : "srel";
		if (data <= 0x1f)
			data = data & 0xffffffef;
	}

	// addop: op[cc][setf] rd[.pack?], immediate
	if (packbits==0 && addcc==0 && wa==39)
		printf("nop");
	else
		printf("%s%s%s %s%s, %s", inst, cc[addcc], setf[F], qpu_w_add(wa, X), qpu_pack_add(packmul, packing, wa, X), qpu_ldi_unpack(unpacking, data));

	// mulop: [op[cc][setf] rd[.pack?], immediate
	if (mulcc) {
		printf("; %s%s%s %s%s, %s", inst, cc[mulcc], setf[F], qpu_w_mul(wb, X), qpu_pack_mul(packmul, packing, wa, X), qpu_ldi_unpack(unpacking, data));
	}

	printf("\n");
}

void show_qpu_inst(uint32_t *inst) {
	uint32_t i0 = inst[0];
	uint32_t i1 = inst[1];

	int op = (i1 >> 28) & 0xf;
	if (op<14) show_qpu_add_mul(i0, i1);
	if (op==14) show_qpu_imm32(i0, i1);
	if (op==15) show_qpu_branch(i0, i1);
}

void show_qpu_fragment(uint32_t *inst, int length) {
	uint32_t i = 0;
	for(;i<length; i+=2) {
		base = i*4;
		printf("/* %08x: %08x %08x */  ", i*4, inst[i], inst[i+1]); show_qpu_inst(&inst[i]);
	}
	printf("\n");
}

