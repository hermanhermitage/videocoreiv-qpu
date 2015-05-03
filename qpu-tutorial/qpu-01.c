#include <string.h>
#include <stdio.h>

#include "mailbox.h"

#define GPU_QPUS 1

#define GPU_MEM_FLG 0xC // cached=0xC; direct=0x4
#define GPU_MEM_MAP 0x0 // cached=0x0; direct=0x20000000

unsigned int program[] = {
#include "qpu-01.hex"
};

#define as_gpu_address(x) (unsigned) gpu_pointer + ((void *)x - arm_pointer)

int main(int argc, char *argv[]) {

	int mb = mbox_open();

	/* Enable QPU for execution */
	int qpu_enabled = !qpu_enable(mb, 1);
	if (!qpu_enabled) {
		printf("Unable to enable QPU.  Check your firmware is latest.");
		goto cleanup;
	}

	/* Allocate GPU memory and map it into ARM address space */
	unsigned size = 4096;
	unsigned align = 4096;
    	unsigned handle = mem_alloc(mb, size, align, GPU_MEM_FLG);
	if (!handle) {
		printf("Failed to allocate GPU memory.");
		goto cleanup;
	}
	void *gpu_pointer = (void *)mem_lock(mb, handle);
	void *arm_pointer = mapmem(BUS_TO_PHYS((unsigned)gpu_pointer+GPU_MEM_MAP), size);

	unsigned *p = (unsigned *)arm_pointer;

	/*
	   +---------------+ <----+
	   |  QPU Code     |      |
	   |  ...          |      |
	   +---------------+ <--+ |
	   |  Uniforms     |    | |
	   +---------------+    | |
	   |  QPU0 Uniform -----+ |
	   |  QPU0 Start   -------+
	   |  ...                 |
	   |  QPUn Uniform        |
	   |  QPUn PC      -------+
	   +---------------+
	*/

	/* Copy QPU program into GPU memory */
	unsigned *qpu_code = p;
	memcpy(p, program, sizeof program);
	p += (sizeof program)/(sizeof program[0]);

	/* Build Uniforms */
	unsigned *qpu_uniform = p;
	*p++ = 1;
	
	/* Build QPU Launch messages */
	unsigned *qpu_msg = p;
	*p++ = as_gpu_address(qpu_uniform);
	*p++ = as_gpu_address(qpu_code);

	int i;
	for (i=0; i<16+1+2; i++) {
		printf("%08x: %08x\n", gpu_pointer+i*4, ((unsigned *)arm_pointer)[i]);
	}
	printf("qpu exec %08x\n", gpu_pointer + ((void *)qpu_msg - arm_pointer));

	/* Launch QPU program and block till its done */
    	unsigned r = execute_qpu(mb, GPU_QPUS, as_gpu_address(qpu_msg), 1, 10000);
	printf("%d\n", r);

cleanup:
	/* Release GPU memory */
	if (arm_pointer) {
		unmapmem(arm_pointer, size);
	}
    	if (handle) {
		mem_unlock(mb, handle);
    		mem_free(mb, handle);
	}
	
	/* Release QPU */
	if (qpu_enabled) {
	    	qpu_enable(mb, 0);
	}
	
	/* Release mailbox */
	mbox_close(mb);

}

