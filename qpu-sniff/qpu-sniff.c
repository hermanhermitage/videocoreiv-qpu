/* 
 * QPU Sniff
 *
 * Program to scan memory looking for QPU program fragments.
 *   - We try and avoid scanning the start.elf image and any early buffers it creates (VC_MEM_IMAGE)
 *   - Needs to run as root.
 *   - Tested on 512MB Pi, but hopefully works on 256MB as well.
 *   - Tested under Raspbian only
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <sys/mman.h>
#include <sys/ioctl.h>
#include <unistd.h>

#include <stdio.h>
#include <errno.h>
#include <string.h>

#include <linux/ioctl.h>
#define VC_MEM_IOC_MAGIC 'v'
#define VC_MEM_IOC_MEM_PHYS_ADDR    _IOR( VC_MEM_IOC_MAGIC, 0, unsigned long )
#define VC_MEM_IOC_MEM_SIZE         _IOR( VC_MEM_IOC_MAGIC, 1, unsigned int )
#define VC_MEM_IOC_MEM_BASE         _IOR( VC_MEM_IOC_MAGIC, 2, unsigned int )
#define VC_MEM_IOC_MEM_LOAD         _IOR( VC_MEM_IOC_MAGIC, 3, unsigned int )

// Space at the end of memory we assume is holding code and fixed start.elf buffers
#define VC_MEM_IMAGE 18706228

#define MIN(x,y) ((x)<(y)?(x):(y))
static int debug = 0;


// QPU Instruction matching

int is_qpu_nop(volatile unsigned int *inst) {
	return (inst[0] == 0x009e7000) && (inst[1] == 0x100009e7);
}

int is_qpu_end(volatile unsigned int *inst) {
	return (inst[0] == 0x009e7000) && (inst[1] == 0x300009e7) 
		&& (inst[2] == 0x009e7000) && (inst[3] == 0x100009e7)
		&& (inst[4] == 0x009e7000) && ((inst[5] == 0x100009e7) || (inst[5] == 0x500009e7));
}


// Scanner
//   Todo: Build a list of matches, wait a 15 seconds or so, rescan and spit out differences, and repeat.

int main(int argc, char * argv[])
{
	int fd = open("/dev/vc-mem", O_RDWR | O_SYNC);
	if (fd == -1)
	{
		printf("Unable to open /dev/vc-mem, run as: sudo %s\n", argv[0]);
		return 1;
	}

	unsigned long address, size, base, load;
	ioctl(fd, VC_MEM_IOC_MEM_PHYS_ADDR, &address);
	ioctl(fd, VC_MEM_IOC_MEM_SIZE, &size);
	ioctl(fd, VC_MEM_IOC_MEM_BASE, &base);
	ioctl(fd, VC_MEM_IOC_MEM_LOAD, &load);

	volatile unsigned int *vc = (volatile unsigned int *)mmap( 0, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (vc == (unsigned int *)-1)
	{
		printf("mmap failed %s\n", strerror(errno));
		return -1;
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
