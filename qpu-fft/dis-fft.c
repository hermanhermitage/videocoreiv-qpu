/* 
 * FFT DIS
 *   - Tested under Raspbian only
 *
 * fft-dis
 * 
 *   Disassemble fft fragments.
 *
 */

#include <stdio.h>
#include <stdint.h>

#include "../qpu-sniff/qpudis.h"

#include "gpu_fft_shaders.c"

unsigned int  gpu_fft_shader_size(int);
unsigned int *gpu_fft_shader_code(int);

void copyright() {
	puts(
		"/*\n"
		"Copyright (c) 2013, Andrew Holme.\n"
		"All rights reserved.\n"
		"\n"
		"Redistribution and use in source and binary forms, with or without\n"
		"modification, are permitted provided that the following conditions are met:\n"
		"    * Redistributions of source code must retain the above copyright\n"
		"      notice, this list of conditions and the following disclaimer.\n"
		"    * Redistributions in binary form must reproduce the above copyright\n"
		"      notice, this list of conditions and the following disclaimer in the\n"
		"      documentation and/or other materials provided with the distribution.\n"
		"    * Neither the name of the copyright holder nor the\n"
		"      names of its contributors may be used to endorse or promote products\n"
		"      derived from this software without specific prior written permission.\n"
		"\n"
		"THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND\n"
		"ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED\n"
		"WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\n"
		"DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY\n"
		"DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES\n"
		"(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;\n"
		"LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND\n"
		"ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n"
		"(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS\n"
		"SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n"
		"*/\n"
	);
}

int main(int argc, char **argv) {
	// show_qpu_frament(address, instruction count);
	for (int i=8; i<17; i++) {
		int size = 1<<i;
		char filename[256];
		sprintf(filename, "shader_%d%s.s", size<1024?size:size/1024, size<1024?"":"k");
		FILE *fp = freopen (filename, "w", stdout);

		puts(
			"/*\n"
			"Disassembly of Andrew Holme's QPU FFT for Raspberry Pi.\n"
			"From: https://github.com/raspberrypi/firmware/tree/master/opt/vc/src/hello_pi/hello_fft\n"
			"*/\n"
		);
		copyright();
		printf("shader_%d%s:\n", (1<<i)<=512?(1<<i):(1<<i)/1024, (1<<i)<=512?"":"k");
		show_qpu_fragment(gpu_fft_shader_code(i), gpu_fft_shader_size(i)/4);
		printf("\n");
		fclose(fp);
	}
}

