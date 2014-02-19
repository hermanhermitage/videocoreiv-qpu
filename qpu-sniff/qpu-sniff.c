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
#include "testgl.h"
#include "qpudis.h"

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


uint32_t *file_load(const char *filename, uint32_t *filesize) {
	uint32_t *memory = 0;
	FILE *f = fopen(filename, "rb");
	if (f) {
		fseek(f, 0, SEEK_END);
		long size = ftell(f);
		fseek(f, 0, SEEK_SET);
		memory = malloc(size+1);
		memory[size] = 0;
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
	printf("(%s %08x %d)\n", type, data, size);
	for (; i<size/4; i+=2) {
		unsigned char *u8 = (unsigned char *)&data[i];
		for (int j=0;j<8;j++) printf("%c", printable(u8[j]));
		printf(" %08x %08x", data[i+0], data[i+1]);
		float *f = (float *)&data[i];
		printf(" %10.4g %10.4g\n", f[0], f[1]);
	}
	printf("\n");
}

void show_fragment(char *type, unsigned int original_address, unsigned int *data, int size) {
	if (strcmp("'shader code'", type)==0) {
		printf("# (%s %08x %d)\n", type, original_address, size);
		show_qpu_fragment(data, size/4);
	} 
	else {
		show_raw_fragment(type, data, size);
	}	
}

void vcdbgqpuscan(char *argv[]) {
	vcdbg_scan_relocs(0, show_fragment);
}


void testgl(char *vs_filename, char *fs_filename) {
	char *vs = (char *)file_load(vs_filename, 0);
	char *fs = (char *)file_load(fs_filename, 0);
	if (vs && fs) {
		printf("/*\n");
		printf("\n%s:\n%s", vs_filename, vs);
		printf("\n%s:\n%s", fs_filename, fs);
		printf("*/\n");
		begin_gl_test(1);
		char *vs_log=0, *fs_log=0, *program_log=0;
		if (run_gl_test(vs, fs, &vs_log, &fs_log, &program_log)) {
			printf("Failed to run shaders.\n");
			if (vs_log) printf("VS:\n%s\n", vs_log);
			if (fs_log) printf("FS:\n%s\n", fs_log);
			if (program_log) printf("Program:\n%s\n", program_log);
		}
		else {
			char *relocs[] = {"'shader code'", 0};
			vcdbg_scan_relocs(relocs, show_fragment);
		}
		end_gl_test();
	}
	file_unload((void *)vs);
	file_unload((void *)fs);
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
		else if (strcmp(argv[i], "--testgl")==0) {
			testgl(argv[++i], argv[++i]);
		}
		else {
usage:
			printf("Usage:\n  %s [--qpuscan] [--qpuscan-old] [--qpudis <filename>] [[--testgl <shader.vs> <shader.fs>]\n", argv[0]);
			exit(-1);
		}
	}
}
