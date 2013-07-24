/* 
 * QPU Sniff
 *   - Tested under Raspbian only
 *
 * qpu-sniff --qpudis <fragment-file>
 * 
 *   Disassemble a qpu fragment.
 *
 *
 * qpu-sniff --qpuscan
 *
 *   To scan memory looking for QPU program fragments.
 *     - We try and avoid scanning the start.elf image and any early buffers it creates (VC_MEM_IMAGE)
 *     - Needs to run as root.
 *     - Tested on 512MB Pi, but hopefully works on 256MB as well.
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <sys/mman.h>
#include <sys/ioctl.h>
#include <unistd.h>

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>

#include <linux/ioctl.h>
#define VC_MEM_IOC_MAGIC 'v'
#define VC_MEM_IOC_MEM_PHYS_ADDR    _IOR( VC_MEM_IOC_MAGIC, 0, unsigned long )
#define VC_MEM_IOC_MEM_SIZE         _IOR( VC_MEM_IOC_MAGIC, 1, uint32_t )
#define VC_MEM_IOC_MEM_BASE         _IOR( VC_MEM_IOC_MAGIC, 2, uint32_t )
#define VC_MEM_IOC_MEM_LOAD         _IOR( VC_MEM_IOC_MAGIC, 3, uint32_t )

#include "vcdbg_qpu.h"

// Space at the end of memory we assume is holding code and fixed start.elf buffers
#define VC_MEM_IMAGE 18706228

#define MIN(x,y) ((x)<(y)?(x):(y))
static int debug = 0;
static uint8_t test;

// QPU Instruction matching

int is_qpu_nop(volatile uint32_t *inst) {
	return (inst[0] == 0x009e7000) && (inst[1] == 0x100009e7);
}

int is_qpu_end(volatile uint32_t *inst) {
	return (inst[0] == 0x009e7000) && (inst[1] == 0x300009e7) 
		&& (inst[2] == 0x009e7000) && (inst[3] == 0x100009e7)
		&& (inst[4] == 0x009e7000) && ((inst[5] == 0x100009e7) || (inst[5] == 0x500009e7));
}

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

char *acc_names[8];
char *banka_names[64]; 
char *bankb_names[64]; 
char *banka_w[64];
char *bankb_w[64];
char *ops[16];
char *addops[32];
char *mulops[8];
char *cc[8];

void qpu_dis_init() {
	for (int i=0; i<64; i++) {
		if (i<8)
			sprintf(acc_names[i] = malloc(4), "A%d", i);
		sprintf(banka_names[i] = malloc(5), "%s%d", i<32?"ra":"io", i);
		sprintf(bankb_names[i] = malloc(5), "%s%d", i<32?"rb":"io", i);
		sprintf(banka_w[i] = malloc(5), "%s%d", i<32?"ra":"io", i);
		sprintf(bankb_w[i] = malloc(5), "%s%d", i<32?"rb":"io", i);
		if (i<16)
			sprintf(ops[i] = malloc(5), "op%02d", i);
		if (i<32)
			sprintf(addops[i] = malloc(8), "addop%02d", i);
		if (i<8)
			sprintf(mulops[i] = malloc(8), "mulop%02d", i);
		if (i<8)
			sprintf(cc[i] = malloc(6), "<cc%d>", i);
	}
}

const char *qpu_r(uint32_t ra, uint32_t rb, uint32_t adda) {
	if (adda==6) return banka_names[ra];
	if (adda==7) return bankb_names[rb];
	return acc_names[adda];
}

const char *qpu_w_add(uint32_t wa, uint32_t wb, uint32_t X) {
	return X ? bankb_w[wa] : banka_w[wa];
}

const char *qpu_w_mul(uint32_t wa, uint32_t wb, uint32_t X) {
	return X ? banka_w[wb] : bankb_w[wb];
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
	uint32_t packbits = (i1 >> 20) & 0xff;
	uint32_t addcc = (i1 >> 17) & 0x07;
	uint32_t mulcc = (i1 >> 14) & 0x07;
	uint32_t F     = (i1 >> 13) & 0x01;
	uint32_t X     = (i1 >> 12) & 0x01;
	uint32_t wa    = (i1 >> 6) & 0x3f;
	uint32_t wb    = (i1 >> 0) & 0x3f;
	printf("ra=%02d, rb=%02d, adda=%x, addb=%x, mula=%x, mulb=%x, wa=%02d, wb=%02d, F=%x, X=%x, packbits=0x%02x; %s%s %s, %s, %s; %s%s %s, %s, %s; %s\n",
			ra, rb, adda, addb, mula, mulb, wa, wb, F, X, packbits,
			addops[addop], cc[addcc], qpu_w_add(wa, wb, X), qpu_r(ra, rb, adda), qpu_r(ra, rb, addb),
			mulops[mulop], cc[mulcc], qpu_w_mul(wa, wb, X), qpu_r(ra, rb, mula), qpu_r(ra, rb, mulb),
			ops[op]);
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
	printf("addr=0x%08x, unknown=%x, cond=%02d, pcrel=%x, addreg=%x, ra=%02d, X=%x, wa=%02d, wb=%02x\n",
			addr, unknown, cond, pcrel, addreg, ra, X, wa, wb);
}

void show_qpu_imm32(uint32_t i0, uint32_t i1)
{
	uint32_t data = i0;
	uint32_t unknown = (i1 >> 20) & 0xff;
	uint32_t addcc   = (i1 >> 17) & 0x07;
	uint32_t mulcc   = (i1 >> 14) & 0x07;
	uint32_t F       = (i1 >> 13) & 0x01;
	uint32_t X       = (i1 >> 12) & 0x01;
	uint32_t wa      = (i1 >>  6) & 0x3f;
	uint32_t wb      = (i1 >>  0) & 0x3f;
	printf("data=0x%08x, unknown=0x%02x, addcc=%x, mulcc=%x, F=%x, X=%x, wa=%02d, wb=%02d\n",
			data, unknown, addcc, mulcc, F, X, wa, wb);
}

void show_qpu_inst(uint32_t *inst) {
	uint32_t i0 = inst[0];
	uint32_t i1 = inst[1];

	int op = (i1 >> 24) & 0xf;
	if (op<14) show_qpu_add_mul(i0, i1);
	if (op==14) show_qpu_branch(i0, i1);
	if (op==15) show_qpu_imm32(i0, i1);
}

void show_qpu_fragment(uint32_t *inst, int length) {
	uint32_t i = 0;
	for(;i<length; i+=2) {
		printf("%08x: %08x %08x ", i, inst[i], inst[i+1]); show_qpu_inst(&inst[i]);
	}
}

uint32_t *file_load(const char *filename, uint32_t *filesize) {
	uint32_t *memory = 0;
	FILE *f = fopen(filename, "rb");
	if (f) {
		fseek(f, 0, SEEK_END);
		long size = ftell(f);
		fseek(f, 0, SEEK_SET);
		memory = malloc(size);
		if ((memory==0) || (fread(memory, size, 1, f)==0)) {
			free(memory);
			memory = 0;
		}
		fclose(f);
		if (filesize)
			*filesize = size;
	}
	return memory;
}

void file_unload(uint32_t *data) {
	free(data);
}

void qpu_dis_file(const char *filename) {
	qpu_dis_init();
	printf("Disassembling %s\n", filename);
	uint32_t size;
	uint32_t *fragment = file_load(filename, &size);
	if (fragment==0) {
		printf("Couldn't read fragment %s\n", filename);
		return;
	}
	printf("Fragment %s, size %d\n", filename, size/4);
	show_qpu_fragment(fragment+8, (size/4)-8);
	file_unload(fragment);
}

// Scanner
//   Todo: Build a list of matches, wait a 15 seconds or so, rescan and spit out differences, and repeat.

void qpuscan(char *argv[]) {
	int fd = open("/dev/vc-mem", O_RDWR | O_SYNC);
	if (fd == -1)
	{
		printf("Unable to open /dev/vc-mem, run as: sudo %s\n", argv[0]);
		return;
	}

	unsigned long address, size, base, load;
	ioctl(fd, VC_MEM_IOC_MEM_PHYS_ADDR, &address);
	ioctl(fd, VC_MEM_IOC_MEM_SIZE, &size);
	ioctl(fd, VC_MEM_IOC_MEM_BASE, &base);
	ioctl(fd, VC_MEM_IOC_MEM_LOAD, &load);

	volatile uint32_t *vc = (volatile uint32_t *)mmap( 0, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (vc == (uint32_t *)-1)
	{
		printf("mmap failed %s\n", strerror(errno));
		return;
	}

	if (debug) {
		printf("VC_MEM_IOC_MEM_PHYS_ADDR = %08x\n", address);
		printf("VC_MEM_IOC_MEM_SIZE = %08x\n", size);
		printf("VC_MEM_IOC_MEM_BASE = %08x\n", base);
		printf("VC_MEM_IOC_MEM_LOAD = %08x\n", load);
		printf("vc = %08\n", vc);
	}

	printf("Scanning for QPU code fragments...\n");

	for (int i = 0; i < (size-VC_MEM_IMAGE)/4; i++)
	{
		if (is_qpu_end(&vc[i])) {
			printf("%08x:", i*4);
			for (int j=0; j<4; j++) {
				printf(" %08x %08x", vc[i+j*2], vc[i+j*2+1]);
			}
			printf("\n");
		}
	}

	close(fd);
}

char printable(char c) {
	return ((c>=32) && (c<127)) ? c : '.';
}
void show_raw_fragment(char *type, unsigned int *data, int size) {
	int i = 0;
	printf("type = %s\n", type);
	printf("size = %d\n", size);
	for (; i<size/4; i+=2) {
		unsigned char *u8 = (unsigned char *)&data[i];
		for (int j=0;j<8;j++) printf("%c", printable(u8[j]));
		printf(" %08x %08x", data[i+0], data[i+1]);
		float *f = (float *)&data[i];
		printf(" %10.4g %10.4g\n", f[0], f[1]);
	}
	printf("\n");
}

void show_fragment(char *type, unsigned int *data, int size) {
	if (strcmp("'shader code'", type)==0) {
		printf("%s:\n", type);
		show_qpu_fragment(data, size/4);
	} 
	else {
		show_raw_fragment(type, data, size);
	}	
}

void vcdbgqpuscan(char *argv[]) {
	qpu_dis_init();
	vcdbg_scan_relocs(0, show_fragment);
}

int main(int argc, char * argv[])
{
	if (argc==1)
		goto usage;

	for (int i=1; i<argc; i++)
	{
		if (strcmp(argv[i], "--qpuscan-old")==0) {
			qpuscan(argv);
		}
		else if (strcmp(argv[i], "--qpuscan")==0) {
			vcdbgqpuscan(argv);
		}
		else if (strcmp(argv[i], "--qpudis")==0) {
			qpu_dis_file(argv[++i]);
		}
		else {
usage:
			printf("Usage:\n  %s [--qpuscan] [--qpuscan-old] [--qpudis <filename>]\n", argv[0]);
			exit(-1);
		}
	}
}
